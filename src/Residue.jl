# Chemfiles.jl, a modern library for chemistry file reading and writing
# Copyright (C) Guillaume Fraux and contributors -- BSD license

export id, residue_for_atom, atoms

if VERSION < v"1.5.0-alpha"
    export contains
end

__ptr(residue::Residue) = __ptr(residue.__handle)
__const_ptr(residue::Residue) = __const_ptr(residue.__handle)

"""
    Residue(name::String, id=nothing)

Create a new residue with the given `name` and optional residue identifier
`id`.
"""
function Residue(name::String, id=nothing)
    if id === nothing
        ptr = @__check_ptr(lib.chfl_residue(pointer(name)))
    else
        ptr = @__check_ptr(lib.chfl_residue_with_id(pointer(name), Int64(id)))
    end
    return Residue(CxxPointer(ptr, is_const=false))
end

"""
    Residue(topology::Topology, index::Integer)

Get a copy of the residue at `index` from a `topology`.

The residue index in the topology is not always the same as the residue
identifier.
"""
function Residue(topology::Topology, index::Integer)
    ptr = @__check_ptr(lib.chfl_residue_from_topology(__ptr(topology), UInt64(index)))
    residue = Residue(CxxPointer(ptr, is_const=true))
    copy = deepcopy(residue)
    finalize(residue)
    return copy
end

"""
    residue_for_atom(topology::Topology, index::Integer)

Get a copy of the residue containing the atom at `index` in the `topology`.

This function will return `nothing` if the atom is not in a residue, or if
the `index` is bigger than the number of atoms in the topology.
"""
function residue_for_atom(topology::Topology, index::Integer)
    ptr = lib.chfl_residue_for_atom(__ptr(topology), UInt64(index))
    if Int(ptr) == 0
        return nothing
    else
        residue = Residue(CxxPointer(ptr, is_const=true))
        copy = deepcopy(residue)
        finalize(residue)
        return copy
    end
end

"""
    name(residue::Residue)

Get the name of a `residue`.
"""
function name(residue::Residue)
    return __call_with_growing_buffer(
        (buffer, size) -> __check(lib.chfl_residue_name(
            __const_ptr(residue), buffer, size
        ))
    )
end

"""
    id(residue::Residue)

Get the identifier of a `residue` in the initial topology.
"""
function id(residue::Residue)
    resid = Ref{Int64}(0)
    __check(lib.chfl_residue_id(__const_ptr(residue), resid))
    return resid[]
end

"""
    size(residue::Residue)

Get the number of atoms in a `residue`.
"""
function Base.size(residue::Residue)
    count = Ref{UInt64}(0)
    __check(lib.chfl_residue_atoms_count(__const_ptr(residue), count))
    return Int(count[])
end

"""
    add_atom!(residue::Residue, index::Integer)

Add the atom at the given `index` in the `residue`.
"""
function add_atom!(residue::Residue, index::Integer)
    __check(lib.chfl_residue_add_atom(__ptr(residue), UInt64(index)))
    return nothing
end

function __contains(residue::Residue, index::Integer)
    result = Ref{UInt8}(0)
    __check(lib.chfl_residue_contains(__const_ptr(residue), UInt64(index), result))
    return convert(Bool, result[])
end

if VERSION < v"1.5.0-alpha"
    """
    contains(residue::Residue, index::Integer)

Check if the atom at the given `index` is in the `residue`.
"""
    contains(residue::Residue, index::Integer) = __contains(residue, index)
else
    """
    contains(residue::Residue, index::Integer)

Check if the atom at the given `index` is in the `residue`.
"""
    Base.contains(residue::Residue, index::Integer) = __contains(residue, index)
end

"""
    atoms(residue::Residue)

Get the atoms in a ``residue``. This function returns a list of indexes.
"""
function atoms(residue::Residue)
    count = UInt64(size(residue))
    result = Array{UInt64}(undef, count)
    __check(lib.chfl_residue_atoms(__const_ptr(residue), pointer(result), count))
    return result
end

"""
    set_property!(residue::Residue, name::String, value)

Set a named property for the given residue.
"""
function set_property!(residue::Residue, name::String, value)
    property = Property(value)
    __check(lib.chfl_residue_set_property(
        __ptr(residue), pointer(name), __const_ptr(property)
    ))
    return nothing
end

"""
    property(residue::Residue, name::String)

Get a named property for the given residue.
"""
function property(residue::Residue, name::String)
    ptr = lib.chfl_residue_get_property(__const_ptr(residue), pointer(name))
    return extract(Property(CxxPointer(ptr, is_const=false)))
end

"""
    properties_count(residue::Residue)

Get the number of properties associated with a residue.
"""
function properties_count(residue::Residue)
    count = Ref{UInt64}(0)
    __check(lib.chfl_residue_properties_count(__const_ptr(residue), count))
    return Int(count[])
end

"""
    list_properties(residue::Residue)

Get the names of all properties associated with a residue.
"""
function list_properties(residue::Residue)
    count = UInt64(properties_count(residue))
    names = Array{Ptr{UInt8}}(undef, count)
    __check(lib.chfl_residue_list_properties(__const_ptr(residue), pointer(names), count))
    return map(unsafe_string, names)
end

"""
    deepcopy(residue::Residue)

Make a deep copy of a `residue`.
"""
function Base.deepcopy(residue::Residue)
    ptr = lib.chfl_residue_copy(__const_ptr(residue))
    return Residue(CxxPointer(ptr, is_const=false))
end
