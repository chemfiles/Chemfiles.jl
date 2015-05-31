# Copyright (c) Guillaume Fraux 2015
#
# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at http://mozilla.org/MPL/2.0/.

export mass, setmass!, charge, setcharge!, name, setname!,
       fullname, vdw_radius, covalent_radius, atomic_number

function Atom(name::ASCIIString)
    handle = lib.chrp_atom(pointer(name))
    if Int(handle) == 0
        throw(ChemharpError("Error while creating Atom"))
    end
    return Atom(handle)
end

function Atom(frame::Frame, index::Integer)
    handle = lib.chrp_atom_from_frame(frame.handle, Csize_t(index))
    if Int(handle) == 0
        throw(ChemharpError("Error while creating Atom from Frame"))
    end
    return Atom(handle)
end

function Atom(topology::Topology, index::Integer)
    handle = lib.chrp_atom_from_topology(topology.handle, Csize_t(index))
    if Int(handle) == 0
        throw(ChemharpError("Error while creating Atom from Topology"))
    end
    return Atom(handle)
end

function free(atom::Atom)
    lib.chrp_atom_free(atom.handle)
end

function mass(atom::Atom)
    m = Cfloat[0]
    check(
        lib.chrp_atom_mass(atom.handle, pointer(m))
    )
    return m[1]
end

function setmass!(atom::Atom, m)
    check(
        lib.chrp_atom_mass_set(atom.handle, Cfloat(m))
    )
    return nothing
end

function charge(atom::Atom)
    c = Cfloat[0]
    check(
        lib.chrp_atom_charge(atom.handle, pointer(c))
    )
    return c[1]
end

function setcharge!(atom::Atom, c)
    check(
        lib.chrp_atom_charge_set(atom.handle, Cfloat(c))
    )
    return nothing
end

function name(atom::Atom)
    str = " " ^ 10
    check(
        lib.chrp_atom_name(atom.handle, pointer(str), UInt(length(str)))
    )
    # Remove spaces and null char
    return strip(str)[1:end-1]
end

function setname!(atom::Atom, name::ASCIIString)
    check(
        lib.chrp_atom_name_set(atom.handle, pointer(name))
    )
    # Remove spaces and null char
    return nothing
end

function Base.fullname(atom::Atom)
    str = " " ^ 96
    check(
        lib.chrp_atom_full_name(atom.handle, pointer(str), UInt(length(str)))
    )
    # Remove spaces and null char
    return strip(str)[1:end-1]
end

function vdw_radius(atom::Atom)
    radius = Cdouble[0]
    check(
        lib.chrp_atom_vdw_radius(atom.handle, pointer(radius))
    )
    return radius[1]
end

function covalent_radius(atom::Atom)
    radius = Cdouble[0]
    check(
        lib.chrp_atom_covalent_radius(atom.handle, pointer(radius))
    )
    return radius[1]
end

function atomic_number(atom::Atom)
    number = Cint[0]
    check(
        lib.chrp_atom_atomic_number(atom.handle, pointer(number))
    )
    return number[1]
end
