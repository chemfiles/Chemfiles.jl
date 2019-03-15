# Chemfiles.jl, a modern library for chemistry file reading and writing
# Copyright (C) Guillaume Fraux and contributors -- BSD license

__ptr(property::Property) = __ptr(property.__handle)
__const_ptr(property::Property) = __const_ptr(property.__handle)

"""
The possible types of Properties are:

- ``Chemfiles.PropertyBool`` for storing bools
- ``Chemfiles.PropertyDouble`` for storing doubles
- ``Chemfiles.PropertyString`` for storing strings
- ``Chemfiles.PropertyVector3d`` for storing vectors
"""
@enum PropertyKind begin
    PropertyBool = lib.CHFL_PROPERTY_BOOL
    PropertyDouble = lib.CHFL_PROPERTY_DOUBLE
    PropertyString = lib.CHFL_PROPERTY_STRING
    PropertyVector3d = lib.CHFL_PROPERTY_VECTOR3D
end

"""
Create a ``Bool`` ``Property``.
"""
function Property(value::Bool)
    ptr = @__check_ptr(lib.chfl_property_bool(convert(UInt8, value)))
    return Property(CxxPointer(ptr, is_const=false))
end

"""
Create a ``Float64`` ``Property``.
"""
function Property(value::Float64)
    ptr = @__check_ptr(lib.chfl_property_double(value))
    return Property(CxxPointer(ptr, is_const=false))
end

"""
Create a ``String`` ``Property``.
"""
function Property(value::String)
    ptr = @__check_ptr(lib.chfl_property_string(pointer(value)))
    return Property(CxxPointer(ptr, is_const=false))
end

"""
Create a ``Vector`` ``Property``.
"""
function Property(value::Vector{Float64})
    ptr = @__check_ptr(lib.chfl_property_vector3d(value))
    return Property(CxxPointer(ptr, is_const=false))
end

"""
Obtain the kind of property.
"""
function kind(property::Property)
    result = Ref{lib.chfl_property_kind}(0)
    __check(lib.chfl_property_get_kind(__const_ptr(property), result))
    return PropertyKind(result[])
end

function __extract_double(property::Property)
    result = Ref{Cdouble}(0)
    __check(lib.chfl_property_get_double(__const_ptr(property), result))
    return result[]
end

function __extract_bool(property::Property)
    result = Ref{UInt8}(0)
    __check(lib.chfl_property_get_bool(__const_ptr(property), result))
    return convert(Bool, result[])
end

function __extract_string(property::Property)
    return __call_with_growing_buffer(
        (buffer, size) -> __check(lib.chfl_property_get_string(__const_ptr(property), buffer, size))
    )
end

function __extract_vector3d(property::Property)
    result = Float64[0, 0, 0]
    __check(lib.chfl_property_get_vector3d(__const_ptr(property), result))
    return result
end

"""
Obtain the value stored by a property.
"""
function extract(property::Property)
    property_kind = kind(property)
    if property_kind == PropertyBool
        return __extract_bool(property)
    elseif property_kind == PropertyDouble
        return __extract_double(property)
    elseif property_kind == PropertyString
        return __extract_string(property)
    elseif property_kind == PropertyVector3d
        return __extract_vector3d(property)
    else
        throw(ChemfilesError(
            "Invalid property kind '$property_kind'. This is a bug"
        ))
    end
end
