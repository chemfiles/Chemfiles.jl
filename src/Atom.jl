# Chemfiles.jl, a modern library for chemistry file reading and writing
# Copyright (C) Guillaume Fraux and contributors -- BSD license

export mass, set_mass!, charge, set_charge!, name, set_name!, type, set_type!
export vdw_radius, covalent_radius, atomic_number
export set_property!, property, properties_count, list_properties

__ptr(atom::Atom) = __ptr(atom.__handle)
__const_ptr(atom::Atom) = __const_ptr(atom.__handle)

"""
Create an atom with the given `name` and set the atom `type` to be the same
as `name`.
"""
function Atom(name::String)
    ptr = @__check_ptr(lib.chfl_atom(pointer(name)))
    return Atom(CxxPointer(ptr, is_const=false))
end

"""
Get a copy of the `atom` at the given `index` from a `frame`.
"""
function Atom(frame::Frame, index::Integer)
    ptr = @__check_ptr(lib.chfl_atom_from_frame(__ptr(frame), UInt64(index)))
    atom = Atom(CxxPointer(ptr, is_const=false))
    copy = deepcopy(atom)
    finalize(atom)
    return copy
end

"""
Get a copy of the `atom` at the given `index` from a `topology`.
"""
function Atom(topology::Topology, index::Integer)
    ptr = @__check_ptr(lib.chfl_atom_from_topology(__ptr(topology), UInt64(index)))
    atom = Atom(CxxPointer(ptr, is_const=false))
    copy = deepcopy(atom)
    finalize(atom)
    return copy
end

"""
Get the mass of an `atom` in atomic mass units.
"""
function mass(atom::Atom)
    result = Ref{Float64}(0)
    __check(lib.chfl_atom_mass(__const_ptr(atom), result))
    return result[]
end

"""
Set the mass of an `atom` to `mass`.

The mass must be in atomic mass units.
"""
function set_mass!(atom::Atom, mass)
    __check(lib.chfl_atom_set_mass(__ptr(atom), Float64(mass)))
    return nothing
end

"""
Get the charge of an `atom` in number of the electron charge *e*.
"""
function charge(atom::Atom)
    result = Ref{Float64}(0)
    __check(lib.chfl_atom_charge(__const_ptr(atom), result))
    return result[]
end

"""
Set the charge of an `atom` to `charge`.

The charge must be in number of the electron charge *e*.
"""
function set_charge!(atom::Atom, charge)
    __check(lib.chfl_atom_set_charge(__ptr(atom), Float64(charge)))
    return nothing
end

"""
Get the name of an `atom`.
"""
function name(atom::Atom)
    return __call_with_growing_buffer(
        (buffer, size) -> __check(lib.chfl_atom_name(__const_ptr(atom), buffer, size))
    )
end

"""
Set the name of an `atom` to `name`.
"""
function set_name!(atom::Atom, name::String)
    __check(lib.chfl_atom_set_name(__ptr(atom), pointer(name)))
    return nothing
end

"""
Get the type of an `atom`.
"""
function type(atom::Atom)
    return __call_with_growing_buffer(
        (buffer, size) -> __check(lib.chfl_atom_type(__const_ptr(atom), buffer, size))
    )
end

"""
Set the type of an `atom` to `type`.
"""
function set_type!(atom::Atom, type::String)
    __check(lib.chfl_atom_set_type(__ptr(atom), pointer(type)))
    return nothing
end

"""
Get the full name of an `atom` from the atom type.

For example, the full name of an atom with type "He" is "Helium".
"""
function Base.fullname(atom::Atom)
    return __call_with_growing_buffer(
        (buffer, size) -> __check(lib.chfl_atom_full_name(
            __const_ptr(atom), buffer, size)
        )
    )
end

"""
Get the van der Waals radius of an `atom` from the atom type.

If the radius can not be found, this function returns 0.
"""
function vdw_radius(atom::Atom)
    radius = Ref{Float64}(0)
    __check(lib.chfl_atom_vdw_radius(__const_ptr(atom), radius))
    return radius[]
end

"""
Get the covalent radius of an `atom` from the atom type.

If the radius can not be found, returns 0.
"""
function covalent_radius(atom::Atom)
    radius = Ref{Float64}(0)
    __check(lib.chfl_atom_covalent_radius(__const_ptr(atom), radius))
    return radius[]
end

"""
Get the atomic number of an `atom` from the atom type.

If the atomic number can not be found, returns 0.
"""
function atomic_number(atom::Atom)
    number = Ref{UInt64}(0)
    __check(lib.chfl_atom_atomic_number(__const_ptr(atom), number))
    return number[]
end

"""
Set a named property for the given atom.
"""
function set_property!(atom::Atom, name::String, value)
    property = Property(value)
    __check(lib.chfl_atom_set_property(
        __ptr(atom), pointer(name), __const_ptr(property)
    ))
    return nothing
end

"""
Get a named property for the given atom.
"""
function property(atom::Atom, name::String)
    ptr = lib.chfl_atom_get_property(__const_ptr(atom), pointer(name))
    return extract(Property(CxxPointer(ptr, is_const=false)))
end

"""
Get the number of properties associated with an atom.
"""
function properties_count(atom::Atom)
    count = Ref{UInt64}(0)
    __check(lib.chfl_atom_properties_count(__const_ptr(atom), count))
    return count[]
end

"""
Get the names of all properties associated with an atom.
"""
function list_properties(atom::Atom)
    count = properties_count(atom)
    names = Array{Ptr{UInt8}}(undef, count)
    __check(lib.chfl_atom_list_properties(__const_ptr(atom), pointer(names), count))
    return map(unsafe_string, names)
end

"""
Make a deep copy of an `atom`.
"""
function Base.deepcopy(atom::Atom)
    ptr = lib.chfl_atom_copy(__const_ptr(atom))
    return Atom(CxxPointer(ptr, is_const=false))
end
