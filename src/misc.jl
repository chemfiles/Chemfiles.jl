# Chemfiles.jl, a modern library for chemistry file reading and writing
# Copyright (C) Guillaume Fraux and contributors -- BSD license

export ChemfilesError

struct ChemfilesError <: Exception
    message::AbstractString
end

Base.show(io::IO, e::ChemfilesError) = show(io, "Chemfiles error: $(e.message)")

"""
Get the last error message from the chemfiles runtime.
"""
function last_error()
    unsafe_string(lib.chfl_last_error())
end

"""
Clear any error messages stored by the chemfiles runtime.
"""
function clear_errors()
    _check(lib.chfl_clear_errors())
end

"""
Default warning callback for Chemfiles
"""
function __default_warning_callback(message::String)
    @warn "$message"
end

"""
Set the global warning ``callback`` to be used for each warning event.

The ``callback`` function must take a ``String`` and return nothing.
"""
function set_warning_callback(callback::Function)
    function _cb_adaptor(message)
        try
            callback(unsafe_string(message))
        catch error
            @warn "caught $error in warning callback"
        end
    end

    cb = @cfunction($_cb_adaptor, Cvoid, (Ptr{UInt8},))
    _check(lib.chfl_set_warning_callback(cb))
end

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
