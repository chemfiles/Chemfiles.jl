# Copyright (c) Guillaume Fraux 2015
#
# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at http://mozilla.org/MPL/2.0/.

export positions, velocities, add_atom!, remove_atom!, add_velocities!, has_velocities, set_cell!,
set_topology!, set_step!, guess_bonds!

function Frame()
    handle = lib.chfl_frame()
    return Frame(handle)
end

function free(frame::Frame)
    lib.chfl_frame_free(frame.handle)
end

function Base.size(frame::Frame)
    n = Ref{UInt64}(0)
    check(
        lib.chfl_frame_atoms_count(frame.handle, n)
    )
    return n[]
end

function Base.resize!(frame::Frame, size::Integer)
    check(
        lib.chfl_frame_resize(frame.handle, UInt64(size))
    )
end

function positions(frame::Frame)
    ptr = Ref{Ptr{Float64}}()
    natoms = Ref{UInt64}(0)
    check(
        lib.chfl_frame_positions(frame.handle, ptr, natoms)
    )
    return unsafe_wrap(Array{Float64, 2}, ptr[], (3, Int(natoms[])), false)
end

function velocities(frame::Frame)
    ptr = Ref{Ptr{Float64}}()
    natoms = Ref{UInt64}(0)
    check(
        lib.chfl_frame_velocities(frame.handle, ptr, natoms)
    )
    return unsafe_wrap(Array{Float64, 2}, ptr[], (3, Int(natoms[])), false)
end

function add_velocities!(frame::Frame)
    check(
        lib.chfl_frame_add_velocities(frame.handle)
    )
    return nothing
end

function has_velocities(frame::Frame)
    result = Ref{UInt8}(0)
    check(
        lib.chfl_frame_has_velocities(frame.handle, result)
    )
    return convert(Bool, result[])
end

function set_cell!(frame::Frame, cell::UnitCell)
    check(
        lib.chfl_frame_set_cell(frame.handle, cell.handle)
    )
    return nothing
end

function set_topology!(frame::Frame, topology::Topology)
    check(
        lib.chfl_frame_set_topology(frame.handle, topology.handle)
    )
    return nothing
end

function Base.step(frame::Frame)
    result = Ref{UInt64}(0)
    check(
        lib.chfl_frame_step(frame.handle, result)
    )
    return result[]
end

function set_step!(frame::Frame, step::Integer)
    check(
        lib.chfl_frame_set_step(frame.handle, UInt64(step))
    )
    return nothing
end

function guess_bonds!(frame::Frame)
    check(lib.chfl_frame_guess_topology(frame.handle))
    return nothing
end

function add_atom!(frame::Frame, atom::Atom, position::Array{Float64}, velocity::Array{Float64})
    check(
        lib.chfl_frame_add_atom(frame.handle, atom.handle, position, velocity)
    )
    return nothing
end

function remove_atom!(frame::Frame, index::Integer)
    check(
        lib.chfl_frame_remove(frame.handle, UInt64(index))
    )
    return nothing
end
