# Copyright (c) Guillaume Fraux 2015
#
# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at http://mozilla.org/MPL/2.0/.

export mass, set_mass!, charge, set_charge!, name, set_name!, fullname, vdw_radius,
covalent_radius, atomic_number, atom_type, set_atom_type!, AtomType

function Atom(name::String)
    return Atom(lib.chfl_atom(pointer(name)))
end

function Atom(frame::Frame, index::Integer)
    handle = lib.chfl_atom_from_frame(frame.handle, UInt64(index))
    return Atom(handle)
end

function Atom(topology::Topology, index::Integer)
    handle = lib.chfl_atom_from_topology(topology.handle, UInt64(index))
    return Atom(handle)
end

function free(atom::Atom)
    lib.chfl_atom_free(atom.handle)
end

function mass(atom::Atom)
    m = Ref{Float64}(0)
    check(
        lib.chfl_atom_mass(atom.handle, m)
    )
    return m[]
end

function set_mass!(atom::Atom, m)
    check(
        lib.chfl_atom_set_mass(atom.handle, Float64(m))
    )
    return nothing
end

function charge(atom::Atom)
    c = Ref{Float64}(0)
    check(
        lib.chfl_atom_charge(atom.handle, c)
    )
    return c[]
end

function set_charge!(atom::Atom, c)
    check(
        lib.chfl_atom_set_charge(atom.handle, Float64(c))
    )
    return nothing
end

function name(atom::Atom)
    str = " " ^ 10
    check(
        lib.chfl_atom_name(atom.handle, pointer(str), UInt64(length(str)))
    )
    return strip_null(str)
end

function set_name!(atom::Atom, name::String)
    check(
        lib.chfl_atom_set_name(atom.handle, pointer(name))
    )
    return nothing
end

function atom_type(atom::Atom)
    str = " " ^ 10
    check(
        lib.chfl_atom_type(atom.handle, pointer(str), UInt64(length(str)))
    )
    return strip_null(str)
end

function set_atom_type!(atom::Atom, atom_type::String)
    check(
        lib.chfl_atom_set_type(atom.handle, pointer(atom_type))
    )
    return nothing
end

function Base.fullname(atom::Atom)
    str = " " ^ 96
    check(
        lib.chfl_atom_full_name(atom.handle, pointer(str), UInt64(length(str)))
    )
    return strip_null(str)
end

function vdw_radius(atom::Atom)
    radius = Ref{Float64}(0)
    check(
        lib.chfl_atom_vdw_radius(atom.handle, radius)
    )
    return radius[]
end

function covalent_radius(atom::Atom)
    radius = Ref{Float64}(0)
    check(
        lib.chfl_atom_covalent_radius(atom.handle, radius)
    )
    return radius[]
end

function atomic_number(atom::Atom)
    number = Ref{Int64}(0)
    check(
        lib.chfl_atom_atomic_number(atom.handle, number)
    )
    return number[]
end

function Base.deepcopy(atom::Atom)
    handle = lib.chfl_atom_copy(atom.handle)
    return Atom(handle)
end
