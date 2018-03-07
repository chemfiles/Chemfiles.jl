# Chemfiles.jl, a modern library for chemistry file reading and writing
# Copyright (C) Guillaume Fraux and contributors -- BSD license

"""
The possible types of Properties are:

- ``Chemfiles.PROPERTY_BOOL`` for storing bools
- ``Chemfiles.PROPERTY_DOUBLE`` for storing doubles
- ``Chemfiles.PROPERTY_STRING`` for storing strings
- ``Chemfiles.PROPERTY_VECTOR3D`` for storing vectors
"""
type PropertyKind
    value::lib.chfl_property_kind

    function PropertyKind(value)
        value = lib.chfl_property_kind(value)
        if value in [lib.CHFL_PROPERTY_BOOL, lib.CHFL_PROPERTY_DOUBLE, lib.CHFL_PROPERTY_STRING, lib.CHFL_PROPERTY_VECTOR3D]
            return new(value)
        else
            throw(ChemfilesError("Invalid value for conversion to PropertyType: $value"))
        end
    end
end

Base.:(==)(x::PropertyKind, y::PropertyKind) = x.value == y.value

const PROPERTY_BOOL = PropertyKind(lib.CHFL_PROPERTY_BOOL)
const PROPERTY_DOUBLE = PropertyKind(lib.CHFL_PROPERTY_DOUBLE)
const PROPERTY_STRING = PropertyKind(lib.CHFL_PROPERTY_STRING)
const PROPERTY_VECTOR3D = PropertyKind(lib.CHFL_PROPERTY_VECTOR3D)

"""
Create a ``Bool`` ``Property``.
"""
function Property(value::Bool)
    return Property(lib.chfl_property_bool(convert(UInt8,value)))
end

"""
Create a ``Float64`` ``Property``.
"""
function Property(value::Float64)
    return Property(lib.chfl_property_double(value))
end

"""
Create a ``String`` ``Property``.
"""
function Property(value::String)
    return Property(lib.chfl_property_string(pointer(value)))
end

"""
Create a ``Vector`` ``Property``.
"""
function Property(value::Vector{Float64})
    return Property(lib.chfl_property_vector3d(value))
end

"""
Obtain the kind of property.
"""
function kind(property::Property)
    result = Ref{lib.chfl_property_kind}(0)
    check(
        lib.chfl_property_get_kind(property.handle, result)
    )
    return PropertyKind(result[])
end

"""
Obtain the value stored by a property.
"""
function Base.get(property::Property)
    property_kind = kind(property)
    if property_kind == PROPERTY_BOOL
        result = Ref{UInt8}(0)
        check(
            lib.chfl_property_get_bool(property.handle, result)
        )
        return convert(Bool, result[])
    elseif property_kind == PROPERTY_DOUBLE
        result = Ref{Cdouble}(0)
        check(
            lib.chfl_property_get_double(property.handle, result)
        )
        return result[]
    elseif property_kind == PROPERTY_STRING
        return _call_with_growing_buffer(
            (buffer, size) -> check(lib.chfl_property_get_string(property.handle, buffer, size))
        )
    elseif property_kind == PROPERTY_VECTOR3D
        result = Float64[0, 0, 0]
        check(
            lib.chfl_property_get_vector3d(property.handle, result)
        )
        return result
    else
        throw( ChemfilesError("Invalid kind of property property $property_kind") )
    end

end

"""
Free a ``Property``.
"""
function free(property::Property)
    lib.chfl_property_free(property.handle)
end
