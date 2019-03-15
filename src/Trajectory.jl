# Chemfiles.jl, a modern library for chemistry file reading and writing
# Copyright (C) Guillaume Fraux and contributors -- BSD license

export read_step, set_topology!, set_cell!, nsteps, path

__ptr(trajectory::Trajectory) = __ptr(trajectory.__handle)
__const_ptr(trajectory::Trajectory) = __const_ptr(trajectory.__handle)

"""
The ``Trajectory`` function opens a trajectory file, using the file at the given
``path``. The opening ``mode`` can be ``'r'`` for read, ``'w'`` for write or
``'a'`` for append, and defaults to ``'r'``. The optional ``format`` parameter
give a specific file format to use when opening the file.
"""
function Trajectory(path::AbstractString, mode::Char='r', format::AbstractString="")
    ptr = @__check_ptr(lib.chfl_trajectory_with_format(
        pointer(path), Int8(mode), pointer(format),
    ))
    return Trajectory(CxxPointer(ptr, is_const=false))
end

"""
Read the next step of the ``trajectory``, and return the corresponding ``Frame``.
"""
function Base.read(trajectory::Trajectory)
    @assert isopen(trajectory)
    frame = Frame()
    __check(lib.chfl_trajectory_read(
        __ptr(trajectory), __ptr(frame)
    ))
    return frame
end

"""
Read the given ``step`` of the ``trajectory``, and return the corresponding
``Frame``.
"""
function read_step(trajectory::Trajectory, step::Integer)
    @assert isopen(trajectory)
    frame = Frame()
    __check(lib.chfl_trajectory_read_step(
        __ptr(trajectory), UInt64(step), __ptr(frame)
    ))
    return frame
end

"""
Write the given ``frame`` to the ``trajectory``.
"""
function Base.write(trajectory::Trajectory, frame::Frame)
    @assert isopen(trajectory)
    __check(lib.chfl_trajectory_write(
        __ptr(trajectory), __const_ptr(frame)
    ))
    return nothing
end

"""
Set the ``Topology`` associated with a ``trajectory``. This topology will be
used when reading and writing the file, replacing any topology in the file.
"""
function set_topology!(trajectory::Trajectory, topology::Topology)
    @assert isopen(trajectory)
    __check(lib.chfl_trajectory_set_topology(
        __ptr(trajectory), __const_ptr(topology)
    ))
    return nothing
end

"""
Set the ``Topology`` associated with a ``trajectory`` by reading the first frame
of the file at ``path``; and extracting the topology of this frame. The optional
``format`` parameter can be used to specify the file format.
"""
function set_topology!(trajectory::Trajectory, path::AbstractString, format::AbstractString = "")
    @assert isopen(trajectory)
    __check(lib.chfl_trajectory_topology_file(
        __ptr(trajectory), pointer(path), pointer(format)
    ))
    return nothing
end

"""
Set the ``cell`` associated with a ``trajectory``. This cell will be used when
reading and writing the file, replacing any unit cell in the file.
"""
function set_cell!(trajectory::Trajectory, cell::UnitCell)
    @assert isopen(trajectory)
    __check(lib.chfl_trajectory_set_cell(__ptr(trajectory), __const_ptr(cell)))
    return nothing
end

"""
Get the number of steps (the number of frames) in a ``trajectory``.
"""
function nsteps(trajectory::Trajectory)
    @assert isopen(trajectory)
    result = Ref{UInt64}(0)
    __check(lib.chfl_trajectory_nsteps(
        __const_ptr(trajectory), result
    ))
    return result[]
end

"""
Get the path used to open a ``trajectory``.
"""
function path(trajectory::Trajectory)
    @assert isopen(trajectory)
    result = Ref{Ptr{UInt8}}(0)
    Base.cconvert(Ptr{Ptr{UInt8}}, result)
    __check(
        lib.chfl_trajectory_path(__const_ptr(trajectory), Base.unsafe_convert(Ptr{Ptr{UInt8}}, result))
    )
    return unsafe_string(result[])
end

"""
Close a ``trajectory``. This function flushes any buffer content to the hard
drive, and frees the associated memory. Necessary when running on the REPL to
finish  writing.
"""
function Base.close(trajectory::Trajectory)
    # Manually free and set the pointer to NULL
    lib.chfl_trajectory_close(trajectory.__handle.__ptr)
    trajectory.__handle.__ptr = 0
    return nothing
end

"""
Check if the ``trajectory`` is open.
"""
function Base.isopen(trajectory::Trajectory)
    return Int(trajectory.__handle.__ptr) != 0
end

# Iteration support
Base.first(trajectory::Trajectory) = 0
Base.last(trajectory::Trajectory) = (nsteps(trajectory) - 1)
Base.step(trajectory::Trajectory, index) = (read_step(trajectory, index), index + 1)
Base.iterate(trajectory::Trajectory, state=0) = state >= nsteps(trajectory) ? nothing : (read_step(trajectory, state), state+1)
