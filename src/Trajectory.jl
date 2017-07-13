# Copyright (c) Guillaume Fraux 2015
#
# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at http://mozilla.org/MPL/2.0/.

export read_step, read_step!, set_topology!, set_cell!, nsteps

function Trajectory(filename::AbstractString, mode::Char='r', format::AbstractString="")
    handle = lib.chfl_trajectory_with_format(
        pointer(filename), Int8(mode), pointer(format),
    )
    return Trajectory(handle)
end

free(trajectory::Trajectory) = close(trajectory)

function Base.read!(trajectory::Trajectory, frame::Frame)
    assert(isopen(trajectory))
    check(
        lib.chfl_trajectory_read(trajectory.handle, frame.handle)
    )
    return frame
end

function Base.read(trajectory::Trajectory)
    assert(isopen(trajectory))
    frame = Frame()
    return read!(trajectory, frame)
end

function read_step!(trajectory::Trajectory, step::Integer, frame::Frame)
    assert(isopen(trajectory))
    check(
        lib.chfl_trajectory_read_step(trajectory.handle, UInt64(step), frame.handle)
    )
    return frame
end

function read_step(trajectory::Trajectory, step::Integer)
    assert(isopen(trajectory))
    frame = Frame()
    return read_step!(trajectory, step, frame)
end

function Base.write(trajectory::Trajectory, frame::Frame)
    assert(isopen(trajectory))
    check(
        lib.chfl_trajectory_write(trajectory.handle, frame.handle)
    )
    return nothing
end

function set_topology!(trajectory::Trajectory, topology::Topology)
    assert(isopen(trajectory))
    check(
        lib.chfl_trajectory_set_topology(trajectory.handle, topology.handle)
    )
    return nothing
end

function set_topology!(trajectory::Trajectory, filename::AbstractString, format::AbstractString = "")
    assert(isopen(trajectory))
    check(
        lib.chfl_trajectory_topology_file(trajectory.handle, pointer(filename), pointer(format))
    )
    return nothing
end

function set_cell!(trajectory::Trajectory, cell::UnitCell)
    assert(isopen(trajectory))
    check(
        lib.chfl_trajectory_set_cell(trajectory.handle, cell.handle)
    )
    return nothing
end

function nsteps(trajectory::Trajectory)
    assert(isopen(trajectory))
    result = Ref{UInt64}(0)
    check(
        lib.chfl_trajectory_nsteps(trajectory.handle, result)
    )
    return result[]
end

function Base.close(trajectory::Trajectory)
    check(
        lib.chfl_trajectory_close(trajectory.handle)
    )
    trajectory.handle = Ptr{lib.CHFL_TRAJECTORY}(0)
    return nothing
end

function Base.isopen(trajectory::Trajectory)
    return trajectory.handle != Ptr{lib.CHFL_TRAJECTORY}(0)
end
