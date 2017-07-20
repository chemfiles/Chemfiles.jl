# Copyright (c) Guillaume Fraux 2015
#
# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at http://mozilla.org/MPL/2.0/.
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
