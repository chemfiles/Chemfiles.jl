# Copyright (c) Guillaume Fraux 2015
#
# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at http://mozilla.org/MPL/2.0/.

export lengths, set_lengths!, angles, set_angles!, cell_matrix, cell_matrix!, cell_type,
set_cell_type!, volume, CellType

immutable CellType
    value::lib.CHFL_CELL_TYPES

    function CellType(value)
        value = lib.CHFL_CELL_TYPES(value)
        if value in [lib.CHFL_CELL_INFINITE, lib.CHFL_CELL_ORTHOROMBIC, lib.CHFL_CELL_TRICLINIC]
            return new(value)
        else
            throw(ChemfilesError("Invalid value for conversion to CellType: $value"))
        end
    end
end

const ORTHOROMBIC = CellType(lib.CHFL_CELL_ORTHOROMBIC)
const TRICLINIC = CellType(lib.CHFL_CELL_TRICLINIC)
const INFINITE = CellType(lib.CHFL_CELL_INFINITE)

function UnitCell(a::Number, b::Number, c::Number)
    handle = lib.chfl_cell(Cdouble(a), Cdouble(b), Cdouble(c))
    return UnitCell(handle)
end

function UnitCell(a::Number, b::Number, c::Number, α::Number, β::Number, γ::Number)
    handle = lib.chfl_cell_triclinic(Cdouble(a), Cdouble(b), Cdouble(c), Cdouble(α), Cdouble(β), Cdouble(γ))
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
    V = Ref{Cdouble}(0)
    check(
        lib.chfl_cell_volume(cell.handle, V)
    )
    return V[]
end

function lengths(cell::UnitCell)
    a = Ref{Cdouble}(0)
    b = Ref{Cdouble}(0)
    c = Ref{Cdouble}(0)
    check(
        lib.chfl_cell_lengths(cell.handle, a, b, c)
    )
    return (a[], b[], c[])
end

function set_lengths!(cell::UnitCell, a::Real, b::Real, c::Real)
    check(
        lib.chfl_cell_set_lengths(cell.handle, Cdouble(a), Cdouble(b), Cdouble(c))
    )
    return nothing
end

function angles(cell::UnitCell)
    alpha = Ref{Cdouble}(0)
    beta = Ref{Cdouble}(0)
    gamma = Ref{Cdouble}(0)
    check(
        lib.chfl_cell_angles(cell.handle, alpha, beta, gamma)
    )
    return (alpha[], beta[], gamma[])
end

function set_angles!(cell::UnitCell, alpha::Real, beta::Real, gamma::Real)
    check(
        lib.chfl_cell_set_angles(cell.handle, Cdouble(alpha), Cdouble(beta), Cdouble(gamma))
    )
    return nothing
end

function cell_matrix!(cell::UnitCell, mat::Array{Cdouble, 2})
    check(
        lib.chfl_cell_matrix(cell.handle, pointer(mat))
    )
    return mat
end

function cell_matrix(cell::UnitCell)
    mat = Array(Cdouble, 3, 3)
    return cell_matrix!(cell, mat)
end

function cell_type(cell::UnitCell)
    res = Ref{lib.CHFL_CELL_TYPES}(0)
    check(
        lib.chfl_cell_type(cell.handle, res)
    )
    return CellType(res[])
end

function set_cell_type!(cell::UnitCell, ctype::CellType)
    check(
        lib.chfl_cell_set_type(cell.handle, ctype.value)
    )
    return nothing
end
