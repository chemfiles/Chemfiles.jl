# Copyright (c) Guillaume Fraux 2015
#
# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at http://mozilla.org/MPL/2.0/.

type ChemfilesError <: Exception
    message::AbstractString
end
Base.show(io::IO, e::ChemfilesError) = show(io, "Chemfiles error: $(e.message)")
export ChemfilesError

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
        throw(ChemfilesError("Got null pointer from C++ code"))
    end
    return nothing
end

function last_error()
    bytestring(lib.chfl_last_error())
end

function clear_errors()
    check(lib.chfl_clear_errors())
end

function strerror(status::Integer)
    bytestring(lib.chfl_strerror(Cint(status)))
end
