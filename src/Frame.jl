# Chemfiles.jl, a modern library for chemistry file reading and writing
# Copyright (C) Guillaume Fraux and contributors -- BSD license

export add_atom!, remove_atom!
export has_velocities, add_velocities!, positions, velocities
export set_cell!, set_topology!, set_step!, guess_bonds!
export distance, dihedral, out_of_plane

__ptr(frame::Frame) = __ptr(frame.__handle)
__const_ptr(frame::Frame) = __const_ptr(frame.__handle)

"""
    Frame()

Create a new empty `Frame`.
"""
function Frame()
    ptr = @__check_ptr(lib.chfl_frame())
    return Frame(CxxPointer(ptr, is_const=false))
end

"""
    size(frame::Frame)

Get the number of atoms in the `frame`.
"""
function Base.size(frame::Frame)
    count = Ref{UInt64}(0)
    __check(lib.chfl_frame_atoms_count(__const_ptr(frame), count))
    return count[]
end

"""
    length(frame::Frame)

Get the number of atoms in the `frame`.
"""
function Base.length(frame::Frame)
    size(frame)
end

"""
    resize!(frame::Frame, natoms::Integer)

Resize the positions and the velocities in the `frame`, to make space for
`natoms` atoms. This function may invalidate any pointer to the positions or
the velocities if the new size is bigger than the old one. In all the cases,
previous data is conserved. This function conserve the presence or absence of
velocities.
"""
function Base.resize!(frame::Frame, natoms::Integer)
    __check(lib.chfl_frame_resize(__ptr(frame), UInt64(natoms)))
end

"""
    positions(frame::Frame)

Get the positions in a `Frame` as an array. The positions are readable and
writable from this array. If the frame is resized (by writing to it, or calling
`resize!`), the array is invalidated.
"""
function positions(frame::Frame)
    ptr = Ref{Ptr{Float64}}()
    natoms = Ref{UInt64}(0)
    __check(lib.chfl_frame_positions(__ptr(frame), ptr, natoms))
    return unsafe_wrap(Array{Float64, 2}, ptr[], (3, Int(natoms[])); own=false)
end


"""
    velocities(frame::Frame)

Get the velocities in a `Frame` as an array. The velocities are readable and
writable from this array. If the frame is resized (by writing to it, or calling
`resize!`), the array is invalidated.

If the frame do not have velocity, this function will error. You can use
`add_velocities!` to add velocities to a frame before calling this function.
"""
function velocities(frame::Frame)
    ptr = Ref{Ptr{Float64}}()
    natoms = Ref{UInt64}(0)
    __check(lib.chfl_frame_velocities(__ptr(frame), ptr, natoms))
    return unsafe_wrap(Array{Float64, 2}, ptr[], (3, Int(natoms[])); own=false)
end


"""
    add_velocities!(frame::Frame)

Add velocities to this `frame`. The storage is initialized with the result of
`size(frame)` as the number of atoms. If the frame already has velocities, this
does nothing.
"""
function add_velocities!(frame::Frame)
    __check(lib.chfl_frame_add_velocities(__ptr(frame)))
    return nothing
end

"""
    has_velocities(frame::Frame)

Check if a `frame` contains velocity data or not.
"""
function has_velocities(frame::Frame)
    result = Ref{UInt8}(0)
    __check(lib.chfl_frame_has_velocities(__const_ptr(frame), result))
    return convert(Bool, result[])
end

"""
    set_cell!(frame::Frame, cell::UnitCell)

Set the `cell` associated with a `frame`.
"""
function set_cell!(frame::Frame, cell::UnitCell)
    __check(lib.chfl_frame_set_cell(__ptr(frame), __const_ptr(cell)))
    return nothing
end

"""
    set_topology!(frame::Frame, topology::Topology)

Set the `topology` associated with a `frame`.
"""
function set_topology!(frame::Frame, topology::Topology)
    __check(lib.chfl_frame_set_topology(__ptr(frame), __const_ptr(topology)))
    return nothing
end

"""
    step(frame::Frame)

Get the `frame` step, *i.e.* the frame number in the trajectory.
"""
function Base.step(frame::Frame)
    result = Ref{UInt64}(0)
    __check(lib.chfl_frame_step(__const_ptr(frame), result))
    return result[]
end

"""
    set_step!(frame::Frame, step::Integer)

Set the `frame` step to `step`.
"""
function set_step!(frame::Frame, step::Integer)
    __check(lib.chfl_frame_set_step(__ptr(frame), UInt64(step)))
    return nothing
end


"""
    guess_bonds!(frame::Frame)

Guess the bonds, angles, and dihedrals in the `frame` using a distance criteria.
"""
function guess_bonds!(frame::Frame)
    __check(lib.chfl_frame_guess_bonds(__ptr(frame)))
    return nothing
end

"""
    distance(frame::Frame, i::Integer, j::Integer)

Calculate the distance between two atoms.
"""
function distance(frame::Frame, i::Integer, j::Integer)
    result = Ref{Float64}(0)
    __check(lib.chfl_frame_distance(__const_ptr(frame), UInt64(i), UInt64(j), result))
    return result[]
end

"""
    angle(frame::Frame, i::Integer, j::Integer, k::Integer)

Calculate the angle made by three atoms.
"""
function Base.angle(frame::Frame, i::Integer, j::Integer, k::Integer)
    result = Ref{Float64}(0)
    __check(lib.chfl_frame_angle(__const_ptr(frame), UInt64(i), UInt64(j), UInt64(k), result))
    return result[]
end

"""
    dihedral(frame::Frame, i::Integer, j::Integer, k::Integer, m::Integer)

Calculate the dihedral (torsional) angle made by four unbranched atoms.
"""
function dihedral(frame::Frame, i::Integer, j::Integer, k::Integer, m::Integer)
    result = Ref{Float64}(0)
    __check(lib.chfl_frame_dihedral(__const_ptr(frame), UInt64(i), UInt64(j), UInt64(k), UInt64(m), result))
    return result[]
end

"""
    out_of_plane(frame::Frame, i::Integer, j::Integer, k::Integer, m::Integer)

Calculate the out-of-plane (improper) angle made by four atoms.
"""
function out_of_plane(frame::Frame, i::Integer, j::Integer, k::Integer, m::Integer)
    result = Ref{Float64}(0)
    __check(lib.chfl_frame_out_of_plane(__const_ptr(frame), UInt64(i), UInt64(j), UInt64(k), UInt64(m), result))
    return result[]
end

"""
    add_atom!(
        frame::Frame,
        atom::Atom,
        position::Vector{Float64},
        velocity::Vector{Float64} = Float64[0.0,0.0,0.0]
    )

Add an `atom` and the corresponding `position` and `velocity` data to a
`frame`.
"""
function add_atom!(frame::Frame, atom::Atom, position::Vector{Float64}, velocity::Vector{Float64} = Float64[0.0,0.0,0.0])
    __check(lib.chfl_frame_add_atom(__ptr(frame), __const_ptr(atom), position, velocity))
    return nothing
end

"""
    remove_atom!(frame::Frame, index::Integer)

Remove the `atom` at `index` from the `frame`.

This function modifies all the `atoms` indexes after `index`, and invalidates
any array obtained using `positions` or `velocities`.
"""
function remove_atom!(frame::Frame, index::Integer)
    __check(lib.chfl_frame_remove(__ptr(frame), UInt64(index)))
    return nothing
end

"""
    set_property!(frame::Frame, name::String, value)

Set a named property for the given `Frame`.
"""
function set_property!(frame::Frame, name::String, value)
    property = Property(value)
    __check(lib.chfl_frame_set_property(
        __ptr(frame), pointer(name), __const_ptr(property)
    ))
    return nothing
end

"""
    property(frame::Frame, name::String)

Get a named property for the given atom.
"""
function property(frame::Frame, name::String)
    ptr = lib.chfl_frame_get_property(__const_ptr(frame), pointer(name))
    return extract(Property(CxxPointer(ptr, is_const=false)))
end

"""
    properties_count(frame::Frame)

Get the number of properties associated with a frame.
"""
function properties_count(frame::Frame)
    count = Ref{UInt64}(0)
    __check(lib.chfl_frame_properties_count(__const_ptr(frame), count))
    return count[]
end

"""
    list_properties(frame::Frame)

Get the names of all properties associated with a frame.
"""
function list_properties(frame::Frame)
    count = properties_count(frame)
    names = Array{Ptr{UInt8}}(undef, count)
    __check(lib.chfl_frame_list_properties(__const_ptr(frame), pointer(names), count))
    return map(unsafe_string, names)
end

"""
    add_bond!(frame::Frame, i::Integer, j::Integer, order=nothing)

Add an additional bond to the `Frame`'s `Topology`.
"""
function add_bond!(frame::Frame, i::Integer, j::Integer, order=nothing)
    if order == nothing
        __check(lib.chfl_frame_add_bond(__ptr(frame), UInt64(i), UInt64(j)))
    else
        # Check that the order is a valid BondOrder
        order = BondOrder(Integer(order))
        __check(lib.chfl_frame_bond_with_order(
            __ptr(frame), UInt64(i), UInt64(j), lib.chfl_bond_order(order)
        ))
    end
    return nothing
end

"""
    remove_bond!(frame::Frame, i::Integer, j::Integer)

Remove a bond from the `Frame`'s `Topology`.
"""
function remove_bond!(frame::Frame, i::Integer, j::Integer)
    __check(lib.chfl_frame_remove_bond(__ptr(frame), UInt64(i), UInt64(j)))
    return nothing
end

"""
    add_residue!(frame::Frame, residue::Residue)

Add a residue to the `Frame`'s `Topology`.
"""
function add_residue!(frame::Frame, residue::Residue)
    __check(lib.chfl_frame_add_residue(__ptr(frame), __const_ptr(residue)))
    return nothing
end

"""
    deepcopy(frame::Frame)

Make a deep copy of a `Frame`.
"""
function Base.deepcopy(frame::Frame)
    ptr = lib.chfl_frame_copy(__const_ptr(frame))
    return Frame(CxxPointer(ptr, is_const=false))
end

# Iteration support
function Base.iterate(frame::Frame, atom=0)
    if atom >= size(frame)
        return nothing
    else
        return (Atom(frame, atom), atom + 1)
    end
end
Base.eltype(frame::Frame) = Atom
