# Copyright (c) Guillaume Fraux 2015
#
# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at http://mozilla.org/MPL/2.0/.

export lengths, set_lengths!, angles, set_angles!, cell_matrix, cell_matrix!,
       cell_type, set_cell_type!, periodicity, set_periodicity!, volume

function UnitCell(a::Number, b::Number, c::Number,
                  alpha::Number=90, beta::Number=90, gamma::Number=90)
    handle = lib.chfl_cell(Cdouble(a), Cdouble(b), Cdouble(c), Cdouble(alpha), Cdouble(beta), Cdouble(gamma))
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
    V = Cdouble[0]
    check(
        lib.chfl_cell_volume(cell.handle, pointer(V))
    )
    return V[1]
end

function lengths(cell::UnitCell)
    a = Cdouble[0]
    b = Cdouble[0]
    c = Cdouble[0]
    check(
        lib.chfl_cell_lengths(cell.handle, pointer(a), pointer(b), pointer(c))
    )
    return (a[1], b[1], c[1])
end

function set_lengths!(cell::UnitCell, a::Real, b::Real, c::Real)
    check(
        lib.chfl_cell_set_lengths(cell.handle, Cdouble(a), Cdouble(b), Cdouble(c))
    )
    return nothing
end

function angles(cell::UnitCell)
    alpha = Cdouble[0]
    beta = Cdouble[0]
    gamma = Cdouble[0]
    check(
        lib.chfl_cell_angles(cell.handle, pointer(alpha), pointer(beta), pointer(gamma))
    )
    return (alpha[1], beta[1], gamma[1])
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
    res = CellType[0]
    check(
        lib.chfl_cell_type(cell.handle, pointer(res))
    )
    return res[1]
end

function set_cell_type!(cell::UnitCell, cell_type::CellType)
    check(
        lib.chfl_cell_set_type(cell.handle, cell_type)
    )
    return nothing
end

function periodicity(cell::UnitCell)
    res = Bool[false, false, false]
    check(
        lib.chfl_cell_periodicity(cell.handle, pointer(res), pointer(res)+1, pointer(res)+2)
    )
    return res
end

function set_periodicity!(cell::UnitCell, x::Bool, y::Bool, z::Bool)
    check(
        lib.chfl_cell_set_periodicity(cell.handle, x, y, z)
    )
    return nothing
end
