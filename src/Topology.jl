# Copyright (c) Guillaume Fraux 2015
#
# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at http://mozilla.org/MPL/2.0/.

export natoms, remove!, isbond, isangle, isdihedral, nbonds, nangles, ndihedrals,
       bonds, angles, dihedrals, add_bond!, remove_bond!

function Topology()
    return Topology(lib.chrp_topology())
end

function Topology(frame::Frame)
    return Topology(lib.chrp_topology_from_frame(frame.handle))
end

function free(topology::Topology)
    lib.chrp_topology_free(topology.handle)
end

function natoms(topology::Topology)
    n = Csize_t[0]
    check(
        lib.chrp_topology_size(topology.handle, pointer(n))
    )
    return n[1]
end

Base.size(topology::Topology) = natoms(topology)

function Base.push!(topology::Topology, atom::Atom)
    check(
        lib.chrp_topology_append(topology.handle, atom.handle)
    )
    return nothing
end

function remove!(topology::Topology, i::Integer)
    check(
        lib.chrp_topology_remove(topology.handle, Csize_t(i))
    )
    return nothing
end

function isbond(topology::Topology, i::Integer, j::Integer)
    res = Bool[false]
    check(
        lib.chrp_topology_isbond(topology.handle, Csize_t(i), Csize_t(j), pointer(res))
    )
    return res[1]
end

function isangle(topology::Topology, i::Integer, j::Integer, k::Integer)
    res = Bool[false]
    check(
        lib.chrp_topology_isangle(topology.handle, Csize_t(i), Csize_t(j), Csize_t(k), pointer(res))
    )
    return res[1]
end

function isdihedral(topology::Topology, i::Integer, j::Integer, k::Integer, m::Integer)
    res = Bool[false]
    check(
        lib.chrp_topology_isdihedral(topology.handle, Csize_t(i), Csize_t(j), Csize_t(k), Csize_t(m), pointer(res))
    )
    return res[1]
end

function nbonds(topology::Topology)
    n = Csize_t[0]
    check(
        lib.chrp_topology_bonds_count(topology.handle, pointer(n))
    )
    return n[1]
end

function nangles(topology::Topology)
    n = Csize_t[0]
    check(
        lib.chrp_topology_angles_count(topology.handle, pointer(n))
    )
    return n[1]
end

function ndihedrals(topology::Topology)
    n = Csize_t[0]
    check(
        lib.chrp_topology_dihedrals_count(topology.handle, pointer(n))
    )
    return n[1]
end

function bonds(topology::Topology)
    count = nbonds(topology)
    res = Array(Csize_t, 2, count)
    check(
        lib.chrp_topology_bonds(topology.handle, pointer(res), count)
    )
    return res
end

function angles(topology::Topology)
    count = nangles(topology)
    res = Array(Csize_t, 3, count)
    check(
        lib.chrp_topology_angles(topology.handle, pointer(res), count)
    )
    return res
end

function dihedrals(topology::Topology)
    count = ndihedrals(topology)
    res = Array(Csize_t, 4, count)
    check(
        lib.chrp_topology_dihedrals(topology.handle, pointer(res), count)
    )
    return res
end

function add_bond!(topology::Topology, i::Integer, j::Integer)
    check(
        lib.chrp_topology_add_bond(topology.handle, Csize_t(i), Csize_t(j))
    )
    return nothing
end

function remove_bond!(topology::Topology, i::Integer, j::Integer)
    check(
        lib.chrp_topology_remove_bond(topology.handle, Csize_t(i), Csize_t(j))
    )
    return nothing
end
