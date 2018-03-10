# Chemfiles.jl, a modern library for chemistry file reading and writing
# Copyright (C) Guillaume Fraux and contributors -- BSD license

export ChemfilesError

type ChemfilesError <: Exception
    message::AbstractString
end

Base.show(io::IO, e::ChemfilesError) = show(io, "Chemfiles error: $(e.message)")

function check(result::Integer, message = "Unknown error")
    if result != 0
        str = message
        try
            str = last_error()
        end
        throw(ChemfilesError(str))
    end
    return nothing
end

function check(result::Ptr)
    if Int(result) == 0
        throw(ChemfilesError(last_error()))
    end
    return nothing
end

"""
Get the last error message from the chemfiles runtime.
"""
function last_error()
    unsafe_string(lib.chfl_last_error())
end

"""
Clear any error message stored by the chemfiles runtime.
"""
function clear_errors()
    check(lib.chfl_clear_errors())
end

function warning_callback(message::String)
    warn("[chemfiles] ", message)
end


"""
Set the global warning ``callback`` to be used for each warning event.

The ``callback`` function must take a ``String`` and return nothing.
"""
function set_warning_callback(callback::Function)
    cb_adaptor = (x) -> callback(unsafe_string(x))
    cb = cfunction(cb_adaptor, Void, (Ptr{UInt8},))
    check(lib.chfl_set_warning_callback(cb))
end

set_warning_callback(warning_callback)


"""
Read configuration data from the file at `path`.

By default, chemfiles reads configuration from any file name `.chemfilesrc`
in the current directory or any parent directory. This function can be used
to add data from another configuration file.

This function will fail if there is no file at `path`, or if the file is
incorectly formatted. Data from the new configuration file will overwrite
any existing data.
"""
function add_configuration(path)
    lib.chfl_add_configuration(pointer(path))
end


function _strip_null(string)
    for i in 1:length(string)
        if string[i] == '\0'
            return string[1:i-1]
        end
    end
    throw(ChemfilesError("A C string is not NULL terminated"))
end

function _call_with_growing_buffer(callback::Function, initial_size=64)
    function buffer_was_big_enough(buffer)
        if length(buffer) < 2
            return false
        else
            return buffer[end-2] == '\0'
        end
    end

    size = initial_size
    buffer = repeat("\0", size)

    callback(pointer(buffer), UInt64(size))
    while !buffer_was_big_enough(buffer)
        # Grow the buffer and retry
        size *= 2
        buffer = repeat("\0", size)
        callback(pointer(buffer), UInt64(size))
    end

    return _strip_null(buffer)
end
