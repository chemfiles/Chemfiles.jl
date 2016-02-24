# Copyright (c) Guillaume Fraux 2015
#
# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at http://mozilla.org/MPL/2.0/.

export natoms, remove!, isbond, isangle, isdihedral, nbonds, nangles, ndihedrals,
       bonds, angles, dihedrals, add_bond!, remove_bond!

function Topology()
    return Topology(lib.chfl_topology())
end

function Topology(frame::Frame)
    return Topology(lib.chfl_topology_from_frame(frame.handle))
end

function free(topology::Topology)
    lib.chfl_topology_free(topology.handle)
end

function natoms(topology::Topology)
    n = Ref{Csize_t}(0)
    check(
        lib.chfl_topology_atoms_count(topology.handle, n)
    )
    return n[]
end

Base.size(topology::Topology) = natoms(topology)

function Base.push!(topology::Topology, atom::Atom)
    check(
        lib.chfl_topology_append(topology.handle, atom.handle)
    )
    return nothing
end

function remove!(topology::Topology, i::Integer)
    check(
        lib.chfl_topology_remove(topology.handle, Csize_t(i))
    )
    return nothing
end

function isbond(topology::Topology, i::Integer, j::Integer)
    res = Ref{UInt8}(0)
    check(
        lib.chfl_topology_isbond(topology.handle, Csize_t(i), Csize_t(j), res)
    )
    return convert(Bool, res[])
end

function isangle(topology::Topology, i::Integer, j::Integer, k::Integer)
    res = Ref{UInt8}(0)
    check(
        lib.chfl_topology_isangle(topology.handle, Csize_t(i), Csize_t(j), Csize_t(k), res)
    )
    return convert(Bool, res[])
end

function isdihedral(topology::Topology, i::Integer, j::Integer, k::Integer, m::Integer)
    res = Ref{UInt8}(0)
    check(
        lib.chfl_topology_isdihedral(topology.handle, Csize_t(i), Csize_t(j), Csize_t(k), Csize_t(m), res)
    )
    return convert(Bool, res[])
end

function nbonds(topology::Topology)
    n = Ref{Csize_t}(0)
    check(
        lib.chfl_topology_bonds_count(topology.handle, n)
    )
    return n[]
end

function nangles(topology::Topology)
    n = Ref{Csize_t}(0)
    check(
        lib.chfl_topology_angles_count(topology.handle, n)
    )
    return n[]
end

function ndihedrals(topology::Topology)
    n = Ref{Csize_t}(0)
    check(
        lib.chfl_topology_dihedrals_count(topology.handle, n)
    )
    return n[]
end

function bonds(topology::Topology)
    count = nbonds(topology)
    res = Array(Csize_t, 2, count)
    check(
        lib.chfl_topology_bonds(topology.handle, pointer(res), count)
    )
    return res
end

function angles(topology::Topology)
    count = nangles(topology)
    res = Array(Csize_t, 3, count)
    check(
        lib.chfl_topology_angles(topology.handle, pointer(res), count)
    )
    return res
end

function dihedrals(topology::Topology)
    count = ndihedrals(topology)
    res = Array(Csize_t, 4, count)
    check(
        lib.chfl_topology_dihedrals(topology.handle, pointer(res), count)
    )
    return res
end

function add_bond!(topology::Topology, i::Integer, j::Integer)
    check(
        lib.chfl_topology_add_bond(topology.handle, Csize_t(i), Csize_t(j))
    )
    return nothing
end

function remove_bond!(topology::Topology, i::Integer, j::Integer)
    check(
        lib.chfl_topology_remove_bond(topology.handle, Csize_t(i), Csize_t(j))
    )
    return nothing
end
