# Copyright (c) Guillaume Fraux 2015
#
# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at http://mozilla.org/MPL/2.0/.

export name, id, natoms, add_atom!, residue_for_atom

function Residue(name::String, resid::Integer)
    handle = lib.chfl_residue(pointer(name), UInt64(resid))
    return Residue(handle)
end

function Residue(name::String)
    handle = lib.chfl_residue(pointer(name), typemax(UInt64))
    return Residue(handle)
end

function Residue(topology::Topology, index::Integer)
    handle = lib.chfl_residue_from_topology(topology.handle, UInt64(index))
    return Residue(handle)
end

function residue_for_atom(topology::Topology, index::Integer)
    handle = lib.chfl_residue_for_atom(topology.handle, UInt64(index))
    return Residue(handle)
end


function free(residue::Residue)
    lib.chfl_residue_free(residue.handle)
end

function name(residue::Residue)
    str = " " ^ 10
    check(
        lib.chfl_residue_name(residue.handle, pointer(str), UInt64(length(str)))
    )
    return strip_null(str)
end

function id(residue::Residue)
    resid = Ref{UInt64}(0)
    check(
        lib.chfl_residue_id(residue.handle, resid)
    )
    return resid[]
end

function natoms(residue::Residue)
    atoms = Ref{UInt64}(0)
    check(
        lib.chfl_residue_atoms_count(residue.handle, atoms)
    )
    return atoms[]
end

Base.size(residue::Residue) = natoms(residue)

function add_atom!(residue::Residue, i::Integer)
    check(
        lib.chfl_residue_add_atom(residue.handle, UInt64(i))
    )
    return nothing
end

function Base.contains(residue::Residue, i::Integer)
    res = Ref{UInt8}(0)
    check(
        lib.chfl_residue_contains(residue.handle, UInt64(i), res)
    )
    return convert(Bool, res[])
end
