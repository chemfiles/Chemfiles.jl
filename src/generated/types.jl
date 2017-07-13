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
immutable chfl_match_t
    size    ::UInt64
    atoms_1 ::UInt64
    atoms_2 ::UInt64
    atoms_3 ::UInt64
    atoms_4 ::UInt64
end

const Cbool = Cuchar
const chfl_vector_t = Array{Cdouble, 1}
# === End of manual translation

immutable CHFL_TRAJECTORY end

immutable CHFL_CELL end

immutable CHFL_ATOM end

immutable CHFL_FRAME end

immutable CHFL_TOPOLOGY end

immutable CHFL_SELECTION end

immutable CHFL_RESIDUE end

# enum chfl_status
const chfl_status = UInt32
const CHFL_SUCCESS = chfl_status(0)
const CHFL_MEMORY_ERROR = chfl_status(1)
const CHFL_FILE_ERROR = chfl_status(2)
const CHFL_FORMAT_ERROR = chfl_status(3)
const CHFL_SELECTION_ERROR = chfl_status(4)
const CHFL_GENERIC_ERROR = chfl_status(5)
const CHFL_CXX_ERROR = chfl_status(6)

# enum chfl_cell_shape_t
const chfl_cell_shape_t = UInt32
const CHFL_CELL_ORTHORHOMBIC = chfl_cell_shape_t(0)
const CHFL_CELL_TRICLINIC = chfl_cell_shape_t(1)
const CHFL_CELL_INFINITE = chfl_cell_shape_t(2)
