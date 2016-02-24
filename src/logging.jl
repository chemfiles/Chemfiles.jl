# Copyright (c) Guillaume Fraux 2015
#
# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at http://mozilla.org/MPL/2.0/.

immutable LogLevel
    value::lib.CHFL_LOG_LEVEL

    function LogLevel(value)
        value = lib.CHFL_LOG_LEVEL(value)
        if value in [lib.CHFL_LOG_ERROR, lib.CHFL_LOG_WARNING, lib.CHFL_LOG_INFO, lib.CHFL_LOG_DEBUG]
            return new(value)
        else
            throw(ChemfilesError("Invalid value for conversion to LogLevel: $value"))
        end
    end
end

const ERROR = LogLevel(lib.CHFL_LOG_ERROR)
const WARNING = LogLevel(lib.CHFL_LOG_WARNING)
const INFO = LogLevel(lib.CHFL_LOG_INFO)
const DEBUG = LogLevel(lib.CHFL_LOG_DEBUG)

function set_loglevel(level::LogLevel)
    check(lib.chfl_set_loglevel(level.value))
    return nothing
end

function loglevel()
    level = Ref{lib.CHFL_LOG_LEVEL}()
    check(lib.chfl_loglevel(level))
    return LogLevel(level[])
end

function logfile(file::AbstractString)
    check(lib.chfl_logfile(pointer(file)))
    return nothing
end

function log_to_stderr()
    check(lib.chfl_log_stderr())
    return nothing
end

function log_to_stdout()
    check(lib.chfl_log_stdout())
    return nothing
end

function log_silent()
    check(lib.chfl_log_silent())
    return nothing
end

LOGGING_CALLBACK = nothing
function __c_logging_callback(level::lib.CHFL_LOG_LEVEL, message::Ptr{UInt8})
    if LOGGING_CALLBACK == nothing
        error("No callback was set")
    end
    LOGGING_CALLBACK(LogLevel(level), bytestring(message))
    return nothing
end

function log_callback(callback::Function)
    global LOGGING_CALLBACK = callback
    c_callback = cfunction(__c_logging_callback, Void, (lib.CHFL_LOG_LEVEL, Ptr{UInt8}))
    check(lib.chfl_log_callback(c_callback))
    return nothing
end
