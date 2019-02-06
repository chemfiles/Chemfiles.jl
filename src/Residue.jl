# Chemfiles.jl, a modern library for chemistry file reading and writing
# Copyright (C) Guillaume Fraux and contributors -- BSD license

export name, id, add_atom!, residue_for_atom, contains

"""
Create a new residue with the given ``name``.
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

"""
Get the name of a ``residue``.
"""
function name(residue::Residue)
    return _call_with_growing_buffer(
        (buffer, size) -> _check(lib.chfl_residue_name(residue.handle, buffer, size))
    )
end

"""
Get the identifier of a ``residue`` in the initial topology.
"""
function id(residue::Residue)
    resid = Ref{UInt64}(0)
    _check(
        lib.chfl_residue_id(residue.handle, resid)
    )
    return resid[]
end

"""
Get the number of atoms in a ``residue``.
"""
function Base.size(residue::Residue)
    atoms = Ref{UInt64}(0)
    _check(
        lib.chfl_residue_atoms_count(residue.handle, atoms)
    )
    return atoms[]
end

"""
Add the atom at the given ``index`` in the ``residue``.
"""
function add_atom!(residue::Residue, index::Integer)
    _check(
        lib.chfl_residue_add_atom(residue.handle, UInt64(index))
    )
    return nothing
end

"""
Check if the atom at the given ``index`` is in the ``residue``.
"""
function contains(residue::Residue, index::Integer)
    result = Ref{UInt8}(0)
    _check(
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
