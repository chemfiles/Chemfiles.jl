import AtomsBase
using AtomsBase: AbstractSystem, FlexibleSystem, ChemicalSpecies, PeriodicCell, IsolatedCell
using Unitful
using UnitfulAtomic


"""
Construct an AtomsBase `FlexibleSystem` from a Chemfiles Frame.
"""
function AtomsBase.FlexibleSystem(frame::Chemfiles.Frame)
    atoms = map(1:length(frame), frame) do i, atom
        pos = Chemfiles.positions(frame)[:, i]u"Å"
        velocity_arg = ()
        if Chemfiles.has_velocities(frame)
            velocity_arg = (Chemfiles.velocities(frame)[:, i]u"Å/ps", )
        end

        species = ChemicalSpecies(Chemfiles.atomic_number(atom);
                                  atom_name=Symbol(Chemfiles.name(atom)))
        if Symbol(species) != Symbol(Chemfiles.type(atom))
            @warn("Ignoring non-standard atom type $(Chemfiles.type(atom)) " *
                  "for atom $i.")
        end

        # Collect atomic properties
        atprops = Dict(
            :mass            => Chemfiles.mass(atom)u"u",
            :species         => ChemicalSpecies(Chemfiles.atomic_number(atom)),
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

        AtomsBase.Atom(Chemfiles.atomic_number(atom), pos, velocity_arg...; atprops...)
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
        cell = IsolatedCell(3)
    else
        @assert cell_shape in (Chemfiles.Triclinic, Chemfiles.Orthorhombic)
        cell_vectors = collect(eachrow(Chemfiles.matrix(Chemfiles.UnitCell(frame))))u"Å"
        cell = PeriodicCell(; cell_vectors, periodicity=(true, true, true))
    end

    AtomsBase.FlexibleSystem(atoms, cell; sysprops...)
end

"""
Construct an AtomsBase `AbstractSystem` from a Chemfiles Frame.
"""
AtomsBase.AbstractSystem(frame::Chemfiles.Frame) = FlexibleSystem(frame)

"""
Convert a Chemfiles Frame to an AtomsBase `AbstractSystem`
"""
Base.convert(::Type{AbstractSystem}, frame::Chemfiles.Frame) = AbstractSystem(frame)

"""
Convert a Chemfiles Frame to an AtomsBase `FlexibleSystem`
"""
Base.convert(::Type{FlexibleSystem}, frame::Chemfiles.Frame) = FlexibleSystem(frame)


function Base.convert(::Type{Frame}, system::AbstractSystem{D}) where {D}
    D != 3 && @warn "1D and 2D systems not yet fully supported."
    frame = Chemfiles.Frame()

    # Cell and boundary conditions
    if AtomsBase.cell(system) isa IsolatedCell
        cell = Chemfiles.UnitCell(zeros(3, 3))
        Chemfiles.set_shape!(cell, Chemfiles.Infinite)
        Chemfiles.set_cell!(frame, cell)
    else
        if !all(AtomsBase.periodicity(system))
            @warn("Ignoring specified boundary conditions: Chemfiles only supports " *
                  "infinite or all-periodic boundary conditions.")
        end

        box = zeros(3, 3)
        for i = 1:D
            box[i, 1:D] = ustrip.(u"Å", AtomsBase.cell_vectors(system)[i])
        end
        cell = Chemfiles.UnitCell(box)
        Chemfiles.set_cell!(frame, cell)
    end

    if any(atom -> !ismissing(AtomsBase.velocity(atom)), system)
        Chemfiles.add_velocities!(frame)
    end
    for atom in system
        # We are using the symbol of the symbol from the element here
        # instead of the AtomsBase.atomic_symbol because the latter may have
        # isotope information attached (e.g. C13), which Chemfiles cannot parse.
        cf_atom = Chemfiles.Atom(string(element(atom).symbol))
        Chemfiles.set_name!(cf_atom, string(AtomsBase.atom_name(atom)))
        Chemfiles.set_mass!(cf_atom, ustrip(u"u", AtomsBase.mass(atom)))

        if string(atomic_symbol(atom)) != string(element(atom).symbol)
            @warn "Custom neutron count or custom atomic symbol not supported."
        end
        @assert Chemfiles.atomic_number(cf_atom) == AtomsBase.atomic_number(atom)

        for (k, v) in pairs(atom)
            if k in (:species, :mass, :velocity, :position)
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
        if k in (:cell_vectors, :periodicity)
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
