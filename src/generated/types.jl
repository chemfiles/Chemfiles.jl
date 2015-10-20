# Automatically generated using Clang.jl wrap_c, version 0.0.0

using Compat

type CHFL_TRAJECTORY
end

type CHFL_FRAME
end

type CHFL_ATOM
end

type CHFL_CELL
end

type CHFL_TOPOLOGY
end

# begin enum chfl_log_level_t
typealias LogLevel UInt32
const NONE = (UInt32)(0)
const ERROR = (UInt32)(1)
const WARNING = (UInt32)(2)
const INFO = (UInt32)(3)
const DEBUG = (UInt32)(4)
# end enum chfl_log_level_t

# begin enum chfl_cell_type_t
typealias CellType UInt32
const ORTHOROMBIC = (UInt32)(0)
const TRICLINIC = (UInt32)(1)
const INFINITE = (UInt32)(2)
# end enum chfl_cell_type_t
