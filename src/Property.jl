# Copyright (c) Guillaume Fraux 2015
#
# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at http://mozilla.org/MPL/2.0/.

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
function Base.get(property::Property; buffersize::Integer = 100 )

    type_of_property = kind(property)

    if type_of_property == PROPERTY_BOOL

        result = Ref{UInt8}(0)
        check(
            lib.chfl_property_get_bool(property.handle, result)
        )
        return convert(Bool, result[])

    elseif type_of_property == PROPERTY_DOUBLE

        result = Ref{Cdouble}(0)
        check(
            lib.chfl_property_get_double(property.handle, result)
        )
        return result[]

    elseif type_of_property == PROPERTY_STRING

        buffersize = UInt64(buffersize)
        str = " " ^ buffersize
        check(
            lib.chfl_property_get_string(property.handle, pointer(str), buffersize)
        )
        return strip_null(str)

    elseif type_of_property == PROPERTY_VECTOR3D

        result = Float64[0, 0, 0]
        check(
            lib.chfl_property_get_vector3d(property.handle, result)
        )
        return result

    else
        throw( ChemfilesError("Invalid kind of property property $type_of_property") )
    end

end

"""
Free a ``Property``.
"""
function free(property::Property)
    lib.chfl_property_free(property.handle)
end
