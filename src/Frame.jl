# Chemfiles.jl, a modern library for chemistry file reading and writing
# Copyright (C) Guillaume Fraux and contributors -- BSD license

export positions, velocities, add_atom!, remove_atom!, add_velocities!, has_velocities, set_cell!,
set_topology!, set_step!, guess_bonds!, distance, dihedral, out_of_plane, add_bond!, remove_bond!, add_residue!

"""
Create a new empty ``Frame``.
"""
function Frame()
    handle = lib.chfl_frame()
    return Frame(handle)
end

function free(frame::Frame)
    lib.chfl_frame_free(frame.handle)
end

"""
Get the ``frame`` size, *i.e.* the current number of atoms.
"""
function Base.size(frame::Frame)
    n = Ref{UInt64}(0)
    check(
        lib.chfl_frame_atoms_count(frame.handle, n)
    )
    return n[]
end


"""
Resize the positions and the velocities in a ``frame``, to make space for
``natoms`` atoms. This function may invalidate any pointer to the positions or
the velocities if the new size is bigger than the old one. In all the cases,
previous data is conserved. This function conserve the presence or absence of
velocities.
"""
function Base.resize!(frame::Frame, natoms::Integer)
    check(
        lib.chfl_frame_resize(frame.handle, UInt64(natoms))
    )
end

"""
Get the positions in a ``Frame`` as an array. The positions are readable and
writable from this array. If the frame is resized (by writing to it, or calling
``resize!``), the array is invalidated.
"""
function positions(frame::Frame)
    ptr = Ref{Ptr{Float64}}()
    natoms = Ref{UInt64}(0)
    check(
        lib.chfl_frame_positions(frame.handle, ptr, natoms)
    )
    return unsafe_wrap(Array{Float64, 2}, ptr[], (3, Int(natoms[])), false)
end


"""
Get the velocities in a ``Frame`` as an array. The velocities are readable and
writable from this array. If the frame is resized (by writing to it, or calling
``resize!``), the array is invalidated.

If the frame do not have velocity, this function will error. You can use
``add_velocities!`` to add velocities to a frame before calling this function.
"""
function velocities(frame::Frame)
    ptr = Ref{Ptr{Float64}}()
    natoms = Ref{UInt64}(0)
    check(
        lib.chfl_frame_velocities(frame.handle, ptr, natoms)
    )
    return unsafe_wrap(Array{Float64, 2}, ptr[], (3, Int(natoms[])), false)
end


"""
Add velocities to this ``frame``. The storage is initialized with the result of
``size(frame)`` as number of atoms. If the frame already have velocities, this
does nothing.
"""
function add_velocities!(frame::Frame)
    check(
        lib.chfl_frame_add_velocities(frame.handle)
    )
    return nothing
end

"""
Check if a ``frame`` contains velocity data or not.
"""
function has_velocities(frame::Frame)
    result = Ref{UInt8}(0)
    check(
        lib.chfl_frame_has_velocities(frame.handle, result)
    )
    return convert(Bool, result[])
end

"""
Set the ``cell`` associated with a ``frame``.
"""
function set_cell!(frame::Frame, cell::UnitCell)
    check(
        lib.chfl_frame_set_cell(frame.handle, cell.handle)
    )
    return nothing
end

"""
Set the ``topology`` associated with a ``frame``.
"""
function set_topology!(frame::Frame, topology::Topology)
    check(
        lib.chfl_frame_set_topology(frame.handle, topology.handle)
    )
    return nothing
end

"""
Get the ``frame`` step, *i.e.* the frame number in the trajectory.
"""
function Base.step(frame::Frame)
    result = Ref{UInt64}(0)
    check(
        lib.chfl_frame_step(frame.handle, result)
    )
    return result[]
end

"""
Set the ``frame`` step to ``step``.
"""
function set_step!(frame::Frame, step::Integer)
    check(
        lib.chfl_frame_set_step(frame.handle, UInt64(step))
    )
    return nothing
end


"""
Guess the bonds, angles and dihedrals in the ``frame`` using a distance criteria.
"""
function guess_bonds!(frame::Frame)
    check(lib.chfl_frame_guess_topology(frame.handle))
    return nothing
end

"""
Calculate the distance between two atoms.
"""
function distance(frame::Frame, i::Integer, j::Integer)
    result = Ref{Float64}(0)
    check(
        lib.chfl_frame_distance(frame.handle, UInt64(i), UInt64(j), result)
    )
    return result[]
end

"""
Calculate the angle made by three atoms.
"""
function Base.angle(frame::Frame, i::Integer, j::Integer, k::Integer)
    result = Ref{Float64}(0)
    check(
        lib.chfl_frame_angle(frame.handle, UInt64(i), UInt64(j), UInt64(k), result)
    )
    return result[]
end

"""
Calculate the dihedral (torsional) angle made by four unbranched atoms.
"""
function dihedral(frame::Frame, i::Integer, j::Integer, k::Integer, m::Integer)
    result = Ref{Float64}(0)
    check(
        lib.chfl_frame_dihedral(frame.handle, UInt64(i), UInt64(j), UInt64(k), UInt64(m), result)
    )
    return result[]
end

"""
Calculate the out-of-plane (improper) angle made by four atoms.
"""
function out_of_plane(frame::Frame, i::Integer, j::Integer, k::Integer, m::Integer)
    result = Ref{Float64}(0)
    check(
        lib.chfl_frame_out_of_plane(frame.handle, UInt64(i), UInt64(j), UInt64(k), UInt64(m), result)
    )
    return result[]
end

"""
Add an ``atom`` and the corresponding ``position`` and ``velocity`` data to a
``frame``.
"""
function add_atom!(frame::Frame, atom::Atom, position::Vector{Float64}, velocity::Vector{Float64} = Float64[0.0,0.0,0.0])
    check(
        lib.chfl_frame_add_atom(frame.handle, atom.handle, position, velocity)
    )
    return nothing
end

"""
Remove the ``atom`` at ``index`` from the ``frame``.

This modify all the ``atoms`` indexes after ``index``, and invalidate any
array obtained using ``positions`` or ``velocities``.
"""
function remove_atom!(frame::Frame, index::Integer)
    check(
        lib.chfl_frame_remove(frame.handle, UInt64(index))
    )
    return nothing
end

"""
Set a named property for the given ``Frame``.
"""
function set_property!(frame::Frame, name::String, property)

    prop = Property(property)

    check(
        lib.chfl_frame_set_property(frame.handle, pointer(name), prop.handle)
    )
    return nothing
end

"""
Get a named property for the given atom.
"""
function property(frame::Frame, name::String)
    get(Property(lib.chfl_frame_get_property(frame.handle, pointer(name))))
end

"""
Add an additional bond to the ``Frames``'s ``Topology``.
"""
function add_bond!(frame::Frame, i::Integer, j::Integer)
    check(
        lib.chfl_frame_add_bond(frame.handle, UInt64(i), UInt64(j))
    )
    return nothing
end

"""
Remove a bond from the ``Frames``'s ``Topology``.
"""
function remove_bond!(frame::Frame, i::Integer, j::Integer)
    check(
        lib.chfl_frame_remove_bond(frame.handle, UInt64(i), UInt64(j))
    )
    return nothing
end

"""
Add a residue to the ``Frames``'s ``Topology``.
"""
function add_residue!(frame::Frame, residue::Residue)
    check(
        lib.chfl_frame_add_residue(frame.handle, residue.handle)
    )
    return nothing
end

"""
Make a deep copy of a ``frame``.
"""
function Base.deepcopy(frame::Frame)
    handle = lib.chfl_frame_copy(frame.handle)
    return Frame(handle)
end
