# Chemfiles.jl, a modern library for chemistry file reading and writing
# Copyright (C) Guillaume Fraux and contributors -- BSD license

export remove!, bonds_count, angles_count, dihedrals_count, impropers_count,
bonds, angles, dihedrals, impropers, add_bond!, remove_bond!, add_residue!,
residues, are_linked, count_residues

"""
Create an empty ``Topology``.
"""
function Topology()
    return Topology(lib.chfl_topology())
end

"""
Get a copy of the ``Topology`` of the given ``frame``.
"""
function Topology(frame::Frame)
    return Topology(lib.chfl_topology_from_frame(frame.handle))
end

"""
Free the allocated memory for the ``Topology`` object.
"""
function _free(topology::Topology)
    lib.chfl_topology_free(topology.handle)
end

"""
Get the ``Topology`` size, i.e. the current number of atoms.
"""
function Base.size(topology::Topology)
    n = Ref{UInt64}(0)
    _check(
        lib.chfl_topology_atoms_count(topology.handle, n)
    )
    return n[]
end

"""
Add an ``atom`` at the end of a ``topology``.
"""
function add_atom!(topology::Topology, atom::Atom)
    _check(
        lib.chfl_topology_add_atom(topology.handle, atom.handle)
    )
    return nothing
end

"""
Remove the atom at the given ``index`` from a ``topology``.
"""
function remove!(topology::Topology, index::Integer)
    _check(
        lib.chfl_topology_remove(topology.handle, UInt64(index))
    )
    return nothing
end

"""
Get the number of bonds in the ``topology``.
"""
function bonds_count(topology::Topology)
    n = Ref{UInt64}(0)
    _check(
        lib.chfl_topology_bonds_count(topology.handle, n)
    )
    return n[]
end

"""
Get the number of angles in the ``topology``.
"""
function angles_count(topology::Topology)
    n = Ref{UInt64}(0)
    _check(
        lib.chfl_topology_angles_count(topology.handle, n)
    )
    return n[]
end

"""
Get the number of dihedral angles in the ``topology``.
"""
function dihedrals_count(topology::Topology)
    n = Ref{UInt64}(0)
    _check(
        lib.chfl_topology_dihedrals_count(topology.handle, n)
    )
    return n[]
end

"""
Get the number of improper angles in the ``topology``.
"""
function impropers_count(topology::Topology)
    n = Ref{UInt64}(0)
    _check(
        lib.chfl_topology_impropers_count(topology.handle, n)
    )
    return n[]
end

"""
Get the bonds in the ``topology``, in a ``2 x bonds_count(topology)`` array.
"""
function bonds(topology::Topology)
    count = bonds_count(topology)
    result = Array{UInt64}(2, count)
    _check(
        lib.chfl_topology_bonds(topology.handle, pointer(result), count)
    )
    return result
end

"""
Get the angles in the ``topology``, in a ``3 x angles_count(topology)`` array.
"""
function angles(topology::Topology)
    count = angles_count(topology)
    result = Array{UInt64}(3, count)
    _check(
        lib.chfl_topology_angles(topology.handle, pointer(result), count)
    )
    return result
end

"""
Get the dihedral angles in the ``topology``, in a ``4 x dihedrals_count(topology)``
array.
"""
function dihedrals(topology::Topology)
    count = dihedrals_count(topology)
    result = Array{UInt64}(4, count)
    _check(
        lib.chfl_topology_dihedrals(topology.handle, pointer(result), count)
    )
    return result
end

"""
Get the improper angles in the ``topology``, in a ``4 x impropers_count(topology)``
array.
"""
function impropers(topology::Topology)
    count = impropers_count(topology)
    result = Array{UInt64}(4, count)
    _check(
        lib.chfl_topology_impropers(topology.handle, pointer(result), count)
    )
    return result
end

"""
Add a bond between the atoms ``i`` and ``j`` in the ``topology``.
"""
function add_bond!(topology::Topology, i::Integer, j::Integer)
    _check(
        lib.chfl_topology_add_bond(topology.handle, UInt64(i), UInt64(j))
    )
    return nothing
end

"""
Remove any existing bond between the atoms ``i`` and ``j`` in the ``topology``.
"""
function remove_bond!(topology::Topology, i::Integer, j::Integer)
    _check(
        lib.chfl_topology_remove_bond(topology.handle, UInt64(i), UInt64(j))
    )
    return nothing
end

"""
Add a copy of ``residue`` to this ``topology``.

The residue id must not already be in the topology, and the residue must
contain only atoms that are not already in another residue.
"""
function add_residue!(topology::Topology, residue::Residue)
    _check(
        lib.chfl_topology_add_residue(topology.handle, residue.handle)
    )
    return nothing
end

"""
Get the number of residues in the ``topology``.
"""
function count_residues(topology::Topology)
    nresidues = Ref{UInt64}(0)
    _check(
        lib.chfl_topology_residues_count(topology.handle, nresidues)
    )
    return nresidues[]
end

"""
Check if the two residues ``first`` and ``second`` from the ``topology`` are
linked together. *i.e.* if there is a bond between one atom in the first
residue and one atom in the second one.
"""
function are_linked(topology::Topology, first::Residue, second::Residue)
    result = Ref{UInt8}(0)
    _check(
        lib.chfl_topology_residues_linked(topology.handle, first.handle, second.handle, result)
    )
    return convert(Bool, result[])
end

"""
Resize the ``topology`` to hold ``natoms`` atoms. If the new number of atoms is
bigger than the current number, new atoms will be created with an empty name
and type.

If it is lower than the current number of atoms, the last atoms will be removed,
together with the associated bonds, angles and dihedrals.
"""
function Base.resize!(topology::Topology, size::Integer)
    _check(
        lib.chfl_topology_resize(topology.handle, UInt64(size))
    )
end

"""
Make a deep copy of a ``topology``.
"""
function Base.deepcopy(topology::Topology)
    handle = lib.chfl_topology_copy(topology.handle)
    return Topology(handle)
end
