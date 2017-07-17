# Copyright (c) Guillaume Fraux 2015
#
# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at http://mozilla.org/MPL/2.0/.

export name, id, add_atom!, residue_for_atom

"""
    Residue(name::String, resid::Integer)

Create a new residue with the given ``name`` and residue identifier ``resid``.
"""
function Residue(name::String, resid::Integer)
    handle = lib.chfl_residue(pointer(name), UInt64(resid))
    return Residue(handle)
end

"""
    Residue(name::String)

Create a new residue with the given ``name``.
"""
function Residue(name::String)
    handle = lib.chfl_residue(pointer(name), typemax(UInt64))
    return Residue(handle)
end

"""
    Residue(topology::Topology, index::Integer)

Get a copy of the residue at ``index`` from a ``topology``.

If ``index`` is bigger than the result of ``count_residues``, this function will return `nothing`.

The residue index in the topology is not always the same as the residue ``id``.
"""
function Residue(topology::Topology, index::Integer)
    handle = lib.chfl_residue_from_topology(topology.handle, UInt64(index))
    return Residue(handle)
end

"""
    residue_for_atom(topology::Topology, index::Integer)

Get a copy of the residue containing the atom at ``index`` in the ``topology``.

This function will return ``nothing`` if the atom is not in a residue, or if the ``index`` is bigger than ``natoms``.
"""
function residue_for_atom(topology::Topology, index::Integer)
    handle = lib.chfl_residue_for_atom(topology.handle, UInt64(index))
    return Residue(handle)
end


function free(residue::Residue)
    lib.chfl_residue_free(residue.handle)
end

"""
    name(residue::Residue)

Get the name of a ``residue``.
"""
function name(residue::Residue)
    str = " " ^ 10
    check(
        lib.chfl_residue_name(residue.handle, pointer(str), UInt64(length(str)))
    )
    return strip_null(str)
end

"""
    id(residue::Residue)

Get the identifier of a ``residue`` in the initial topology.
"""
function id(residue::Residue)
    resid = Ref{UInt64}(0)
    check(
        lib.chfl_residue_id(residue.handle, resid)
    )
    return resid[]
end

"""
    size(residue::Residue)

Get the number of atoms in a ``residue``.
"""
function Base.size(residue::Residue)
    atoms = Ref{UInt64}(0)
    check(
        lib.chfl_residue_atoms_count(residue.handle, atoms)
    )
    return atoms[]
end

"""
    add_atom!(residue::Residue, i::Integer)

Add the atom at index ``i`` in the ``residue``.
"""
function add_atom!(residue::Residue, i::Integer)
    check(
        lib.chfl_residue_add_atom(residue.handle, UInt64(i))
    )
    return nothing
end

"""
    contains(residue::Residue, i::Integer)

Check if the atom at index ``i`` is in the ``residue``.
"""
function Base.contains(residue::Residue, i::Integer)
    result = Ref{UInt8}(0)
    check(
        lib.chfl_residue_contains(residue.handle, UInt64(i), result)
    )
    return convert(Bool, result[])
end

"""
    deepcopy(residue::Residue)

Get a copy of an ``residue``.
"""
function Base.deepcopy(residue::Residue)
    handle = lib.chfl_residue_copy(residue.handle)
    return Residue(handle)
end
