# Chemfiles.jl, a modern library for chemistry file reading and writing
# Copyright (C) Guillaume Fraux and contributors -- BSD license

export read_step, read_step!, set_topology!, set_cell!, path
export MemoryTrajectory

__ptr(trajectory::Trajectory) = __ptr(trajectory.__handle)
__const_ptr(trajectory::Trajectory) = __const_ptr(trajectory.__handle)

"""
Opens the trajectory file at the given `path`.

The opening `mode` can be `'r'` for read, `'w'` for write or `'a'` for append,
and defaults to `'r'`. The optional `format` parameter give a specific file
format to use when opening the file.
"""
function Trajectory(path::AbstractString, mode::Char='r', format::AbstractString="")
    ptr = @__check_ptr(lib.chfl_trajectory_with_format(
        pointer(path), Cchar(mode), pointer(format),
    ))
    return Trajectory(CxxPointer(ptr, is_const=false), nothing)
end

"""
Open a trajectory that read in-memory data as if it were a formatted file.

The `format` of the data is mandatory, and must match one of the known formats.
If `data` is `nothing`, this function creates a memory writer, the resulting
data can be retrieved with `buffer`. Else, this function creates a memory reader
using the given data.
"""
function MemoryTrajectory(format::AbstractString, data::DataBuffer=nothing)
    if data === nothing
        # memory writer
        ptr = @__check_ptr(lib.chfl_trajectory_memory_writer(pointer(format)))
    else
        # memory reader
        ptr = @__check_ptr(lib.chfl_trajectory_memory_reader(
            pointer(data), UInt64(sizeof(data)), pointer(format),
        ))
    end
    return Trajectory(CxxPointer(ptr, is_const=false), data)
end

"""
Apply the function `f` to the result of `Trajectory(args...)` and close the
resulting trajectory upon completion, similar to `open(f, args...)`.
"""
function Trajectory(f::Function, args...)
    tr = Trajectory(args...)
    try
        f(tr)
    finally
        close(tr)
    end
end

"""
Read the next step of the `trajectory`, and return the corresponding `Frame`.
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
Read the next step of the `trajectory` data into the preexisting `Frame` structure.
"""
function Base.read!(trajectory::Trajectory, frame::Frame)
    @assert isopen(trajectory)
    __check(lib.chfl_trajectory_read(
        __ptr(trajectory), __ptr(frame)
    ))
end

"""
Read the given `step` of the `trajectory`, and return the corresponding
`Frame`.
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
Read the given `step` of the `trajectory` into an preexisting `Frame` structure.
"""
function read_step!(trajectory::Trajectory, step::Integer, frame::Frame)
    @assert isopen(trajectory)
    __check(lib.chfl_trajectory_read_step(
        __ptr(trajectory), UInt64(step), __ptr(frame)
    ))
end

"""
Write the given `frame` to the `trajectory`.
"""
function Base.write(trajectory::Trajectory, frame::Frame)
    @assert isopen(trajectory)
    __check(lib.chfl_trajectory_write(
        __ptr(trajectory), __const_ptr(frame)
    ))
return nothing
end

"""
Obtain the memory buffer of a in-memory trajectory writer as a `Vector{UInt8}`,
without copying.

If more data is written to the trajectory, the buffer is invalidated.
"""
function Base.take!(trajectory::Trajectory)
    @assert isopen(trajectory)
    size = Ref{UInt64}(0)
    ptr = Ref{Ptr{UInt8}}()
    __check(lib.chfl_trajectory_memory_buffer(
        __const_ptr(trajectory), ptr, size
    ))
    return unsafe_wrap(Array{UInt8,1}, ptr[], (size[],); own=false)
end

"""
Set the `Topology` associated with a `trajectory`. This topology will be
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
Set the `Topology` associated with a `trajectory` by reading the first frame
of the file at `path`; and extracting the topology of this frame. The optional
`format` parameter can be used to specify the file format.
"""
function set_topology!(trajectory::Trajectory, path::AbstractString, format::AbstractString="")
    @assert isopen(trajectory)
    __check(lib.chfl_trajectory_topology_file(
        __ptr(trajectory), pointer(path), pointer(format)
    ))
return nothing
end

"""
Set the `cell` associated with a `trajectory`. This cell will be used when
reading and writing the file, replacing any unit cell in the file.
"""
function set_cell!(trajectory::Trajectory, cell::UnitCell)
    @assert isopen(trajectory)
    __check(lib.chfl_trajectory_set_cell(__ptr(trajectory), __const_ptr(cell)))
return nothing
end

"""
Get the number of steps (the number of frames) in a `trajectory`.
"""
function Base.size(trajectory::Trajectory)
    @assert isopen(trajectory)
    result = Ref{UInt64}(0)
    __check(lib.chfl_trajectory_nsteps(
        __const_ptr(trajectory), result
    ))
    return result[]
end

"""
Get the number of steps (the number of frames) in a `trajectory`.
"""
function Base.length(trajectory::Trajectory)
    size(trajectory)
end

"""
Get the path used to open a `trajectory`.
"""
function path(trajectory::Trajectory)
    @assert isopen(trajectory)
    return __call_with_growing_buffer(
        (buffer, size) -> __check(lib.chfl_trajectory_path(__const_ptr(trajectory), buffer, size))
    )
end

"""
Close a `trajectory`. This function flushes any buffer content to the hard
drive, and frees the associated memory. Necessary when running on the REPL to
finish writing.
"""
function Base.close(trajectory::Trajectory)
    # Manually free and set the pointer to NULL
    lib.chfl_trajectory_close(trajectory.__handle.__ptr)
    trajectory.__handle.__ptr = 0
return nothing
end

"""
Check if the `trajectory` is open.
"""
function Base.isopen(trajectory::Trajectory)
    return Int(trajectory.__handle.__ptr) != 0
end

# Iteration support
function Base.iterate(trajectory::Trajectory, step=0)
    if step >= length(trajectory)
        return nothing
    else
        return (read_step(trajectory, step), step + 1)
    end
end
Base.eltype(::Trajectory) = Frame
