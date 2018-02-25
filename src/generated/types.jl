# Chemfiles, an efficient IO library for chemistry file formats
# Copyright (C) 2015 Guillaume Fraux
#
# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at http://mozilla.org/MPL/2.0/
#
# =========================================================================== #
# !!!! AUTO-GENERATED FILE !!!! Do not edit. See the bindgen repository for
# the generation code (https://github.com/chemfiles/bindgen).
# This file contains Julia interface to the C API
# =========================================================================== #

# === Manually translated from the header
struct chfl_match
    size    ::UInt64
    atoms_1 ::UInt64
    atoms_2 ::UInt64
    atoms_3 ::UInt64
    atoms_4 ::UInt64
end

const Cbool = Cuchar
const chfl_vector3d = Array{Cdouble, 1}
# === End of manual translation

struct CHFL_TRAJECTORY end

struct CHFL_CELL end

struct CHFL_ATOM end

struct CHFL_FRAME end

struct CHFL_TOPOLOGY end

struct CHFL_SELECTION end

struct CHFL_RESIDUE end

struct CHFL_PROPERTY end

# enum chfl_status
const chfl_status = UInt32
const CHFL_SUCCESS = chfl_status(0)
const CHFL_MEMORY_ERROR = chfl_status(1)
const CHFL_FILE_ERROR = chfl_status(2)
const CHFL_FORMAT_ERROR = chfl_status(3)
const CHFL_SELECTION_ERROR = chfl_status(4)
const CHFL_CONFIGURATION_ERROR = chfl_status(5)
const CHFL_OUT_OF_BOUNDS = chfl_status(6)
const CHFL_PROPERTY_ERROR = chfl_status(7)
const CHFL_GENERIC_ERROR = chfl_status(254)
const CHFL_CXX_ERROR = chfl_status(255)

# enum chfl_property_kind
const chfl_property_kind = UInt32
const CHFL_PROPERTY_BOOL = chfl_property_kind(0)
const CHFL_PROPERTY_DOUBLE = chfl_property_kind(1)
const CHFL_PROPERTY_STRING = chfl_property_kind(2)
const CHFL_PROPERTY_VECTOR3D = chfl_property_kind(3)

# enum chfl_cellshape
const chfl_cellshape = UInt32
const CHFL_CELL_ORTHORHOMBIC = chfl_cellshape(0)
const CHFL_CELL_TRICLINIC = chfl_cellshape(1)
const CHFL_CELL_INFINITE = chfl_cellshape(2)
