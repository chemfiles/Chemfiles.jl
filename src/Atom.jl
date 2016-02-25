# Copyright (c) Guillaume Fraux 2015
#
# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at http://mozilla.org/MPL/2.0/.

export mass, setmass!, charge, setcharge!, name, setname!, fullname, vdw_radius,
covalent_radius, atomic_number, atom_type, set_atom_type!


immutable AtomType
    value::lib.CHFL_ATOM_TYPES

    function AtomType(value)
        value = lib.CHFL_ATOM_TYPES(value)
        if value in [lib.CHFL_ATOM_ELEMENT, lib.CHFL_ATOM_COARSE_GRAINED, lib.CHFL_ATOM_DUMMY, lib.CHFL_ATOM_UNDEFINED]
            return new(value)
        else
            throw(ChemfilesError("Invalid value for conversion to AtomType: $value"))
        end
    end
end

const ELEMENT = AtomType(lib.CHFL_ATOM_ELEMENT)
const COARSE_GRAINED = AtomType(lib.CHFL_ATOM_COARSE_GRAINED)
const DUMMY_ATOM = AtomType(lib.CHFL_ATOM_DUMMY)
const UNDEFINED_ATOM = AtomType(lib.CHFL_ATOM_UNDEFINED)

function Atom(name::ASCIIString)
    return Atom(lib.chfl_atom(pointer(name)))
end

function Atom(frame::Frame, index::Integer)
    handle = lib.chfl_atom_from_frame(frame.handle, Csize_t(index))
    return Atom(handle)
end

function Atom(topology::Topology, index::Integer)
    handle = lib.chfl_atom_from_topology(topology.handle, Csize_t(index))
    return Atom(handle)
end

function free(atom::Atom)
    lib.chfl_atom_free(atom.handle)
end

function mass(atom::Atom)
    m = Ref{Cfloat}(0)
    check(
        lib.chfl_atom_mass(atom.handle, m)
    )
    return m[]
end

function setmass!(atom::Atom, m)
    check(
        lib.chfl_atom_set_mass(atom.handle, Cfloat(m))
    )
    return nothing
end

function charge(atom::Atom)
    c = Ref{Cfloat}(0)
    check(
        lib.chfl_atom_charge(atom.handle, c)
    )
    return c[]
end

function setcharge!(atom::Atom, c)
    check(
        lib.chfl_atom_set_charge(atom.handle, Cfloat(c))
    )
    return nothing
end

function name(atom::Atom)
    str = " " ^ 10
    check(
        lib.chfl_atom_name(atom.handle, pointer(str), Csize_t(length(str)))
    )
    # Remove spaces and null char
    return strip(str)[1:end-1]
end

function setname!(atom::Atom, name::ASCIIString)
    check(
        lib.chfl_atom_set_name(atom.handle, pointer(name))
    )
    # Remove spaces and null char
    return nothing
end

function Base.fullname(atom::Atom)
    str = " " ^ 96
    check(
        lib.chfl_atom_full_name(atom.handle, pointer(str), Csize_t(length(str)))
    )
    # Remove spaces and null char
    return strip(str)[1:end-1]
end

function vdw_radius(atom::Atom)
    radius = Ref{Cdouble}(0)
    check(
        lib.chfl_atom_vdw_radius(atom.handle, radius)
    )
    return radius[]
end

function covalent_radius(atom::Atom)
    radius = Ref{Cdouble}(0)
    check(
        lib.chfl_atom_covalent_radius(atom.handle, radius)
    )
    return radius[]
end

function atomic_number(atom::Atom)
    number = Ref{Cint}(0)
    check(
        lib.chfl_atom_atomic_number(atom.handle, number)
    )
    return number[]
end

function atom_type(atom::Atom)
    res = Ref{lib.CHFL_ATOM_TYPES}(0)
    check(
        lib.chfl_atom_type(atom.handle, res)
    )
    return AtomType(res[])
end

function set_atom_type!(atom::Atom, atom_type::AtomType)
    check(
        lib.chfl_atom_set_type(atom.handle, atom_type.value)
    )
    return nothing
end
