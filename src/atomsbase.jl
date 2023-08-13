import AtomsBase
using AtomsBase: AbstractSystem, FlexibleSystem
using Unitful
using UnitfulAtomic
import PeriodicTable


function AtomsBase.FlexibleSystem(frame::Chemfiles.Frame)
    atoms = map(1:length(frame), frame) do i, atom
        pos = Chemfiles.positions(frame)[:, i]u"Å"
        if Chemfiles.has_velocities(frame)
            velocity = Chemfiles.velocities(frame)[:, i]u"Å/ps"
        else
            velocity = zeros(3)u"Å/ps"
        end

        # Collect atomic properties
        atprops = Dict(
            :atomic_mass     => Chemfiles.mass(atom)u"u",
            :atomic_symbol   => Symbol(Chemfiles.name(atom)),
            :atomic_number   => Chemfiles.atomic_number(atom),
            :charge          => Chemfiles.charge(atom)u"e_au",
            :covalent_radius => Chemfiles.covalent_radius(atom)u"Å",
            :vdw_radius      => Chemfiles.vdw_radius(atom)*u"Å",
        )
        for prop in Chemfiles.list_properties(atom)
            symbol = Symbol(prop)
            if !hasfield(AtomsBase.Atom, symbol) && !(symbol in keys(atprops))
                atprops[symbol] = Chemfiles.property(atom, prop)
            end
        end

        AtomsBase.Atom(Chemfiles.atomic_number(atom), pos, velocity; atprops...)
    end

    # Collect system properties
    sysprops = Dict{Symbol,Any}()
    for prop in Chemfiles.list_properties(frame)
        if hasfield(FlexibleSystem, Symbol(prop))
            continue
        elseif prop == "charge"
            value = Chemfiles.property(frame, "charge")
            value isa AbstractString && (value = parse(Float64, value))  # Work around a bug
            sysprops[:charge] = Float64(value)u"e_au"
        elseif prop == "multiplicity"
            value = Chemfiles.property(frame, "multiplicity")
            value isa AbstractString && (value = parse(Float64, value))  # Work around a bug
            sysprops[:multiplicity] = Int(value)
        else
            sysprops[Symbol(prop)] = Chemfiles.property(frame, prop)
        end
    end

    # Construct flexible system
    cell_shape = Chemfiles.shape(Chemfiles.UnitCell(frame))
    if cell_shape == Chemfiles.Infinite
        AtomsBase.isolated_system(atoms; sysprops...)
    else
        @assert cell_shape in (Chemfiles.Triclinic, Chemfiles.Orthorhombic)
        box = collect(eachrow(Chemfiles.matrix(Chemfiles.UnitCell(frame))))u"Å"
        AtomsBase.periodic_system(atoms, box; sysprops...)
    end
end
AtomsBase.AbstractSystem(frame::Chemfiles.Frame) = FlexibleSystem(frame)

Base.convert(::Type{AbstractSystem}, frame::Chemfiles.Frame) = AbstractSystem(frame)
Base.convert(::Type{FlexibleSystem}, frame::Chemfiles.Frame) = FlexibleSystem(frame)


function Base.convert(::Type{Frame}, system::AbstractSystem{D}) where {D}
    D != 3 && @warn "1D and 2D systems not yet fully supported."
    frame = Chemfiles.Frame()

    # Cell and boundary conditions
    if AtomsBase.bounding_box(system) == AtomsBase.infinite_box(D)  # System is infinite
        cell = Chemfiles.UnitCell(zeros(3, 3))
        Chemfiles.set_shape!(cell, Chemfiles.Infinite)
        Chemfiles.set_cell!(frame, cell)
    else
        if any(!isequal(AtomsBase.Periodic()), AtomsBase.boundary_conditions(system))
            @warn("Ignoring specified boundary conditions: Chemfiles only supports " *
                  "infinite or all-periodic boundary conditions.")
        end

        box = zeros(3, 3)
        for i = 1:D
            box[i, 1:D] = ustrip.(u"Å", AtomsBase.bounding_box(system)[i])
        end
        cell = Chemfiles.UnitCell(box)
        Chemfiles.set_cell!(frame, cell)
    end

    if any(atom -> !ismissing(AtomsBase.velocity(atom)), system)
        Chemfiles.add_velocities!(frame)
    end
    for atom in system
        # We are using the atomic_number here, since in AtomsBase the atomic_symbol
        # can be more elaborate (e.g. D instead of H or "¹⁸O" instead of just "O").
        # In Chemfiles this is solved using the "name" of an atom ... to which we
        # map the AtomsBase.atomic_symbol.
        cf_atom = Chemfiles.Atom(PeriodicTable.elements[atomic_number(atom)].symbol)
        Chemfiles.set_name!(cf_atom, string(AtomsBase.atomic_symbol(atom)))
        Chemfiles.set_mass!(cf_atom, ustrip(u"u", AtomsBase.atomic_mass(atom)))
        @assert Chemfiles.atomic_number(cf_atom) == AtomsBase.atomic_number(atom)

        for (k, v) in pairs(atom)
            if k in (:atomic_symbol, :atomic_number, :atomic_mass, :velocity, :position)
                continue  # Dealt with separately
            elseif k == :charge
                Chemfiles.set_charge!(cf_atom, ustrip(u"e_au", v))
            elseif k == :vdw_radius
                if v != Chemfiles.vdw_radius(cf_atom)u"Å"
                    @warn "Atom vdw_radius in Chemfiles cannot be mutated"
                end
            elseif k == :covalent_radius
                if v != Chemfiles.covalent_radius(cf_atom)u"Å"
                    @warn "Atom covalent_radius in Chemfiles cannot be mutated"
                end
            elseif v isa Union{Bool, Float64, String, Vector{Float64}}
                Chemfiles.set_property!(cf_atom, string(k), v)
            else
                @warn "Ignoring unsupported property type $(typeof(v)) in Chemfiles for key $k"
            end
        end

        pos = convert(Vector{Float64}, ustrip.(u"Å", position(atom)))
        if ismissing(AtomsBase.velocity(atom))
            Chemfiles.add_atom!(frame, cf_atom, pos)
        else
            vel = convert(Vector{Float64}, ustrip.(u"Å/ps", AtomsBase.velocity(atom)))
            Chemfiles.add_atom!(frame, cf_atom, pos, vel)
        end
    end

    for (k, v) in pairs(system)
        if k in (:bounding_box, :boundary_conditions)
            continue  # Already dealt with
        elseif k in (:charge, )
            Chemfiles.set_property!(frame, string(k), Float64(ustrip(u"e_au", v)))
        elseif k in (:multiplicity, )
            Chemfiles.set_property!(frame, string(k), Float64(v))
        elseif v isa Union{Bool, Float64, String, Vector{Float64}}
            Chemfiles.set_property!(frame, string(k), v)
        else
            @warn "Ignoring unsupported property type $(typeof(v)) in Chemfiles for key $k"
        end
    end

    frame
end
