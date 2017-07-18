# Copyright (c) Guillaume Fraux 2015
#
# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at http://mozilla.org/MPL/2.0/.

export remove!, isbond, isangle, isdihedral, nbonds, nangles, ndihedrals,
    bonds, angles, dihedrals, add_bond!, remove_bond!, add_residue!, residues,
    are_linked, count_residues

"""
    Topology()

Create an empty ``Topology``.
"""
function Topology()
    return Topology(lib.chfl_topology())
end

"""
    Topology(frame::Frame)

Extract the ``Topology`` from a frame.
"""
function Topology(frame::Frame)
    return Topology(lib.chfl_topology_from_frame(frame.handle))
end

function free(topology::Topology)
    lib.chfl_topology_free(topology.handle)
end

"""
    size(topology::Topology)

Get the ``Topology`` size, i.e. the current number of atoms.
"""
function Base.size(topology::Topology)
    n = Ref{UInt64}(0)
    check(
        lib.chfl_topology_atoms_count(topology.handle, n)
    )
    return n[]
end

"""
    add_atom!(topology::Topology, atom::Atom)

Add an ``Atom`` at the end of a ``Topology``.
"""
function add_atom!(topology::Topology, atom::Atom)
    check(
        lib.chfl_topology_add_atom(topology.handle, atom.handle)
    )
    return nothing
end

"""
    remove!(topology::Topology, i::Integer)

Remove an atom from a ``Topology`` at index ``i``.
"""
function remove!(topology::Topology, i::Integer)
    check(
        lib.chfl_topology_remove(topology.handle, UInt64(i))
    )
    return nothing
end

"""
    isbond(topology::Topology, i::Integer, j::Integer)

Tell if the atoms ``i`` and ``j`` are bonded together.
"""
function isbond(topology::Topology, i::Integer, j::Integer)
    result = Ref{UInt8}(0)
    check(
        lib.chfl_topology_isbond(topology.handle, UInt64(i), UInt64(j), result)
    )
    return convert(Bool, result[])
end

"""
    isangle(topology::Topology, i::Integer, j::Integer, k::Integer)

Tell if the atoms ``i``, ``j`` and ``k`` constitues an angle.
"""
function isangle(topology::Topology, i::Integer, j::Integer, k::Integer)
    result = Ref{UInt8}(0)
    check(
        lib.chfl_topology_isangle(topology.handle, UInt64(i), UInt64(j), UInt64(k), result)
    )
    return convert(Bool, result[])
end

"""
    isdihedral(topology::Topology, i::Integer, j::Integer, k::Integer, m::Integer)

Tell if the atoms ``i``, ``j``, ``k`` and ``m`` constitues a dihedral angle.
"""
function isdihedral(topology::Topology, i::Integer, j::Integer, k::Integer, m::Integer)
    result = Ref{UInt8}(0)
    check(
        lib.chfl_topology_isdihedral(topology.handle, UInt64(i), UInt64(j), UInt64(k), UInt64(m), result)
    )
    return convert(Bool, result[])
end

"""
    nbonds(topology::Topology)

Get the number of bonds in the system.
"""
function nbonds(topology::Topology)
    n = Ref{UInt64}(0)
    check(
        lib.chfl_topology_bonds_count(topology.handle, n)
    )
    return n[]
end

"""
    nangles(topology::Topology)

Get the number of angles in the system.
"""
function nangles(topology::Topology)
    n = Ref{UInt64}(0)
    check(
        lib.chfl_topology_angles_count(topology.handle, n)
    )
    return n[]
end

"""
    ndihedrals(topology::Topology)

Get the number of dihedral angles in the system.
"""
function ndihedrals(topology::Topology)
    n = Ref{UInt64}(0)
    check(
        lib.chfl_topology_dihedrals_count(topology.handle, n)
    )
    return n[]
end

"""
    bonds(topology::Topology)

Get the bonds in the system, arranged in a 2x ``nbonds`` array.
"""
function bonds(topology::Topology)
    count = nbonds(topology)
    result = Array{UInt64}(2, count)
    check(
        lib.chfl_topology_bonds(topology.handle, pointer(result), count)
    )
    return result
end

"""
    angles(topology::Topology)

Get the angles in the system, arranges as a 3x ``nangles`` array.
"""
function angles(topology::Topology)
    count = nangles(topology)
    result = Array{UInt64}(3, count)
    check(
        lib.chfl_topology_angles(topology.handle, pointer(result), count)
    )
    return result
end

"""
    dihedrals(topology::Topology)

Get the dihedral angles in the system, arranged as a 4x ``ndihedrals`` array."""
function dihedrals(topology::Topology)
    count = ndihedrals(topology)
    result = Array{UInt64}(4, count)
    check(
        lib.chfl_topology_dihedrals(topology.handle, pointer(result), count)
    )
    return result
end

"""
    add_bond!(topology::Topology, i::Integer, j::Integer)

Add a bond between the atoms ``i`` and ``j`` in the system.
"""
function add_bond!(topology::Topology, i::Integer, j::Integer)
    check(
        lib.chfl_topology_add_bond(topology.handle, UInt64(i), UInt64(j))
    )
    return nothing
end

"""
    remove_bond!(topology::Topology, i::Integer, j::Integer)

Remove any existing bond between the atoms ``i`` and ``j`` in the system.
"""
function remove_bond!(topology::Topology, i::Integer, j::Integer)
    check(
        lib.chfl_topology_remove_bond(topology.handle, UInt64(i), UInt64(j))
    )
    return nothing
end

"""
    add_residue!(topology::Topology, residue::Residue)

Add a copy of ``residue`` to this ``topology``.

The residue id must not already be in the topology, and the residue must contain only atoms that are not already in another residue.
"""
function add_residue!(topology::Topology, residue::Residue)
    check(
        lib.chfl_topology_add_residue(topology.handle, residue.handle)
    )
    return nothing
end

"""
    count_residues(topology::Topology)

Get the number of residues in the ``topology``.
"""
function count_residues(topology::Topology)
    nresidues = Ref{UInt64}(0)
    check(
        lib.chfl_topology_residues_count(topology.handle, nresidues)
    )
    return nresidues[]
end

"""
    are_linked(topology::Topology, first::Residue, second::Residue)

Check if the two residues ``first`` and ``second`` from the ``topology`` are linked together. *i.e.* if there is a bond between one atom in the first residue and one atom in the second one.
"""
function are_linked(topology::Topology, first::Residue, second::Residue)
    result = Ref{UInt8}(0)
    check(
        lib.chfl_topology_residues_linked(topology.handle, first.handle, second.handle, result)
    )
    return convert(Bool, result[])
end

"""
    resize!(topology::Topology, size::Integer)

Resize the ``topology`` to hold ``natoms`` atoms. If the new number of atoms is bigger than the current number, new atoms will be created with an empty name and type.

If it is lower than the current number of atoms, the last atoms will be removed, together with the associated bonds, angles and dihedrals.
"""
function Base.resize!(topology::Topology, size::Integer)
    check(
        lib.chfl_topology_resize(topology.handle, UInt64(size))
    )
end

"""
    deepcopy(topology::Topology)

Get a copy of an ``topology``.
"""
function Base.deepcopy(topology::Topology)
    handle = lib.chfl_topology_copy(topology.handle)
    return Topology(handle)
end
