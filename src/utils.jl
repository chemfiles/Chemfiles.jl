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
        __check(ptr)
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

"""
If there is an error try to get it and throw a ChemfilesError with it.
Show \"Unknown error\" in case it can't get the last one.
"""
function __check(result::Integer, message = "Unknown error")
    if result != 0
        str = message
        try
            str = last_error()
        catch error
            @warn "$error in obtaining an error message"
        end
        throw(ChemfilesError(str))
    end
    return nothing
end

"""
If there is an error try to get it and throw a ChemfilesError with it.
"""
function __check(result::Ptr)
    if Int(result) == 0
        throw(ChemfilesError(last_error()))
    end
    return nothing
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
    function _buffer_was_big_enough(buffer)
        if length(buffer) < 2
            return false
        else
            return buffer[end-2] == '\0'
        end
    end

    size = initial_size
    buffer = repeat("\0", size)

    callback(pointer(buffer), UInt64(size))
    while !_buffer_was_big_enough(buffer)
        # Grow the buffer and retry
        size *= 2
        buffer = repeat("\0", size)
        callback(pointer(buffer), UInt64(size))
    end

    return __strip_null(buffer)
end
