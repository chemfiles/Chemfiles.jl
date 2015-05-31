# Automatically generated using Clang.jl wrap_c, version 0.0.0

using Compat

type CHRP_TRAJECTORY
end

type CHRP_FRAME
end

type CHRP_ATOM
end

type CHRP_CELL
end

type CHRP_TOPOLOGY
end

# begin enum chrp_log_level_t
typealias LogLevel Uint32
const NONE = (UInt32)(0)
const ERROR = (UInt32)(1)
const WARNING = (UInt32)(2)
const INFO = (UInt32)(3)
const DEBUG = (UInt32)(4)
# end enum chrp_log_level_t

# begin enum chrp_cell_type_t
typealias CellType Uint32
const ORTHOROMBIC = (UInt32)(0)
const TRICLINIC = (UInt32)(1)
const INFINITE = (UInt32)(2)
# end enum chrp_cell_type_t
