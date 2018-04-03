# Chemfiles.jl, a modern library for chemistry file reading and writing
# Copyright (C) Guillaume Fraux and contributors -- BSD license

export read_step, read_step!, set_topology!, set_cell!, nsteps

"""
The ``Trajectory`` function open a trajectory file, using the file at the given
``path``. The opening ``mode`` can be ``'r'`` for read, ``'w'`` for write or
``'a'`` for append, and defaults to ``'r'``. The optional ``format`` parameter
give a specific file format to use when opening the file.
"""
function Trajectory(path::AbstractString, mode::Char='r', format::AbstractString="")
    handle = lib.chfl_trajectory_with_format(
        pointer(path), Int8(mode), pointer(format),
    )
    return Trajectory(handle)
end

"""
Free the allocated memory for the ``Trajectory`` object.
"""
_free(trajectory::Trajectory) = close(trajectory)

"""
Read the next step of the ``trajectory`` in the given ``frame``.
"""
function Base.read!(trajectory::Trajectory, frame::Frame)
    assert(isopen(trajectory))
    _check(
        lib.chfl_trajectory_read(trajectory.handle, frame.handle)
    )
    return frame
end

"""
Read the next step of the ``trajectory``, and return the corresponding ``Frame``.
"""
function Base.read(trajectory::Trajectory)
    assert(isopen(trajectory))
    frame = Frame()
    return read!(trajectory, frame)
end

"""
Read the given ``step`` of the ``trajectory`` in the given ``frame``.
"""
function read_step!(trajectory::Trajectory, step::Integer, frame::Frame)
    assert(isopen(trajectory))
    _check(
        lib.chfl_trajectory_read_step(trajectory.handle, UInt64(step), frame.handle)
    )
    return frame
end

"""
Read the given ``step`` of the ``trajectory``, and return the corresponding
``Frame``.
"""
function read_step(trajectory::Trajectory, step::Integer)
    assert(isopen(trajectory))
    frame = Frame()
    return read_step!(trajectory, step, frame)
end

"""
Write the given ``frame`` to the ``trajectory``.
"""
function Base.write(trajectory::Trajectory, frame::Frame)
    assert(isopen(trajectory))
    _check(
        lib.chfl_trajectory_write(trajectory.handle, frame.handle)
    )
    return nothing
end

"""
Set the ``Topology`` associated with a ``trajectory``. This topology will be
used when reading and writing the files, replacing any topology in the file.
"""
function set_topology!(trajectory::Trajectory, topology::Topology)
    assert(isopen(trajectory))
    _check(
        lib.chfl_trajectory_set_topology(trajectory.handle, topology.handle)
    )
    return nothing
end

"""
Set the ``Topology`` associated with a ``trajectory`` by reading the first frame
of the file at ``path``; and extracting the topology of this frame. The optional
``format`` parameter can be used to specify the file format.
"""
function set_topology!(trajectory::Trajectory, path::AbstractString, format::AbstractString = "")
    assert(isopen(trajectory))
    _check(
        lib.chfl_trajectory_topology_file(trajectory.handle, pointer(path), pointer(format))
    )
    return nothing
end

"""
Set the ``cell`` associated with a ``trajectory``. This cell will be used when
reading and writing the files, replacing any unit cell in the file.
"""
function set_cell!(trajectory::Trajectory, cell::UnitCell)
    assert(isopen(trajectory))
    _check(
        lib.chfl_trajectory_set_cell(trajectory.handle, cell.handle)
    )
    return nothing
end

"""
Get the number of steps (the number of frames) in a ``trajectory``.
"""
function nsteps(trajectory::Trajectory)
    assert(isopen(trajectory))
    result = Ref{UInt64}(0)
    _check(
        lib.chfl_trajectory_nsteps(trajectory.handle, result)
    )
    return result[]
end

"""
Close a ``trajectory``, flushing any buffer content to the hard drive, and
freeing the associated memory. Necessary when running on the REPL to finish 
writing.
"""
function Base.close(trajectory::Trajectory)
    _check(
        lib.chfl_trajectory_close(trajectory.handle)
    )
    trajectory.handle = Ptr{lib.CHFL_TRAJECTORY}(0)
    return nothing
end

"""
Check is the ``trajectory`` is open
"""
function Base.isopen(trajectory::Trajectory)
    return trajectory.handle != Ptr{lib.CHFL_TRAJECTORY}(0)
end

# Iteration support
Base.start(trajectory::Trajectory) = 0
Base.done(trajectory::Trajectory, index) = (index == nsteps(trajectory))
Base.next(trajectory::Trajectory, index) = (read_step(trajectory, index), index + 1)
