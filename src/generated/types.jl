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
typealias CBool Cuchar

immutable CHFL_TRAJECTORY end

immutable CHFL_CELL end

immutable CHFL_ATOM end

immutable CHFL_FRAME end

immutable CHFL_TOPOLOGY end

# enum CHFL_LOG_LEVEL
typealias CHFL_LOG_LEVEL UInt32
const CHFL_LOG_ERROR = CHFL_LOG_LEVEL(0)
const CHFL_LOG_WARNING = CHFL_LOG_LEVEL(1)
const CHFL_LOG_INFO = CHFL_LOG_LEVEL(2)
const CHFL_LOG_DEBUG = CHFL_LOG_LEVEL(3)

# enum CHFL_CELL_TYPES
typealias CHFL_CELL_TYPES UInt32
const CHFL_CELL_ORTHOROMBIC = CHFL_CELL_TYPES(0)
const CHFL_CELL_TRICLINIC = CHFL_CELL_TYPES(1)
const CHFL_CELL_INFINITE = CHFL_CELL_TYPES(2)

# enum CHFL_ATOM_TYPES
typealias CHFL_ATOM_TYPES UInt32
const CHFL_ATOM_ELEMENT = CHFL_ATOM_TYPES(0)
const CHFL_ATOM_COARSE_GRAINED = CHFL_ATOM_TYPES(1)
const CHFL_ATOM_DUMMY = CHFL_ATOM_TYPES(2)
const CHFL_ATOM_UNDEFINED = CHFL_ATOM_TYPES(3)
