# Copyright (c) Guillaume Fraux 2015
#
# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at http://mozilla.org/MPL/2.0/.

export positions, positions!, set_positions!, velocities, velocities!, set_velocities!,
       has_velocities, set_cell!, set_topology!, set_step!, guess_topology!, natoms

function Frame(natoms::Integer = 0)
    handle = lib.chfl_frame(Csize_t(natoms))
    return Frame(handle)
end

function free(frame::Frame)
    lib.chfl_frame_free(frame.handle)
end

function natoms(frame::Frame)
    n = Csize_t[0]
    check(
        lib.chfl_frame_atoms_count(frame.handle, pointer(n))
    )
    return n[1]
end

Base.size(frame::Frame) = natoms(frame)

function positions(frame::Frame)
    natoms = size(frame)
    data = Array(Cfloat, 3, natoms)
    return positions!(frame, data)
end

function positions!(frame::Frame, data::Array{Float32, 2})
    check(
        lib.chfl_frame_positions(frame.handle, pointer(data), Csize_t(size(data, 2)))
    )
    return data
end

function set_positions!(frame::Frame, data::Array{Float32, 2})
    check(
        lib.chfl_frame_set_positions(frame.handle, pointer(data), Csize_t(size(data, 2)))
    )
    return nothing
end

function velocities(frame::Frame)
    natoms = size(frame)
    data = Array(Cfloat, 3, natoms)
    return velocities!(frame, data)
end

function velocities!(frame::Frame, data::Array{Float32, 2})
    check(
        lib.chfl_frame_velocities(frame.handle, pointer(data), Csize_t(size(data, 2)))
    )
    return data
end

function set_velocities!(frame::Frame, data::Array{Float32, 2})
    check(
        lib.chfl_frame_set_velocities(frame.handle, pointer(data), Csize_t(size(data, 2)))
    )
    return nothing
end

function has_velocities(frame::Frame)
    res = Bool[false]
    check(
        lib.chfl_frame_has_velocities(frame.handle, pointer(res))
    )
    return res[1]
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
    res = Csize_t[0]
    check(
        lib.chfl_frame_step(frame.handle, pointer(res))
    )
    return res[1]
end

function set_step!(frame::Frame, step::Integer)
    check(
        lib.chfl_frame_set_step(frame.handle, Csize_t(step))
    )
    return nothing
end

function guess_topology!(frame::Frame, bonds::Bool=true)
    check(
        lib.chfl_frame_guess_topology(frame.handle, bonds)
    )
    return nothing
end
