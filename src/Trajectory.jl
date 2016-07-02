# Copyright (c) Guillaume Fraux 2015
#
# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at http://mozilla.org/MPL/2.0/.

export read_step, read_step!, set_topology!, set_cell!, nsteps, sync

function Trajectory(filename::AbstractString, mode::Char='r')
    handle = lib.chfl_trajectory_open(pointer(filename), Int8(mode))
    return Trajectory(handle)
end

free(file::Trajectory) = close(file)

function Base.read!(file::Trajectory, frame::Frame)
    check(
        lib.chfl_trajectory_read(file.handle, frame.handle)
    )
    return frame
end

function Base.read(file::Trajectory)
    frame = Frame()
    return read!(file, frame)
end

function read_step!(file::Trajectory, step::Integer, frame::Frame)
    check(
        lib.chfl_trajectory_read_step(file.handle, Csize_t(step), frame.handle)
    )
    return frame
end

function read_step(file::Trajectory, step::Integer)
    frame = Frame()
    return read_step!(file, step, frame)
end

function Base.write(file::Trajectory, frame::Frame)
    check(
        lib.chfl_trajectory_write(file.handle, frame.handle)
    )
    return nothing
end

function set_topology!(file::Trajectory, topology::Topology)
    check(
        lib.chfl_trajectory_set_topology(file.handle, topology.handle)
    )
    return nothing
end

function set_topology!(file::Trajectory, filename::AbstractString)
    check(
        lib.chfl_trajectory_set_topology_file(file.handle, pointer(filename))
    )
    return nothing
end

function set_cell!(file::Trajectory, cell::UnitCell)
    check(
        lib.chfl_trajectory_set_cell(file.handle, cell.handle)
    )
    return nothing
end

function nsteps(file::Trajectory)
    res = Ref{Csize_t}(0)
    check(
        lib.chfl_trajectory_nsteps(file.handle, res)
    )
    return res[]
end

function sync(file::Trajectory)
    check(
        lib.chfl_trajectory_sync(file.handle)
    )
    return nothing
end

function Base.close(file::Trajectory)
    check(
        lib.chfl_trajectory_close(file.handle)
    )
    file.handle = Ptr{lib.CHFL_TRAJECTORY}(0)
    return nothing
end

Base.isopen(file::Trajectory) = (file.handle != Ptr{lib.CHFL_TRAJECTORY}(0))
