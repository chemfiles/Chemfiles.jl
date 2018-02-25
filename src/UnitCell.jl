# Copyright (c) Guillaume Fraux 2015
#
# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at http://mozilla.org/MPL/2.0/.

export lengths, set_lengths!, angles, set_angles!, cell_matrix, shape,
set_shape!, volume, CellShape

"""
The possible shape for an unit cell are:

- ``Chemfiles.ORTHORHOMBIC`` for unit cell with the three angles are 90°
- ``Chemfiles.TRICLINIC`` for unit cell where the three angles may not be 90°
- ``Chemfiles.INFINITE`` for unit cells without boundaries
"""
type CellShape
    value::lib.chfl_cellshape

    function CellShape(value)
        value = lib.chfl_cellshape(value)
        if value in [lib.CHFL_CELL_INFINITE, lib.CHFL_CELL_ORTHORHOMBIC, lib.CHFL_CELL_TRICLINIC]
            return new(value)
        else
            throw(ChemfilesError("Invalid value for conversion to CellShape: $value"))
        end
    end
end

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

function free(cell::UnitCell)
    check(
        lib.chfl_cell_free(cell.handle)
    )
    return nothing
end


"""
Get the unit ``cell`` volume
"""
function volume(cell::UnitCell)
    result = Ref{Float64}(0)
    check(
        lib.chfl_cell_volume(cell.handle, result)
    )
    return result[]
end

"""
Get the three ``cell`` lenghts (a, b and c) in angstroms.
"""
function lengths(cell::UnitCell)
    result = Float64[0, 0, 0]
    check(
        lib.chfl_cell_lengths(cell.handle, result)
    )
    return result
end

"""
Set the ``cell`` lenghts to ``a``, ``b`` and ``c``.

``a``, ``b`` and ``c`` should be in angstroms.
"""
function set_lengths!(cell::UnitCell, a::Real, b::Real, c::Real)
    check(
        lib.chfl_cell_set_lengths(cell.handle, Float64[a, b, c])
    )
    return nothing
end

"""
Get the three ``cell`` angles (alpha, beta and gamma) in degrees.
"""
function angles(cell::UnitCell)
    result = Float64[0, 0, 0]
    check(
        lib.chfl_cell_angles(cell.handle, result)
    )
    return result
end

"""
Set the `cell` angles to ``α``, ``β`` and ``γ``.

``α``, ``β`` and ``γ`` should be in degrees.
"""
function set_angles!(cell::UnitCell, α::Real, β::Real, γ::Real)
    check(
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
    matrix = Array{Float64}(3, 3)
    check(
        lib.chfl_cell_matrix(cell.handle, pointer(matrix))
    )
    return Array{Float64,2}(matrix)
end

"""
Get the ``cell`` shape, as a ``CellShape`` value
"""
function shape(cell::UnitCell)
    result = Ref{lib.chfl_cellshape}(0)
    check(
        lib.chfl_cell_shape(cell.handle, result)
    )
    return CellShape(result[])
end

"""
Set the ``cell`` shape to the given ``shape``.
"""
function set_shape!(cell::UnitCell, shape::CellShape)
    check(
        lib.chfl_cell_set_shape(cell.handle, shape.value)
    )
    return nothing
end

"""
Make a deep copy of a ``cell``.
"""
function Base.deepcopy(cell::UnitCell)
    handle = lib.chfl_cell_copy(cell.handle)
    return UnitCell(handle)
end
