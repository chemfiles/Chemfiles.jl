# Chemfiles.jl, a modern library for chemistry file reading and writing
# Copyright (C) Guillaume Fraux and contributors -- BSD license

export lengths, set_lengths!, angles, set_angles!, cell_matrix, shape,
set_shape!, volume, CellShape, wrap!

struct CellShape
    value::lib.chfl_cellshape

"""
The possible shape for an unit cell are:

- ``Chemfiles.ORTHORHOMBIC`` for unit cells with the three angles are 90°.
- ``Chemfiles.TRICLINIC`` for unit cells where the three angles may not be 90°.
- ``Chemfiles.INFINITE`` for unit cells without boundaries.
"""
    function CellShape(value)
        value = lib.chfl_cellshape(value)
        if value in [lib.CHFL_CELL_INFINITE, lib.CHFL_CELL_ORTHORHOMBIC, lib.CHFL_CELL_TRICLINIC]
            return new(value)
        else
            throw(ChemfilesError("Invalid value for conversion to CellShape: $value"))
        end
    end
end

Base.:(==)(x::CellShape, y::CellShape) = x.value == y.value

const ORTHORHOMBIC = CellShape(lib.CHFL_CELL_ORTHORHOMBIC)
const TRICLINIC = CellShape(lib.CHFL_CELL_TRICLINIC)
const INFINITE = CellShape(lib.CHFL_CELL_INFINITE)

"""
Create an ``UnitCell`` from the three lenghts, with all the angles equal to 90°.
"""
function UnitCell(a::Number, b::Number, c::Number)
    handle = lib.chfl_cell(Float64[a, b, c])
    return UnitCell(handle)
end

"""
Create an ``UnitCell`` from the three lenghts and three angles.
"""
function UnitCell(a::Number, b::Number, c::Number, α::Number, β::Number, γ::Number)
    handle = lib.chfl_cell_triclinic(Float64[a, b, c], Float64[α, β, γ])
    return UnitCell(handle)
end


"""
Get a copy of the ``UnitCell`` of a ``frame``.
"""
function UnitCell(frame::Frame)
    handle = lib.chfl_cell_from_frame(frame.handle)
    return UnitCell(handle)
end

"""
Get the unit ``cell`` volume.
"""
function volume(cell::UnitCell)
    result = Ref{Float64}(0)
    _check(
        lib.chfl_cell_volume(cell.handle, result)
    )
    return result[]
end

"""
Get the three ``cell`` lengths (a, b and c) in angstroms.
"""
function lengths(cell::UnitCell)
    result = Float64[0, 0, 0]
    _check(
        lib.chfl_cell_lengths(cell.handle, result)
    )
    return result
end

"""
Set the ``cell`` lengths to ``a``, ``b`` and ``c``.

``a``, ``b`` and ``c`` should be in angstroms.
"""
function set_lengths!(cell::UnitCell, a::Real, b::Real, c::Real)
    _check(
        lib.chfl_cell_set_lengths(cell.handle, Float64[a, b, c])
    )
    return nothing
end

"""
Get the three ``cell`` angles (alpha, beta and gamma) in degrees.
"""
function angles(cell::UnitCell)
    result = Float64[0, 0, 0]
    _check(
        lib.chfl_cell_angles(cell.handle, result)
    )
    return result
end

"""
Set the `cell` angles to ``α``, ``β`` and ``γ``.

``α``, ``β`` and ``γ`` should be in degrees.
"""
function set_angles!(cell::UnitCell, α::Real, β::Real, γ::Real)
    _check(
        lib.chfl_cell_set_angles(cell.handle, Float64[α, β, γ])
    )
    return nothing
end

"""
Get the ``cell`` matricial representation, *i.e.* the representation of the
three base vectors as::

        | a_x   b_x   c_x |
        |  0    b_y   c_y |
        |  0     0    c_z |
"""
function cell_matrix(cell::UnitCell)
    matrix = Array{Float64}(undef, 3, 3)
    _check(
        lib.chfl_cell_matrix(cell.handle, pointer(matrix))
    )
    return matrix
end

"""
Get the ``cell`` shape, as a ``CellShape`` value.
"""
function shape(cell::UnitCell)
    result = Ref{lib.chfl_cellshape}(0)
    _check(
        lib.chfl_cell_shape(cell.handle, result)
    )
    return CellShape(result[])
end

"""
Set the ``cell`` shape to the given ``shape``.
"""
function set_shape!(cell::UnitCell, shape::CellShape)
    _check(
        lib.chfl_cell_set_shape(cell.handle, shape.value)
    )
    return nothing
end

"""
Wrap a `vector` in the unit `cell`.
"""
function wrap!(cell::UnitCell, vector::Vector{Float64})
    _check(
        lib.chfl_cell_wrap(cell.handle, vector)
    )
    return vector
end

"""
Make a deep copy of a ``cell``.
"""
function Base.deepcopy(cell::UnitCell)
    handle = lib.chfl_cell_copy(cell.handle)
    return UnitCell(handle)
end
