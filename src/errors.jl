# Copyright (c) Guillaume Fraux 2015
#
# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at http://mozilla.org/MPL/2.0/.

type ChemharpError <: Exception
    message::String
end
Base.show(io::IO, e::ChemharpError) = show(io, "Chemharp error: $(e.message)")
export ChemharpError

function check(result)
    if result != 0
        str = "Unlnown error"
        try
            str = lib.chrp_strerror(result)
        end
        throw(ChemharpError(str))
    end
    return nothing
end

"""
These functions are not exported, and should be called by there fully qualified name:
    Chemharp.last_error()
    Chemharp.loglevel(Chemharp.ERROR)
"""

function last_error()
    bytestring(lib.chrp_last_error())
end

function loglevel(level::lib.chrp_log_level_t)
    check(
        lib.chrp_loglevel(level)
    )
    return nothing
end

function logfile(file::AbstractString)
    check(
        lib.chrp_logfile(pointer(file))
    )
    return nothing
end

function log_to_stderr()
    check(
        lib.chrp_log_stderr()
    )
    return nothing
end
