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

# Function 'chfl_version' at types.h:135
function chfl_version()
    ccall((:chfl_version, libchemfiles), Ptr{UInt8}, (), )
end

# Function 'chfl_last_error' at errors.h:20
function chfl_last_error()
    ccall((:chfl_last_error, libchemfiles), Ptr{UInt8}, (), )
end

# Function 'chfl_clear_errors' at errors.h:27
function chfl_clear_errors()
    ccall((:chfl_clear_errors, libchemfiles), chfl_status, (), )
end

# Function 'chfl_set_warning_callback' at errors.h:36
function chfl_set_warning_callback(callback::Ptr{Void})
    ccall((:chfl_set_warning_callback, libchemfiles), chfl_status, (Ptr{Void},), callback)
end

# Function 'chfl_atom' at atom.h:24
function chfl_atom(name::Ptr{UInt8})
    ccall((:chfl_atom, libchemfiles), Ptr{CHFL_ATOM}, (Ptr{UInt8},), name)
end

# Function 'chfl_atom_copy' at atom.h:34
function chfl_atom_copy(atom::Ptr{CHFL_ATOM})
    ccall((:chfl_atom_copy, libchemfiles), Ptr{CHFL_ATOM}, (Ptr{CHFL_ATOM},), atom)
end

# Function 'chfl_atom_from_frame' at atom.h:44
function chfl_atom_from_frame(frame::Ptr{CHFL_FRAME}, i::UInt64)
    ccall((:chfl_atom_from_frame, libchemfiles), Ptr{CHFL_ATOM}, (Ptr{CHFL_FRAME}, UInt64), frame, i)
end

# Function 'chfl_atom_from_topology' at atom.h:56
function chfl_atom_from_topology(topology::Ptr{CHFL_TOPOLOGY}, i::UInt64)
    ccall((:chfl_atom_from_topology, libchemfiles), Ptr{CHFL_ATOM}, (Ptr{CHFL_TOPOLOGY}, UInt64), topology, i)
end

# Function 'chfl_atom_mass' at atom.h:67
function chfl_atom_mass(atom::Ptr{CHFL_ATOM}, mass::Ref{Cdouble})
    ccall((:chfl_atom_mass, libchemfiles), chfl_status, (Ptr{CHFL_ATOM}, Ref{Cdouble}), atom, mass)
end

# Function 'chfl_atom_set_mass' at atom.h:78
function chfl_atom_set_mass(atom::Ptr{CHFL_ATOM}, mass::Cdouble)
    ccall((:chfl_atom_set_mass, libchemfiles), chfl_status, (Ptr{CHFL_ATOM}, Cdouble), atom, mass)
end

# Function 'chfl_atom_charge' at atom.h:89
function chfl_atom_charge(atom::Ptr{CHFL_ATOM}, charge::Ref{Cdouble})
    ccall((:chfl_atom_charge, libchemfiles), chfl_status, (Ptr{CHFL_ATOM}, Ref{Cdouble}), atom, charge)
end

# Function 'chfl_atom_set_charge' at atom.h:100
function chfl_atom_set_charge(atom::Ptr{CHFL_ATOM}, charge::Cdouble)
    ccall((:chfl_atom_set_charge, libchemfiles), chfl_status, (Ptr{CHFL_ATOM}, Cdouble), atom, charge)
end

# Function 'chfl_atom_type' at atom.h:110
function chfl_atom_type(atom::Ptr{CHFL_ATOM}, typ::Ptr{UInt8}, buffsize::UInt64)
    ccall((:chfl_atom_type, libchemfiles), chfl_status, (Ptr{CHFL_ATOM}, Ptr{UInt8}, UInt64), atom, typ, buffsize)
end

# Function 'chfl_atom_set_type' at atom.h:121
function chfl_atom_set_type(atom::Ptr{CHFL_ATOM}, typ::Ptr{UInt8})
    ccall((:chfl_atom_set_type, libchemfiles), chfl_status, (Ptr{CHFL_ATOM}, Ptr{UInt8}), atom, typ)
end

# Function 'chfl_atom_name' at atom.h:133
function chfl_atom_name(atom::Ptr{CHFL_ATOM}, name::Ptr{UInt8}, buffsize::UInt64)
    ccall((:chfl_atom_name, libchemfiles), chfl_status, (Ptr{CHFL_ATOM}, Ptr{UInt8}, UInt64), atom, name, buffsize)
end

# Function 'chfl_atom_set_name' at atom.h:144
function chfl_atom_set_name(atom::Ptr{CHFL_ATOM}, name::Ptr{UInt8})
    ccall((:chfl_atom_set_name, libchemfiles), chfl_status, (Ptr{CHFL_ATOM}, Ptr{UInt8}), atom, name)
end

# Function 'chfl_atom_full_name' at atom.h:156
function chfl_atom_full_name(atom::Ptr{CHFL_ATOM}, name::Ptr{UInt8}, buffsize::UInt64)
    ccall((:chfl_atom_full_name, libchemfiles), chfl_status, (Ptr{CHFL_ATOM}, Ptr{UInt8}, UInt64), atom, name, buffsize)
end

# Function 'chfl_atom_vdw_radius' at atom.h:168
function chfl_atom_vdw_radius(atom::Ptr{CHFL_ATOM}, radius::Ref{Cdouble})
    ccall((:chfl_atom_vdw_radius, libchemfiles), chfl_status, (Ptr{CHFL_ATOM}, Ref{Cdouble}), atom, radius)
end

# Function 'chfl_atom_covalent_radius' at atom.h:180
function chfl_atom_covalent_radius(atom::Ptr{CHFL_ATOM}, radius::Ref{Cdouble})
    ccall((:chfl_atom_covalent_radius, libchemfiles), chfl_status, (Ptr{CHFL_ATOM}, Ref{Cdouble}), atom, radius)
end

# Function 'chfl_atom_atomic_number' at atom.h:192
function chfl_atom_atomic_number(atom::Ptr{CHFL_ATOM}, number::Ref{Int64})
    ccall((:chfl_atom_atomic_number, libchemfiles), chfl_status, (Ptr{CHFL_ATOM}, Ref{Int64}), atom, number)
end

# Function 'chfl_atom_free' at atom.h:200
function chfl_atom_free(atom::Ptr{CHFL_ATOM})
    ccall((:chfl_atom_free, libchemfiles), chfl_status, (Ptr{CHFL_ATOM},), atom)
end

# Function 'chfl_residue' at residue.h:26
function chfl_residue(name::Ptr{UInt8}, resid::UInt64)
    ccall((:chfl_residue, libchemfiles), Ptr{CHFL_RESIDUE}, (Ptr{UInt8}, UInt64), name, resid)
end

# Function 'chfl_residue_from_topology' at residue.h:42
function chfl_residue_from_topology(topology::Ptr{CHFL_TOPOLOGY}, i::UInt64)
    ccall((:chfl_residue_from_topology, libchemfiles), Ptr{CHFL_RESIDUE}, (Ptr{CHFL_TOPOLOGY}, UInt64), topology, i)
end

# Function 'chfl_residue_for_atom' at residue.h:58
function chfl_residue_for_atom(topology::Ptr{CHFL_TOPOLOGY}, i::UInt64)
    ccall((:chfl_residue_for_atom, libchemfiles), Ptr{CHFL_RESIDUE}, (Ptr{CHFL_TOPOLOGY}, UInt64), topology, i)
end

# Function 'chfl_residue_copy' at residue.h:70
function chfl_residue_copy(residue::Ptr{CHFL_RESIDUE})
    ccall((:chfl_residue_copy, libchemfiles), Ptr{CHFL_RESIDUE}, (Ptr{CHFL_RESIDUE},), residue)
end

# Function 'chfl_residue_atoms_count' at residue.h:77
function chfl_residue_atoms_count(residue::Ptr{CHFL_RESIDUE}, size::Ref{UInt64})
    ccall((:chfl_residue_atoms_count, libchemfiles), chfl_status, (Ptr{CHFL_RESIDUE}, Ref{UInt64}), residue, size)
end

# Function 'chfl_residue_id' at residue.h:87
function chfl_residue_id(residue::Ptr{CHFL_RESIDUE}, id::Ref{UInt64})
    ccall((:chfl_residue_id, libchemfiles), chfl_status, (Ptr{CHFL_RESIDUE}, Ref{UInt64}), residue, id)
end

# Function 'chfl_residue_name' at residue.h:99
function chfl_residue_name(residue::Ptr{CHFL_RESIDUE}, name::Ptr{UInt8}, buffsize::UInt64)
    ccall((:chfl_residue_name, libchemfiles), chfl_status, (Ptr{CHFL_RESIDUE}, Ptr{UInt8}, UInt64), residue, name, buffsize)
end

# Function 'chfl_residue_add_atom' at residue.h:108
function chfl_residue_add_atom(residue::Ptr{CHFL_RESIDUE}, i::UInt64)
    ccall((:chfl_residue_add_atom, libchemfiles), chfl_status, (Ptr{CHFL_RESIDUE}, UInt64), residue, i)
end

# Function 'chfl_residue_contains' at residue.h:118
function chfl_residue_contains(residue::Ptr{CHFL_RESIDUE}, i::UInt64, result::Ref{Cbool})
    ccall((:chfl_residue_contains, libchemfiles), chfl_status, (Ptr{CHFL_RESIDUE}, UInt64, Ref{Cbool}), residue, i, result)
end

# Function 'chfl_residue_free' at residue.h:126
function chfl_residue_free(residue::Ptr{CHFL_RESIDUE})
    ccall((:chfl_residue_free, libchemfiles), chfl_status, (Ptr{CHFL_RESIDUE},), residue)
end

# Function 'chfl_topology' at topology.h:24
function chfl_topology()
    ccall((:chfl_topology, libchemfiles), Ptr{CHFL_TOPOLOGY}, (), )
end

# Function 'chfl_topology_from_frame' at topology.h:34
function chfl_topology_from_frame(frame::Ptr{CHFL_FRAME})
    ccall((:chfl_topology_from_frame, libchemfiles), Ptr{CHFL_TOPOLOGY}, (Ptr{CHFL_FRAME},), frame)
end

# Function 'chfl_topology_copy' at topology.h:46
function chfl_topology_copy(topology::Ptr{CHFL_TOPOLOGY})
    ccall((:chfl_topology_copy, libchemfiles), Ptr{CHFL_TOPOLOGY}, (Ptr{CHFL_TOPOLOGY},), topology)
end

# Function 'chfl_topology_atoms_count' at topology.h:54
function chfl_topology_atoms_count(topology::Ptr{CHFL_TOPOLOGY}, natoms::Ref{UInt64})
    ccall((:chfl_topology_atoms_count, libchemfiles), chfl_status, (Ptr{CHFL_TOPOLOGY}, Ref{UInt64}), topology, natoms)
end

# Function 'chfl_topology_resize' at topology.h:66
function chfl_topology_resize(topology::Ptr{CHFL_TOPOLOGY}, natoms::UInt64)
    ccall((:chfl_topology_resize, libchemfiles), chfl_status, (Ptr{CHFL_TOPOLOGY}, UInt64), topology, natoms)
end

# Function 'chfl_topology_add_atom' at topology.h:75
function chfl_topology_add_atom(topology::Ptr{CHFL_TOPOLOGY}, atom::Ptr{CHFL_ATOM})
    ccall((:chfl_topology_add_atom, libchemfiles), chfl_status, (Ptr{CHFL_TOPOLOGY}, Ptr{CHFL_ATOM}), topology, atom)
end

# Function 'chfl_topology_remove' at topology.h:86
function chfl_topology_remove(topology::Ptr{CHFL_TOPOLOGY}, i::UInt64)
    ccall((:chfl_topology_remove, libchemfiles), chfl_status, (Ptr{CHFL_TOPOLOGY}, UInt64), topology, i)
end

# Function 'chfl_topology_isbond' at topology.h:96
function chfl_topology_isbond(topology::Ptr{CHFL_TOPOLOGY}, i::UInt64, j::UInt64, result::Ref{Cbool})
    ccall((:chfl_topology_isbond, libchemfiles), chfl_status, (Ptr{CHFL_TOPOLOGY}, UInt64, UInt64, Ref{Cbool}), topology, i, j, result)
end

# Function 'chfl_topology_isangle' at topology.h:106
function chfl_topology_isangle(topology::Ptr{CHFL_TOPOLOGY}, i::UInt64, j::UInt64, k::UInt64, result::Ref{Cbool})
    ccall((:chfl_topology_isangle, libchemfiles), chfl_status, (Ptr{CHFL_TOPOLOGY}, UInt64, UInt64, UInt64, Ref{Cbool}), topology, i, j, k, result)
end

# Function 'chfl_topology_isdihedral' at topology.h:120
function chfl_topology_isdihedral(topology::Ptr{CHFL_TOPOLOGY}, i::UInt64, j::UInt64, k::UInt64, m::UInt64, result::Ref{Cbool})
    ccall((:chfl_topology_isdihedral, libchemfiles), chfl_status, (Ptr{CHFL_TOPOLOGY}, UInt64, UInt64, UInt64, UInt64, Ref{Cbool}), topology, i, j, k, m, result)
end

# Function 'chfl_topology_bonds_count' at topology.h:134
function chfl_topology_bonds_count(topology::Ptr{CHFL_TOPOLOGY}, nbonds::Ref{UInt64})
    ccall((:chfl_topology_bonds_count, libchemfiles), chfl_status, (Ptr{CHFL_TOPOLOGY}, Ref{UInt64}), topology, nbonds)
end

# Function 'chfl_topology_angles_count' at topology.h:143
function chfl_topology_angles_count(topology::Ptr{CHFL_TOPOLOGY}, nangles::Ref{UInt64})
    ccall((:chfl_topology_angles_count, libchemfiles), chfl_status, (Ptr{CHFL_TOPOLOGY}, Ref{UInt64}), topology, nangles)
end

# Function 'chfl_topology_dihedrals_count' at topology.h:152
function chfl_topology_dihedrals_count(topology::Ptr{CHFL_TOPOLOGY}, ndihedrals::Ref{UInt64})
    ccall((:chfl_topology_dihedrals_count, libchemfiles), chfl_status, (Ptr{CHFL_TOPOLOGY}, Ref{UInt64}), topology, ndihedrals)
end

# Function 'chfl_topology_bonds' at topology.h:165
function chfl_topology_bonds(topology::Ptr{CHFL_TOPOLOGY}, data::Ptr{UInt64}, nbonds::UInt64)
    ccall((:chfl_topology_bonds, libchemfiles), chfl_status, (Ptr{CHFL_TOPOLOGY}, Ptr{UInt64}, UInt64), topology, data, nbonds)
end

# Function 'chfl_topology_angles' at topology.h:178
function chfl_topology_angles(topology::Ptr{CHFL_TOPOLOGY}, data::Ptr{UInt64}, nangles::UInt64)
    ccall((:chfl_topology_angles, libchemfiles), chfl_status, (Ptr{CHFL_TOPOLOGY}, Ptr{UInt64}, UInt64), topology, data, nangles)
end

# Function 'chfl_topology_dihedrals' at topology.h:191
function chfl_topology_dihedrals(topology::Ptr{CHFL_TOPOLOGY}, data::Ptr{UInt64}, ndihedrals::UInt64)
    ccall((:chfl_topology_dihedrals, libchemfiles), chfl_status, (Ptr{CHFL_TOPOLOGY}, Ptr{UInt64}, UInt64), topology, data, ndihedrals)
end

# Function 'chfl_topology_add_bond' at topology.h:200
function chfl_topology_add_bond(topology::Ptr{CHFL_TOPOLOGY}, i::UInt64, j::UInt64)
    ccall((:chfl_topology_add_bond, libchemfiles), chfl_status, (Ptr{CHFL_TOPOLOGY}, UInt64, UInt64), topology, i, j)
end

# Function 'chfl_topology_remove_bond' at topology.h:212
function chfl_topology_remove_bond(topology::Ptr{CHFL_TOPOLOGY}, i::UInt64, j::UInt64)
    ccall((:chfl_topology_remove_bond, libchemfiles), chfl_status, (Ptr{CHFL_TOPOLOGY}, UInt64, UInt64), topology, i, j)
end

# Function 'chfl_topology_residues_count' at topology.h:222
function chfl_topology_residues_count(topology::Ptr{CHFL_TOPOLOGY}, nresidues::Ref{UInt64})
    ccall((:chfl_topology_residues_count, libchemfiles), chfl_status, (Ptr{CHFL_TOPOLOGY}, Ref{UInt64}), topology, nresidues)
end

# Function 'chfl_topology_add_residue' at topology.h:234
function chfl_topology_add_residue(topology::Ptr{CHFL_TOPOLOGY}, residue::Ptr{CHFL_RESIDUE})
    ccall((:chfl_topology_add_residue, libchemfiles), chfl_status, (Ptr{CHFL_TOPOLOGY}, Ptr{CHFL_RESIDUE}), topology, residue)
end

# Function 'chfl_topology_residues_linked' at topology.h:245
function chfl_topology_residues_linked(topology::Ptr{CHFL_TOPOLOGY}, first::Ptr{CHFL_RESIDUE}, second::Ptr{CHFL_RESIDUE}, result::Ref{Cbool})
    ccall((:chfl_topology_residues_linked, libchemfiles), chfl_status, (Ptr{CHFL_TOPOLOGY}, Ptr{CHFL_RESIDUE}, Ptr{CHFL_RESIDUE}, Ref{Cbool}), topology, first, second, result)
end

# Function 'chfl_topology_free' at topology.h:256
function chfl_topology_free(topology::Ptr{CHFL_TOPOLOGY})
    ccall((:chfl_topology_free, libchemfiles), chfl_status, (Ptr{CHFL_TOPOLOGY},), topology)
end

# Function 'chfl_cell' at cell.h:37
function chfl_cell(lenghts::chfl_vector_t)
    ccall((:chfl_cell, libchemfiles), Ptr{CHFL_CELL}, (Ptr{Float64},), lenghts)
end

# Function 'chfl_cell_triclinic' at cell.h:54
function chfl_cell_triclinic(lenghts::chfl_vector_t, angles::chfl_vector_t)
    ccall((:chfl_cell_triclinic, libchemfiles), Ptr{CHFL_CELL}, (Ptr{Float64}, Ptr{Float64}), lenghts, angles)
end

# Function 'chfl_cell_from_frame' at cell.h:66
function chfl_cell_from_frame(frame::Ptr{CHFL_FRAME})
    ccall((:chfl_cell_from_frame, libchemfiles), Ptr{CHFL_CELL}, (Ptr{CHFL_FRAME},), frame)
end

# Function 'chfl_cell_copy' at cell.h:76
function chfl_cell_copy(cell::Ptr{CHFL_CELL})
    ccall((:chfl_cell_copy, libchemfiles), Ptr{CHFL_CELL}, (Ptr{CHFL_CELL},), cell)
end

# Function 'chfl_cell_volume' at cell.h:83
function chfl_cell_volume(cell::Ptr{CHFL_CELL}, volume::Ref{Cdouble})
    ccall((:chfl_cell_volume, libchemfiles), chfl_status, (Ptr{CHFL_CELL}, Ref{Cdouble}), cell, volume)
end

# Function 'chfl_cell_lengths' at cell.h:92
function chfl_cell_lengths(cell::Ptr{CHFL_CELL}, lengths::chfl_vector_t)
    ccall((:chfl_cell_lengths, libchemfiles), chfl_status, (Ptr{CHFL_CELL}, Ptr{Float64}), cell, lengths)
end

# Function 'chfl_cell_set_lengths' at cell.h:103
function chfl_cell_set_lengths(cell::Ptr{CHFL_CELL}, lenghts::chfl_vector_t)
    ccall((:chfl_cell_set_lengths, libchemfiles), chfl_status, (Ptr{CHFL_CELL}, Ptr{Float64}), cell, lenghts)
end

# Function 'chfl_cell_angles' at cell.h:112
function chfl_cell_angles(cell::Ptr{CHFL_CELL}, angles::chfl_vector_t)
    ccall((:chfl_cell_angles, libchemfiles), chfl_status, (Ptr{CHFL_CELL}, Ptr{Float64}), cell, angles)
end

# Function 'chfl_cell_set_angles' at cell.h:125
function chfl_cell_set_angles(cell::Ptr{CHFL_CELL}, angles::chfl_vector_t)
    ccall((:chfl_cell_set_angles, libchemfiles), chfl_status, (Ptr{CHFL_CELL}, Ptr{Float64}), cell, angles)
end

# Function 'chfl_cell_matrix' at cell.h:143
function chfl_cell_matrix(cell::Ptr{CHFL_CELL}, matrix::Ptr{Float64})
    ccall((:chfl_cell_matrix, libchemfiles), chfl_status, (Ptr{CHFL_CELL}, Ptr{Float64}), cell, matrix)
end

# Function 'chfl_cell_shape' at cell.h:152
function chfl_cell_shape(cell::Ptr{CHFL_CELL}, shape::Ref{chfl_cell_shape_t})
    ccall((:chfl_cell_shape, libchemfiles), chfl_status, (Ptr{CHFL_CELL}, Ref{chfl_cell_shape_t}), cell, shape)
end

# Function 'chfl_cell_set_shape' at cell.h:161
function chfl_cell_set_shape(cell::Ptr{CHFL_CELL}, shape::chfl_cell_shape_t)
    ccall((:chfl_cell_set_shape, libchemfiles), chfl_status, (Ptr{CHFL_CELL}, chfl_cell_shape_t), cell, shape)
end

# Function 'chfl_cell_free' at cell.h:169
function chfl_cell_free(cell::Ptr{CHFL_CELL})
    ccall((:chfl_cell_free, libchemfiles), chfl_status, (Ptr{CHFL_CELL},), cell)
end

# Function 'chfl_frame' at frame.h:24
function chfl_frame()
    ccall((:chfl_frame, libchemfiles), Ptr{CHFL_FRAME}, (), )
end

# Function 'chfl_frame_copy' at frame.h:34
function chfl_frame_copy(frame::Ptr{CHFL_FRAME})
    ccall((:chfl_frame_copy, libchemfiles), Ptr{CHFL_FRAME}, (Ptr{CHFL_FRAME},), frame)
end

# Function 'chfl_frame_atoms_count' at frame.h:42
function chfl_frame_atoms_count(frame::Ptr{CHFL_FRAME}, natoms::Ref{UInt64})
    ccall((:chfl_frame_atoms_count, libchemfiles), chfl_status, (Ptr{CHFL_FRAME}, Ref{UInt64}), frame, natoms)
end

# Function 'chfl_frame_positions' at frame.h:60
function chfl_frame_positions(frame::Ptr{CHFL_FRAME}, positions::Ref{Ptr{Float64}}, size::Ref{UInt64})
    ccall((:chfl_frame_positions, libchemfiles), chfl_status, (Ptr{CHFL_FRAME}, Ref{Ptr{Float64}}, Ref{UInt64}), frame, positions, size)
end

# Function 'chfl_frame_velocities' at frame.h:82
function chfl_frame_velocities(frame::Ptr{CHFL_FRAME}, velocities::Ref{Ptr{Float64}}, size::Ref{UInt64})
    ccall((:chfl_frame_velocities, libchemfiles), chfl_status, (Ptr{CHFL_FRAME}, Ref{Ptr{Float64}}, Ref{UInt64}), frame, velocities, size)
end

# Function 'chfl_frame_add_atom' at frame.h:94
function chfl_frame_add_atom(frame::Ptr{CHFL_FRAME}, atom::Ptr{CHFL_ATOM}, position::chfl_vector_t, velocity::chfl_vector_t)
    ccall((:chfl_frame_add_atom, libchemfiles), chfl_status, (Ptr{CHFL_FRAME}, Ptr{CHFL_ATOM}, Ptr{Float64}, Ptr{Float64}), frame, atom, position, velocity)
end

# Function 'chfl_frame_remove' at frame.h:107
function chfl_frame_remove(frame::Ptr{CHFL_FRAME}, i::UInt64)
    ccall((:chfl_frame_remove, libchemfiles), chfl_status, (Ptr{CHFL_FRAME}, UInt64), frame, i)
end

# Function 'chfl_frame_resize' at frame.h:119
function chfl_frame_resize(frame::Ptr{CHFL_FRAME}, natoms::UInt64)
    ccall((:chfl_frame_resize, libchemfiles), chfl_status, (Ptr{CHFL_FRAME}, UInt64), frame, natoms)
end

# Function 'chfl_frame_add_velocities' at frame.h:131
function chfl_frame_add_velocities(frame::Ptr{CHFL_FRAME})
    ccall((:chfl_frame_add_velocities, libchemfiles), chfl_status, (Ptr{CHFL_FRAME},), frame)
end

# Function 'chfl_frame_has_velocities' at frame.h:139
function chfl_frame_has_velocities(frame::Ptr{CHFL_FRAME}, has_velocities::Ref{Cbool})
    ccall((:chfl_frame_has_velocities, libchemfiles), chfl_status, (Ptr{CHFL_FRAME}, Ref{Cbool}), frame, has_velocities)
end

# Function 'chfl_frame_set_cell' at frame.h:148
function chfl_frame_set_cell(frame::Ptr{CHFL_FRAME}, cell::Ptr{CHFL_CELL})
    ccall((:chfl_frame_set_cell, libchemfiles), chfl_status, (Ptr{CHFL_FRAME}, Ptr{CHFL_CELL}), frame, cell)
end

# Function 'chfl_frame_set_topology' at frame.h:160
function chfl_frame_set_topology(frame::Ptr{CHFL_FRAME}, topology::Ptr{CHFL_TOPOLOGY})
    ccall((:chfl_frame_set_topology, libchemfiles), chfl_status, (Ptr{CHFL_FRAME}, Ptr{CHFL_TOPOLOGY}), frame, topology)
end

# Function 'chfl_frame_step' at frame.h:170
function chfl_frame_step(frame::Ptr{CHFL_FRAME}, step::Ref{UInt64})
    ccall((:chfl_frame_step, libchemfiles), chfl_status, (Ptr{CHFL_FRAME}, Ref{UInt64}), frame, step)
end

# Function 'chfl_frame_set_step' at frame.h:179
function chfl_frame_set_step(frame::Ptr{CHFL_FRAME}, step::UInt64)
    ccall((:chfl_frame_set_step, libchemfiles), chfl_status, (Ptr{CHFL_FRAME}, UInt64), frame, step)
end

# Function 'chfl_frame_guess_topology' at frame.h:191
function chfl_frame_guess_topology(frame::Ptr{CHFL_FRAME})
    ccall((:chfl_frame_guess_topology, libchemfiles), chfl_status, (Ptr{CHFL_FRAME},), frame)
end

# Function 'chfl_frame_free' at frame.h:197
function chfl_frame_free(frame::Ptr{CHFL_FRAME})
    ccall((:chfl_frame_free, libchemfiles), chfl_status, (Ptr{CHFL_FRAME},), frame)
end

# Function 'chfl_trajectory_open' at trajectory.h:26
function chfl_trajectory_open(path::Ptr{UInt8}, mode::Cchar)
    ccall((:chfl_trajectory_open, libchemfiles), Ptr{CHFL_TRAJECTORY}, (Ptr{UInt8}, Cchar), path, mode)
end

# Function 'chfl_trajectory_with_format' at trajectory.h:42
function chfl_trajectory_with_format(path::Ptr{UInt8}, mode::Cchar, format::Ptr{UInt8})
    ccall((:chfl_trajectory_with_format, libchemfiles), Ptr{CHFL_TRAJECTORY}, (Ptr{UInt8}, Cchar, Ptr{UInt8}), path, mode, format)
end

# Function 'chfl_trajectory_read' at trajectory.h:54
function chfl_trajectory_read(trajectory::Ptr{CHFL_TRAJECTORY}, frame::Ptr{CHFL_FRAME})
    ccall((:chfl_trajectory_read, libchemfiles), chfl_status, (Ptr{CHFL_TRAJECTORY}, Ptr{CHFL_FRAME}), trajectory, frame)
end

# Function 'chfl_trajectory_read_step' at trajectory.h:66
function chfl_trajectory_read_step(trajectory::Ptr{CHFL_TRAJECTORY}, step::UInt64, frame::Ptr{CHFL_FRAME})
    ccall((:chfl_trajectory_read_step, libchemfiles), chfl_status, (Ptr{CHFL_TRAJECTORY}, UInt64, Ptr{CHFL_FRAME}), trajectory, step, frame)
end

# Function 'chfl_trajectory_write' at trajectory.h:75
function chfl_trajectory_write(trajectory::Ptr{CHFL_TRAJECTORY}, frame::Ptr{CHFL_FRAME})
    ccall((:chfl_trajectory_write, libchemfiles), chfl_status, (Ptr{CHFL_TRAJECTORY}, Ptr{CHFL_FRAME}), trajectory, frame)
end

# Function 'chfl_trajectory_set_topology' at trajectory.h:86
function chfl_trajectory_set_topology(trajectory::Ptr{CHFL_TRAJECTORY}, topology::Ptr{CHFL_TOPOLOGY})
    ccall((:chfl_trajectory_set_topology, libchemfiles), chfl_status, (Ptr{CHFL_TRAJECTORY}, Ptr{CHFL_TOPOLOGY}), trajectory, topology)
end

# Function 'chfl_trajectory_topology_file' at trajectory.h:100
function chfl_trajectory_topology_file(trajectory::Ptr{CHFL_TRAJECTORY}, path::Ptr{UInt8}, format::Ptr{UInt8})
    ccall((:chfl_trajectory_topology_file, libchemfiles), chfl_status, (Ptr{CHFL_TRAJECTORY}, Ptr{UInt8}, Ptr{UInt8}), trajectory, path, format)
end

# Function 'chfl_trajectory_set_cell' at trajectory.h:110
function chfl_trajectory_set_cell(trajectory::Ptr{CHFL_TRAJECTORY}, cell::Ptr{CHFL_CELL})
    ccall((:chfl_trajectory_set_cell, libchemfiles), chfl_status, (Ptr{CHFL_TRAJECTORY}, Ptr{CHFL_CELL}), trajectory, cell)
end

# Function 'chfl_trajectory_nsteps' at trajectory.h:120
function chfl_trajectory_nsteps(trajectory::Ptr{CHFL_TRAJECTORY}, nsteps::Ref{UInt64})
    ccall((:chfl_trajectory_nsteps, libchemfiles), chfl_status, (Ptr{CHFL_TRAJECTORY}, Ref{UInt64}), trajectory, nsteps)
end

# Function 'chfl_trajectory_close' at trajectory.h:131
function chfl_trajectory_close(trajectory::Ptr{CHFL_TRAJECTORY})
    ccall((:chfl_trajectory_close, libchemfiles), chfl_status, (Ptr{CHFL_TRAJECTORY},), trajectory)
end

# Function 'chfl_selection' at selection.h:24
function chfl_selection(selection::Ptr{UInt8})
    ccall((:chfl_selection, libchemfiles), Ptr{CHFL_SELECTION}, (Ptr{UInt8},), selection)
end

# Function 'chfl_selection_copy' at selection.h:37
function chfl_selection_copy(selection::Ptr{CHFL_SELECTION})
    ccall((:chfl_selection_copy, libchemfiles), Ptr{CHFL_SELECTION}, (Ptr{CHFL_SELECTION},), selection)
end

# Function 'chfl_selection_size' at selection.h:49
function chfl_selection_size(selection::Ptr{CHFL_SELECTION}, size::Ref{UInt64})
    ccall((:chfl_selection_size, libchemfiles), chfl_status, (Ptr{CHFL_SELECTION}, Ref{UInt64}), selection, size)
end

# Function 'chfl_selection_string' at selection.h:62
function chfl_selection_string(selection::Ptr{CHFL_SELECTION}, string::Ptr{UInt8}, buffsize::UInt64)
    ccall((:chfl_selection_string, libchemfiles), chfl_status, (Ptr{CHFL_SELECTION}, Ptr{UInt8}, UInt64), selection, string, buffsize)
end

# Function 'chfl_selection_evaluate' at selection.h:75
function chfl_selection_evaluate(selection::Ptr{CHFL_SELECTION}, frame::Ptr{CHFL_FRAME}, nmatches::Ref{UInt64})
    ccall((:chfl_selection_evaluate, libchemfiles), chfl_status, (Ptr{CHFL_SELECTION}, Ptr{CHFL_FRAME}, Ref{UInt64}), selection, frame, nmatches)
end

# Function 'chfl_selection_matches' at selection.h:101
function chfl_selection_matches(selection::Ptr{CHFL_SELECTION}, matches::Ptr{chfl_match_t}, nmatches::UInt64)
    ccall((:chfl_selection_matches, libchemfiles), chfl_status, (Ptr{CHFL_SELECTION}, Ptr{chfl_match_t}, UInt64), selection, matches, nmatches)
end

# Function 'chfl_selection_free' at selection.h:109
function chfl_selection_free(selection::Ptr{CHFL_SELECTION})
    ccall((:chfl_selection_free, libchemfiles), chfl_status, (Ptr{CHFL_SELECTION},), selection)
end
