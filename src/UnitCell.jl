# Copyright (c) Guillaume Fraux 2015
#
# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at http://mozilla.org/MPL/2.0/.

export lengths, set_lengths!, angles, set_angles!, cell_matrix, shape,
set_shape!, volume, CellShape

immutable CellShape
    value::lib.chfl_cell_shape_t

    function CellShape(value)
        value = lib.chfl_cell_shape_t(value)
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

function UnitCell(a::Number, b::Number, c::Number)
    handle = lib.chfl_cell(Float64[a, b, c])
    return UnitCell(handle)
end

function UnitCell(a::Number, b::Number, c::Number, α::Number, β::Number, γ::Number)
    handle = lib.chfl_cell_triclinic(Float64[a, b, c], Float64[α, β, γ])
    return UnitCell(handle)
end

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

function volume(cell::UnitCell)
    result = Ref{Float64}(0)
    check(
        lib.chfl_cell_volume(cell.handle, result)
    )
    return result[]
end

function lengths(cell::UnitCell)
    result = Float64[0, 0, 0]
    check(
        lib.chfl_cell_lengths(cell.handle, result)
    )
    return result
end

function set_lengths!(cell::UnitCell, a::Real, b::Real, c::Real)
    check(
        lib.chfl_cell_set_lengths(cell.handle, Float64[a, b, c])
    )
    return nothing
end

function angles(cell::UnitCell)
    result = Float64[0, 0, 0]
    check(
        lib.chfl_cell_angles(cell.handle, result)
    )
    return result
end

function set_angles!(cell::UnitCell, α::Real, β::Real, γ::Real)
    check(
        lib.chfl_cell_set_angles(cell.handle, Float64[α, β, γ])
    )
    return nothing
end

function cell_matrix(cell::UnitCell)
    matrix = Array{Float64}(3, 3)
    check(
        lib.chfl_cell_matrix(cell.handle, pointer(matrix))
    )
    return Array{Float64,2}(matrix)
end

function shape(cell::UnitCell)
    res = Ref{lib.chfl_cell_shape_t}(0)
    check(
        lib.chfl_cell_shape(cell.handle, res)
    )
    return CellShape(res[])
end

function set_shape!(cell::UnitCell, shape::CellShape)
    check(
        lib.chfl_cell_set_shape(cell.handle, shape.value)
    )
    return nothing
end
