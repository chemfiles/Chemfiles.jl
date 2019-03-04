# Chemfiles.jl, a modern library for chemistry file reading and writing
# Copyright (C) Guillaume Fraux and contributors -- BSD license

export lengths, set_lengths!, angles, set_angles!
export shape, set_shape!, CellShape, volume, matrix, wrap!

__ptr(cell::UnitCell) = __ptr(cell.__handle)
__const_ptr(cell::UnitCell) = __const_ptr(cell.__handle)

"""
The possible shape for an unit cell are:

- ``Chemfiles.Orthorhombic`` for unit cells with the three angles are 90°.
- ``Chemfiles.Triclinic`` for unit cells where the three angles may not be 90°.
- ``Chemfiles.Infinite`` for unit cells without boundaries.
"""
@enum CellShape begin
    Infinite = lib.CHFL_CELL_INFINITE
    Orthorhombic = lib.CHFL_CELL_ORTHORHOMBIC
    Triclinic = lib.CHFL_CELL_TRICLINIC
end

"""
Create an ``UnitCell`` from the three lenghts, with all the angles equal to 90°.
"""
function UnitCell(a::Number, b::Number, c::Number)
    ptr = lib.chfl_cell(Float64[a, b, c])
    return UnitCell(CxxPointer(ptr, is_const=false))
end

"""
Create an ``UnitCell`` from the three lenghts and three angles.
"""
function UnitCell(a::Number, b::Number, c::Number, α::Number, β::Number, γ::Number)
    ptr = lib.chfl_cell_triclinic(Float64[a, b, c], Float64[α, β, γ])
    return UnitCell(CxxPointer(ptr, is_const=false))
end


"""
Get a copy of the ``UnitCell`` of a ``frame``.
"""
function UnitCell(frame::Frame)
    ptr = lib.chfl_cell_from_frame(__const_ptr(frame))
    cell = UnitCell(CxxPointer(ptr, is_const=false))
    copy = deepcopy(cell)
    finalize(cell)
    return copy
end

"""
Get the unit ``cell`` volume.
"""
function volume(cell::UnitCell)
    result = Ref{Float64}(0)
    __check(lib.chfl_cell_volume(__const_ptr(cell), result))
    return result[]
end

"""
Get the three ``cell`` lengths (a, b and c) in angstroms.
"""
function lengths(cell::UnitCell)
    result = Float64[0, 0, 0]
    __check(lib.chfl_cell_lengths(__const_ptr(cell), result))
    return result
end

"""
Set the ``cell`` lengths to ``a``, ``b`` and ``c``.

``a``, ``b`` and ``c`` should be in angstroms.
"""
function set_lengths!(cell::UnitCell, a::Real, b::Real, c::Real)
    __check(lib.chfl_cell_set_lengths(__ptr(cell), Float64[a, b, c]))
    return nothing
end

"""
Get the three ``cell`` angles (alpha, beta and gamma) in degrees.
"""
function angles(cell::UnitCell)
    result = Float64[0, 0, 0]
    __check(lib.chfl_cell_angles(__const_ptr(cell), result))
    return result
end

"""
Set the `cell` angles to ``α``, ``β`` and ``γ``.

``α``, ``β`` and ``γ`` should be in degrees.
"""
function set_angles!(cell::UnitCell, α::Real, β::Real, γ::Real)
    __check(lib.chfl_cell_set_angles(__ptr(cell), Float64[α, β, γ]))
    return nothing
end

"""
Get the ``cell`` matricial representation, *i.e.* the representation of the
three base vectors as::

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
Get the ``cell`` shape, as a ``CellShape`` value.
"""
function shape(cell::UnitCell)
    result = Ref{lib.chfl_cellshape}(0)
    __check(lib.chfl_cell_shape(__const_ptr(cell), result))
    return CellShape(result[])
end

"""
Set the ``cell`` shape to the given ``shape``.
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
Make a deep copy of a ``cell``.
"""
function Base.deepcopy(cell::UnitCell)
    ptr = lib.chfl_cell_copy(__const_ptr(cell))
    return UnitCell(CxxPointer(ptr, is_const=false))
end
