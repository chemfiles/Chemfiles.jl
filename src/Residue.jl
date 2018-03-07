# Copyright (c) Guillaume Fraux 2015
#
# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at http://mozilla.org/MPL/2.0/.

export name, id, add_atom!, residue_for_atom

"""
Create a new residue with the given ``name``
"""
function Residue(name::String)
    handle = lib.chfl_residue(pointer(name))
    return Residue(handle)
end

"""
Create a new residue with the given ``name`` and residue identifier ``resid``.
"""
function Residue(name::String, resid::Integer)
    handle = lib.chfl_residue_with_id(pointer(name), UInt64(resid))
    return Residue(handle)
end

"""
Get a copy of the residue at ``index`` from a ``topology``.

The residue index in the topology is not always the same as the residue
identifier.
"""
function Residue(topology::Topology, index::Integer)
    handle = lib.chfl_residue_from_topology(topology.handle, UInt64(index))
    return Residue(handle)
end

"""
Get a copy of the residue containing the atom at ``index`` in the ``topology``.

This function will return ``nothing`` if the atom is not in a residue, or if
the ``index`` is bigger than the number of atoms in the topology.
"""
function residue_for_atom(topology::Topology, index::Integer)
    handle = lib.chfl_residue_for_atom(topology.handle, UInt64(index))
    if Int(handle) == 0
        return nothing
    else
        return Residue(handle)
    end
end


function free(residue::Residue)
    lib.chfl_residue_free(residue.handle)
end

"""
Get the name of a ``residue``.
"""
function name(residue::Residue)
    return _call_with_growing_buffer(
        (buffer, size) -> check(lib.chfl_residue_name(residue.handle, buffer, size))
    )
end

"""
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
Add the atom at the given ``index`` in the ``residue``.
"""
function add_atom!(residue::Residue, index::Integer)
    check(
        lib.chfl_residue_add_atom(residue.handle, UInt64(index))
    )
    return nothing
end

"""
Check if the atom at the given ``index`` is in the ``residue``.
"""
function Base.contains(residue::Residue, index::Integer)
    result = Ref{UInt8}(0)
    check(
        lib.chfl_residue_contains(residue.handle, UInt64(index), result)
    )
    return convert(Bool, result[])
end

"""
Make a deep copy of a ``residue``.
"""
function Base.deepcopy(residue::Residue)
    handle = lib.chfl_residue_copy(residue.handle)
    return Residue(handle)
end
