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

# begin enum CHRP_LOG_LEVEL
typealias CHRP_LOG_LEVEL Uint32
const NONE = (UInt32)(0)
const ERROR = (UInt32)(1)
const WARNING = (UInt32)(2)
const INFO = (UInt32)(3)
const DEBUG = (UInt32)(4)
# end enum CHRP_LOG_LEVEL

# begin enum chrp_log_level_t
typealias chrp_log_level_t Uint32
const NONE = (UInt32)(0)
const ERROR = (UInt32)(1)
const WARNING = (UInt32)(2)
const INFO = (UInt32)(3)
const DEBUG = (UInt32)(4)
# end enum chrp_log_level_t

immutable Array_3_Cdouble
    d1::Cdouble
    d2::Cdouble
    d3::Cdouble
end

zero(::Type{Array_3_Cdouble}) = begin  # /Volumes/Aldith/.julia/v0.4/Clang/src/wrap_c.jl, line 264:
        Array_3_Cdouble(fill(zero(Cdouble),3)...)
    end

# begin enum CHRP_CELL_TYPES
typealias CHRP_CELL_TYPES Uint32
const ORTHOROMBIC = (UInt32)(0)
const TRICLINIC = (UInt32)(1)
const INFINITE = (UInt32)(2)
# end enum CHRP_CELL_TYPES

# begin enum chrp_cell_type_t
typealias chrp_cell_type_t Uint32
const ORTHOROMBIC = (UInt32)(0)
const TRICLINIC = (UInt32)(1)
const INFINITE = (UInt32)(2)
# end enum chrp_cell_type_t
