# Copyright (c) Guillaume Fraux 2015
#
# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at http://mozilla.org/MPL/2.0/.

export positions, velocities, add_velocities!, has_velocities, set_cell!,
set_topology!, set_step!, guess_topology!, natoms

function Frame(natoms::Integer = 0)
    handle = lib.chfl_frame(Csize_t(natoms))
    return Frame(handle)
end

function free(frame::Frame)
    lib.chfl_frame_free(frame.handle)
end

function natoms(frame::Frame)
    n = Ref{Csize_t}(0)
    check(
        lib.chfl_frame_atoms_count(frame.handle, n)
    )
    return n[]
end

Base.size(frame::Frame) = natoms(frame)

function Base.resize!(frame::Frame, size::Integer)
    check(
        lib.chfl_frame_resize(frame.handle, Csize_t(size))
    )
end

function positions(frame::Frame)
    ptr = Ref{Ptr{Cfloat}}()
    natoms = Ref{Csize_t}(0)
    check(
        lib.chfl_frame_positions(frame.handle, ptr, natoms)
    )
    return pointer_to_array(ptr[], (3, Int64(natoms[])), false)
end

function velocities(frame::Frame)
    ptr = Ref{Ptr{Cfloat}}()
    natoms = Ref{Csize_t}(0)
    check(
        lib.chfl_frame_velocities(frame.handle, ptr, natoms)
    )
    return pointer_to_array(ptr[], (3, Int64(natoms[])), false)
end

function add_velocities!(frame::Frame)
    check(
        lib.chfl_frame_add_velocities(frame.handle)
    )
    return nothing
end

function has_velocities(frame::Frame)
    res = Ref{UInt8}(0)
    check(
        lib.chfl_frame_has_velocities(frame.handle, res)
    )
    return convert(Bool, res[])
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
    res = Ref{Csize_t}(0)
    check(
        lib.chfl_frame_step(frame.handle, res)
    )
    return res[]
end

function set_step!(frame::Frame, step::Integer)
    check(
        lib.chfl_frame_set_step(frame.handle, Csize_t(step))
    )
    return nothing
end

function guess_topology!(frame::Frame)
    check(lib.chfl_frame_guess_topology(frame.handle))
    return nothing
end

function Base.select(frame::Frame, selection::AbstractString)
    natoms = size(frame)
    data = Array(UInt8, natoms)
    check(
        lib.chfl_frame_selection(frame.handle, pointer(selection), pointer(data), Csize_t(natoms))
    )
    return convert(Vector{Bool}, data)
end
