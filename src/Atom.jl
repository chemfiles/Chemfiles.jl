# Copyright (c) Guillaume Fraux 2015
#
# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at http://mozilla.org/MPL/2.0/.

export mass, set_mass!, charge, set_charge!, name, set_name!, fullname, vdw_radius,
covalent_radius, atomic_number, atom_type, set_atom_type!, AtomType

"""
Create an atom with the given ``name`` and set the atom ``type`` to be the same
as ``name``.
"""
function Atom(name::String)
    return Atom(lib.chfl_atom(pointer(name)))
end

"""
Get a copy of the ``atom`` at the given ``index`` from a ``frame``
"""
function Atom(frame::Frame, index::Integer)
    handle = lib.chfl_atom_from_frame(frame.handle, UInt64(index))
    return Atom(handle)
end

"""
Get a copy of the ``atom`` at a given ``index`` from a ``topology``
"""
function Atom(topology::Topology, index::Integer)
    handle = lib.chfl_atom_from_topology(topology.handle, UInt64(index))
    return Atom(handle)
end

function free(atom::Atom)
    lib.chfl_atom_free(atom.handle)
end

"""
Get the mass of an ``atom``.

The mass is given in atomic mass units.
"""
function mass(atom::Atom)
    m = Ref{Float64}(0)
    check(
        lib.chfl_atom_mass(atom.handle, m)
    )
    return m[]
end

"""
Set the mass of an ``atom`` to ``mass``.

The mass must be in atomic mass units.
"""
function set_mass!(atom::Atom, mass)
    check(
        lib.chfl_atom_set_mass(atom.handle, Float64(mass))
    )
    return nothing
end

"""
Get the charge of an ``atom``.

The charge is in number of the electron charge *e*.
"""
function charge(atom::Atom)
    c = Ref{Float64}(0)
    check(
        lib.chfl_atom_charge(atom.handle, c)
    )
    return c[]
end

"""
Set the charge of an ``atom`` to ``charge``.

The charge must be in number of the electron charge *e*.
"""
function set_charge!(atom::Atom, charge)
    check(
        lib.chfl_atom_set_charge(atom.handle, Float64(charge))
    )
    return nothing
end

"""
Get the name of an ``atom``
"""
function name(atom::Atom)
    str = " " ^ 10
    check(
        lib.chfl_atom_name(atom.handle, pointer(str), UInt64(length(str)))
    )
    return strip_null(str)
end

"""
Set the name of an ``atom`` to ``name``.
"""
function set_name!(atom::Atom, name::String)
    check(
        lib.chfl_atom_set_name(atom.handle, pointer(name))
    )
    return nothing
end

"""
Get the type of an ``atom``.
"""
function atom_type(atom::Atom)
    str = " " ^ 10
    check(
        lib.chfl_atom_type(atom.handle, pointer(str), UInt64(length(str)))
    )
    return strip_null(str)
end

"""
Set the type of an ``atom`` to ``type``.
"""
function set_atom_type!(atom::Atom, atom_type::String)
    check(
        lib.chfl_atom_set_type(atom.handle, pointer(atom_type))
    )
    return nothing
end

"""
Get the full name of an ``atom`` from the atom type.

For example, the full name of an atom with type "He" is "Helium".
"""
function Base.fullname(atom::Atom)
    str = " " ^ 96
    check(
        lib.chfl_atom_full_name(atom.handle, pointer(str), UInt64(length(str)))
    )
    return strip_null(str)
end

"""
Get the Van der Waals radius of an ``atom`` from the atom type.

If the radius can not be found, this function returns -1.
"""
function vdw_radius(atom::Atom)
    radius = Ref{Float64}(0)
    check(
        lib.chfl_atom_vdw_radius(atom.handle, radius)
    )
    return radius[]
end

"""
Get the covalent radius of an ``atom`` from the atom type.

If the radius can not be found, returns -1.
"""
function covalent_radius(atom::Atom)
    radius = Ref{Float64}(0)
    check(
        lib.chfl_atom_covalent_radius(atom.handle, radius)
    )
    return radius[]
end

"""
Get the atomic number of an ``atom`` from the atom type.

If the atomic number can not be found, returns -1.
"""
function atomic_number(atom::Atom)
    number = Ref{Int64}(0)
    check(
        lib.chfl_atom_atomic_number(atom.handle, number)
    )
    return number[]
end

"""
Make a deep copy of an ``atom``.
"""
function Base.deepcopy(atom::Atom)
    handle = lib.chfl_atom_copy(atom.handle)
    return Atom(handle)
end
