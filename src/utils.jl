# Chemfiles.jl, a modern library for chemistry file reading and writing
# Copyright (C) Guillaume Fraux and contributors -- BSD license

"""
Wrapper around C++ pointers used by chemfiles, adding automatic memory
management and constness checking.
"""
mutable struct CxxPointer{T}
    __ptr::Ptr{T}
    __is_const::Bool
    function CxxPointer(ptr::Ptr{T}; is_const::Bool=true) where T
        @assert Int(ptr) != 0
        this = new{T}(ptr, is_const)
        finalizer(__free, this)
        return this
    end
end

"""
Free the allocated memory for a chemfiles object.
"""
function __free(object::CxxPointer)
    lib.chfl_free(Ptr{Cvoid}(__const_ptr(object)))
end

"""
Get a mutable C pointer from a CxxPointer, checking that we do have mutable
access to the object.
"""
function __ptr(ptr::CxxPointer)
    if ptr.__is_const
        throw(ChemfilesError("This object is immutable"))
    else
        return ptr.__ptr
    end
end

"""
Get a non mutable C pointer from a CxxPointer.
"""
function __const_ptr(ptr::CxxPointer)
    return ptr.__ptr
end

function __get_last_error()
    message = ""
    try
        message = last_error()
    catch error
        @warn "$error while getting chemfiles error message"
    end
    return message
end

function __check(result::Integer)
    if result != 0
        throw(ChemfilesError(__get_last_error()))
    end
end

macro __check_ptr(expr)
    quote
        local ptr = $(esc(expr))
        if Int(ptr) == 0
            message = __get_last_error()
            if occursin("internal error: pointer at", message) && occursin("is already managed by shared_allocator", message)
                @warn "Got an internal error from chemfiles::shared_allocator, running GC and retrying"
                GC.gc()
                ptr = $(esc(expr))
                if Int(ptr) == 0
                    # This is a legit failure, bail out
                    throw(ChemfilesError(__get_last_error()))
                end
            else
                throw(ChemfilesError(message))
            end
        end
        ptr
    end
end

"""
Remove the final NULL ('\0') character in string `s` coming from C
"""
function __strip_null(s)
    for i in 1:length(s)
        if s[i] == '\0'
            return s[1:i-1]
        end
    end
    throw(ChemfilesError("A C string is not NULL terminated"))
end

"""
Call the `callback` with a growing string buffer until the return string
fits in the buffer.
"""
function __call_with_growing_buffer(callback::Function, initial_size=64)
    function __buffer_was_big_enough(buffer)
        @assert length(buffer) > 2
        return buffer[end-2] == '\0'
    end

    size = initial_size
    buffer = repeat("\0", size)

    callback(pointer(buffer), UInt64(size))
    while !__buffer_was_big_enough(buffer)
        # Grow the buffer and retry
        size *= 2
        buffer = repeat("\0", size)
        callback(pointer(buffer), UInt64(size))
    end

    return __strip_null(buffer)
end
