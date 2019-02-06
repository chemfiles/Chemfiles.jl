# Chemfiles.jl, a modern library for chemistry file reading and writing
# Copyright (C) Guillaume Fraux and contributors -- BSD license

"""
If there is an error try to get it and throw a ChemfilesError with it.
Show \"Unknown error\" in case it can't get the last one.
"""
function _check(result::Integer, message = "Unknown error")
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
function _check(result::Ptr)
    if Int(result) == 0
        throw(ChemfilesError(last_error()))
    end
    return nothing
end

"""
Remove the final NULL ('\0') character in string `s` coming from C
"""
function _strip_null(s)
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
function _call_with_growing_buffer(callback::Function, initial_size=64)
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

    return _strip_null(buffer)
end
