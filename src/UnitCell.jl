# Chemfiles.jl, a modern library for chemistry file reading and writing
# Copyright (C) Guillaume Fraux and contributors -- BSD license

export lengths, set_lengths!, angles, set_angles!
export shape, set_shape!, CellShape, volume, matrix, wrap!

__ptr(cell::UnitCell) = __ptr(cell.__handle)
__const_ptr(cell::UnitCell) = __const_ptr(cell.__handle)

"""
The possible shape for an unit cell are:

- `Chemfiles.Orthorhombic` for unit cells with the three angles are 90°.
- `Chemfiles.Triclinic` for unit cells where the three angles may not be 90°.
- `Chemfiles.Infinite` for unit cells without boundaries.
"""
@enum CellShape begin
    Infinite = lib.CHFL_CELL_INFINITE
    Orthorhombic = lib.CHFL_CELL_ORTHORHOMBIC
    Triclinic = lib.CHFL_CELL_TRICLINIC
end

"""
Create an `UnitCell` from the given `lengths` and `angles`.
"""
function UnitCell(lengths::Vector{Float64}, angles::Vector{Float64}=[90.0, 90.0, 90.0])
    @assert length(lengths) == 3
    @assert length(angles) == 3
    ptr = @__check_ptr(lib.chfl_cell(lengths, angles))
    return UnitCell(CxxPointer(ptr, is_const=false))
end

"""
Create an `UnitCell` from the given 3x3 cell `matrix`.
"""
function UnitCell(matrix::Array{Float64,2})
    @assert size(matrix) == (3, 3)
    ptr = @__check_ptr(lib.chfl_cell_from_matrix(pointer(matrix)))
    return UnitCell(CxxPointer(ptr, is_const=false))
end


"""
Get a copy of the `UnitCell` of a `frame`.
"""
function UnitCell(frame::Frame)
    ptr = @__check_ptr(lib.chfl_cell_from_frame(__const_ptr(frame)))
    cell = UnitCell(CxxPointer(ptr, is_const=false))
    copy = deepcopy(cell)
    finalize(cell)
    return copy
end

"""
Get the unit `cell` volume.
"""
function volume(cell::UnitCell)
    result = Ref{Float64}(0)
    __check(lib.chfl_cell_volume(__const_ptr(cell), result))
    return result[]
end

"""
Get the three cell lengths in angstroms.
"""
function lengths(cell::UnitCell)
    result = Float64[0, 0, 0]
    __check(lib.chfl_cell_lengths(__const_ptr(cell), result))
    return result
end

"""
Set the cell `lengths` to the given values. The lengths should be in angstroms.
"""
function set_lengths!(cell::UnitCell, lengths::Vector{Float64})
    @assert length(lengths) == 3
    __check(lib.chfl_cell_set_lengths(__ptr(cell), lengths))
    return nothing
end

"""
Get the three cell angles in degrees.
"""
function angles(cell::UnitCell)
    result = Float64[0, 0, 0]
    __check(lib.chfl_cell_angles(__const_ptr(cell), result))
    return result
end

"""
Set the cell `angles` to the given values. The angles should be in degrees.
"""
function set_angles!(cell::UnitCell, angles::Vector{Float64})
    @assert length(angles) == 3
    __check(lib.chfl_cell_set_angles(__ptr(cell), angles))
return nothing
end

"""
Get the `cell` matricial representation, *i.e.* the representation of the
three base vectors as:

        | a_x   b_x   c_x |
        |  0    b_y   c_y |
        |  0     0    c_z |
"""
function matrix(cell::UnitCell)
    result = Array{Float64}(undef, 3, 3)
    __check(lib.chfl_cell_matrix(__const_ptr(cell), pointer(result)))
    return result
end

"""
Get the `cell` shape, as a `CellShape` value.
"""
function shape(cell::UnitCell)
    result = Ref{lib.chfl_cellshape}(0)
    __check(lib.chfl_cell_shape(__const_ptr(cell), result))
    return CellShape(result[])
end

"""
Set the `cell` shape to the given `shape`.
"""
function set_shape!(cell::UnitCell, shape::CellShape)
    __check(lib.chfl_cell_set_shape(__ptr(cell), lib.chfl_cellshape(shape)))
return nothing
end

"""
Wrap a `vector` in the unit `cell`.
"""
function wrap!(cell::UnitCell, vector::Vector{Float64})
    if length(vector) != 3
        throw(ChemfilesError("Can only wrap vectors containing 3 elements in an unit cell"))
    end
    __check(lib.chfl_cell_wrap(__const_ptr(cell), vector))
    return vector
end

"""
Make a deep copy of a `cell`.
"""
function Base.deepcopy(cell::UnitCell)
    ptr = lib.chfl_cell_copy(__const_ptr(cell))
    return UnitCell(CxxPointer(ptr, is_const=false))
end
