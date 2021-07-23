# Chemfiles.jl, a modern library for chemistry file reading and writing
# Copyright (C) Guillaume Fraux and contributors -- BSD license
#
# =========================================================================== #
# !!!! AUTO-GENERATED FILE !!!! Do not edit. See the bindgen repository for
# the generation code (https://github.com/chemfiles/bindgen).
# This file contains Julia interface to the C API
# =========================================================================== #

# === Manually translated from the header
# Function 'chfl_trajectory_memory_buffer'
function chfl_trajectory_memory_buffer(trajectory::Ptr{CHFL_TRAJECTORY}, data::Ref{Ptr{UInt8}}, size::Ref{UInt64})
    ccall((:chfl_trajectory_memory_buffer, libchemfiles), chfl_status, (Ptr{CHFL_TRAJECTORY}, Ref{Ptr{UInt8}}, Ref{UInt64}), trajectory, data, size)
end
# === End of manual function defintion

# Function 'chfl_version' at types.h:150
function chfl_version()
    ccall((:chfl_version, libchemfiles), Ptr{UInt8}, (), )
end

# Function 'chfl_last_error' at misc.h:23
function chfl_last_error()
    ccall((:chfl_last_error, libchemfiles), Ptr{UInt8}, (), )
end

# Function 'chfl_clear_errors' at misc.h:33
function chfl_clear_errors()
    ccall((:chfl_clear_errors, libchemfiles), chfl_status, (), )
end

# Function 'chfl_set_warning_callback' at misc.h:42
function chfl_set_warning_callback(callback::Ptr{Cvoid})
    ccall((:chfl_set_warning_callback, libchemfiles), chfl_status, (Ptr{Cvoid},), callback)
end

# Function 'chfl_add_configuration' at misc.h:58
function chfl_add_configuration(path::Ptr{UInt8})
    ccall((:chfl_add_configuration, libchemfiles), chfl_status, (Ptr{UInt8},), path)
end

# Function 'chfl_formats_list' at misc.h:71
function chfl_formats_list(metadata::Ref{Ptr{chfl_format_metadata}}, count::Ref{UInt64})
    ccall((:chfl_formats_list, libchemfiles), chfl_status, (Ref{Ptr{chfl_format_metadata}}, Ref{UInt64}), metadata, count)
end

# Function 'chfl_guess_format' at misc.h:93
function chfl_guess_format(path::Ptr{UInt8}, format::Ptr{UInt8}, buffsize::UInt64)
    ccall((:chfl_guess_format, libchemfiles), chfl_status, (Ptr{UInt8}, Ptr{UInt8}, UInt64), path, format, buffsize)
end

# Function 'chfl_free' at misc.h:102
function chfl_free(object::Ptr{Cvoid})
    ccall((:chfl_free, libchemfiles), Cvoid, (Ptr{Cvoid},), object)
end

# Function 'chfl_property_bool' at property.h:37
function chfl_property_bool(value::Cbool)
    ccall((:chfl_property_bool, libchemfiles), Ptr{CHFL_PROPERTY}, (Cbool,), value)
end

# Function 'chfl_property_double' at property.h:47
function chfl_property_double(value::Cdouble)
    ccall((:chfl_property_double, libchemfiles), Ptr{CHFL_PROPERTY}, (Cdouble,), value)
end

# Function 'chfl_property_string' at property.h:57
function chfl_property_string(value::Ptr{UInt8})
    ccall((:chfl_property_string, libchemfiles), Ptr{CHFL_PROPERTY}, (Ptr{UInt8},), value)
end

# Function 'chfl_property_vector3d' at property.h:67
function chfl_property_vector3d(value::chfl_vector3d)
    ccall((:chfl_property_vector3d, libchemfiles), Ptr{CHFL_PROPERTY}, (Ptr{Float64},), value)
end

# Function 'chfl_property_get_kind' at property.h:74
function chfl_property_get_kind(property::Ptr{CHFL_PROPERTY}, kind::Ref{chfl_property_kind})
    ccall((:chfl_property_get_kind, libchemfiles), chfl_status, (Ptr{CHFL_PROPERTY}, Ref{chfl_property_kind}), property, kind)
end

# Function 'chfl_property_get_bool' at property.h:87
function chfl_property_get_bool(property::Ptr{CHFL_PROPERTY}, value::Ref{Cbool})
    ccall((:chfl_property_get_bool, libchemfiles), chfl_status, (Ptr{CHFL_PROPERTY}, Ref{Cbool}), property, value)
end

# Function 'chfl_property_get_double' at property.h:100
function chfl_property_get_double(property::Ptr{CHFL_PROPERTY}, value::Ref{Cdouble})
    ccall((:chfl_property_get_double, libchemfiles), chfl_status, (Ptr{CHFL_PROPERTY}, Ref{Cdouble}), property, value)
end

# Function 'chfl_property_get_string' at property.h:115
function chfl_property_get_string(property::Ptr{CHFL_PROPERTY}, buffer::Ptr{UInt8}, buffsize::UInt64)
    ccall((:chfl_property_get_string, libchemfiles), chfl_status, (Ptr{CHFL_PROPERTY}, Ptr{UInt8}, UInt64), property, buffer, buffsize)
end

# Function 'chfl_property_get_vector3d' at property.h:128
function chfl_property_get_vector3d(property::Ptr{CHFL_PROPERTY}, value::chfl_vector3d)
    ccall((:chfl_property_get_vector3d, libchemfiles), chfl_status, (Ptr{CHFL_PROPERTY}, Ptr{Float64}), property, value)
end

# Function 'chfl_atom' at atom.h:24
function chfl_atom(name::Ptr{UInt8})
    ccall((:chfl_atom, libchemfiles), Ptr{CHFL_ATOM}, (Ptr{UInt8},), name)
end

# Function 'chfl_atom_copy' at atom.h:34
function chfl_atom_copy(atom::Ptr{CHFL_ATOM})
    ccall((:chfl_atom_copy, libchemfiles), Ptr{CHFL_ATOM}, (Ptr{CHFL_ATOM},), atom)
end

# Function 'chfl_atom_from_frame' at atom.h:60
function chfl_atom_from_frame(frame::Ptr{CHFL_FRAME}, index::UInt64)
    ccall((:chfl_atom_from_frame, libchemfiles), Ptr{CHFL_ATOM}, (Ptr{CHFL_FRAME}, UInt64), frame, index)
end

# Function 'chfl_atom_from_topology' at atom.h:83
function chfl_atom_from_topology(topology::Ptr{CHFL_TOPOLOGY}, index::UInt64)
    ccall((:chfl_atom_from_topology, libchemfiles), Ptr{CHFL_ATOM}, (Ptr{CHFL_TOPOLOGY}, UInt64), topology, index)
end

# Function 'chfl_atom_mass' at atom.h:94
function chfl_atom_mass(atom::Ptr{CHFL_ATOM}, mass::Ref{Cdouble})
    ccall((:chfl_atom_mass, libchemfiles), chfl_status, (Ptr{CHFL_ATOM}, Ref{Cdouble}), atom, mass)
end

# Function 'chfl_atom_set_mass' at atom.h:103
function chfl_atom_set_mass(atom::Ptr{CHFL_ATOM}, mass::Cdouble)
    ccall((:chfl_atom_set_mass, libchemfiles), chfl_status, (Ptr{CHFL_ATOM}, Cdouble), atom, mass)
end

# Function 'chfl_atom_charge' at atom.h:112
function chfl_atom_charge(atom::Ptr{CHFL_ATOM}, charge::Ref{Cdouble})
    ccall((:chfl_atom_charge, libchemfiles), chfl_status, (Ptr{CHFL_ATOM}, Ref{Cdouble}), atom, charge)
end

# Function 'chfl_atom_set_charge' at atom.h:121
function chfl_atom_set_charge(atom::Ptr{CHFL_ATOM}, charge::Cdouble)
    ccall((:chfl_atom_set_charge, libchemfiles), chfl_status, (Ptr{CHFL_ATOM}, Cdouble), atom, charge)
end

# Function 'chfl_atom_type' at atom.h:131
function chfl_atom_type(atom::Ptr{CHFL_ATOM}, type::Ptr{UInt8}, buffsize::UInt64)
    ccall((:chfl_atom_type, libchemfiles), chfl_status, (Ptr{CHFL_ATOM}, Ptr{UInt8}, UInt64), atom, type, buffsize)
end

# Function 'chfl_atom_set_type' at atom.h:142
function chfl_atom_set_type(atom::Ptr{CHFL_ATOM}, type::Ptr{UInt8})
    ccall((:chfl_atom_set_type, libchemfiles), chfl_status, (Ptr{CHFL_ATOM}, Ptr{UInt8}), atom, type)
end

# Function 'chfl_atom_name' at atom.h:152
function chfl_atom_name(atom::Ptr{CHFL_ATOM}, name::Ptr{UInt8}, buffsize::UInt64)
    ccall((:chfl_atom_name, libchemfiles), chfl_status, (Ptr{CHFL_ATOM}, Ptr{UInt8}, UInt64), atom, name, buffsize)
end

# Function 'chfl_atom_set_name' at atom.h:163
function chfl_atom_set_name(atom::Ptr{CHFL_ATOM}, name::Ptr{UInt8})
    ccall((:chfl_atom_set_name, libchemfiles), chfl_status, (Ptr{CHFL_ATOM}, Ptr{UInt8}), atom, name)
end

# Function 'chfl_atom_full_name' at atom.h:173
function chfl_atom_full_name(atom::Ptr{CHFL_ATOM}, name::Ptr{UInt8}, buffsize::UInt64)
    ccall((:chfl_atom_full_name, libchemfiles), chfl_status, (Ptr{CHFL_ATOM}, Ptr{UInt8}, UInt64), atom, name, buffsize)
end

# Function 'chfl_atom_vdw_radius' at atom.h:185
function chfl_atom_vdw_radius(atom::Ptr{CHFL_ATOM}, radius::Ref{Cdouble})
    ccall((:chfl_atom_vdw_radius, libchemfiles), chfl_status, (Ptr{CHFL_ATOM}, Ref{Cdouble}), atom, radius)
end

# Function 'chfl_atom_covalent_radius' at atom.h:195
function chfl_atom_covalent_radius(atom::Ptr{CHFL_ATOM}, radius::Ref{Cdouble})
    ccall((:chfl_atom_covalent_radius, libchemfiles), chfl_status, (Ptr{CHFL_ATOM}, Ref{Cdouble}), atom, radius)
end

# Function 'chfl_atom_atomic_number' at atom.h:205
function chfl_atom_atomic_number(atom::Ptr{CHFL_ATOM}, number::Ref{UInt64})
    ccall((:chfl_atom_atomic_number, libchemfiles), chfl_status, (Ptr{CHFL_ATOM}, Ref{UInt64}), atom, number)
end

# Function 'chfl_atom_properties_count' at atom.h:212
function chfl_atom_properties_count(atom::Ptr{CHFL_ATOM}, count::Ref{UInt64})
    ccall((:chfl_atom_properties_count, libchemfiles), chfl_status, (Ptr{CHFL_ATOM}, Ref{UInt64}), atom, count)
end

# Function 'chfl_atom_list_properties' at atom.h:228
function chfl_atom_list_properties(atom::Ptr{CHFL_ATOM}, names::Ptr{Ptr{UInt8}}, count::UInt64)
    ccall((:chfl_atom_list_properties, libchemfiles), chfl_status, (Ptr{CHFL_ATOM}, Ptr{Ptr{UInt8}}, UInt64), atom, names, count)
end

# Function 'chfl_atom_set_property' at atom.h:240
function chfl_atom_set_property(atom::Ptr{CHFL_ATOM}, name::Ptr{UInt8}, property::Ptr{CHFL_PROPERTY})
    ccall((:chfl_atom_set_property, libchemfiles), chfl_status, (Ptr{CHFL_ATOM}, Ptr{UInt8}, Ptr{CHFL_PROPERTY}), atom, name, property)
end

# Function 'chfl_atom_get_property' at atom.h:254
function chfl_atom_get_property(atom::Ptr{CHFL_ATOM}, name::Ptr{UInt8})
    ccall((:chfl_atom_get_property, libchemfiles), Ptr{CHFL_PROPERTY}, (Ptr{CHFL_ATOM}, Ptr{UInt8}), atom, name)
end

# Function 'chfl_residue' at residue.h:25
function chfl_residue(name::Ptr{UInt8})
    ccall((:chfl_residue, libchemfiles), Ptr{CHFL_RESIDUE}, (Ptr{UInt8},), name)
end

# Function 'chfl_residue_with_id' at residue.h:35
function chfl_residue_with_id(name::Ptr{UInt8}, resid::Int64)
    ccall((:chfl_residue_with_id, libchemfiles), Ptr{CHFL_RESIDUE}, (Ptr{UInt8}, Int64), name, resid)
end

# Function 'chfl_residue_from_topology' at residue.h:63
function chfl_residue_from_topology(topology::Ptr{CHFL_TOPOLOGY}, i::UInt64)
    ccall((:chfl_residue_from_topology, libchemfiles), Ptr{CHFL_RESIDUE}, (Ptr{CHFL_TOPOLOGY}, UInt64), topology, i)
end

# Function 'chfl_residue_for_atom' at residue.h:90
function chfl_residue_for_atom(topology::Ptr{CHFL_TOPOLOGY}, i::UInt64)
    ccall((:chfl_residue_for_atom, libchemfiles), Ptr{CHFL_RESIDUE}, (Ptr{CHFL_TOPOLOGY}, UInt64), topology, i)
end

# Function 'chfl_residue_copy' at residue.h:102
function chfl_residue_copy(residue::Ptr{CHFL_RESIDUE})
    ccall((:chfl_residue_copy, libchemfiles), Ptr{CHFL_RESIDUE}, (Ptr{CHFL_RESIDUE},), residue)
end

# Function 'chfl_residue_atoms_count' at residue.h:109
function chfl_residue_atoms_count(residue::Ptr{CHFL_RESIDUE}, count::Ref{UInt64})
    ccall((:chfl_residue_atoms_count, libchemfiles), chfl_status, (Ptr{CHFL_RESIDUE}, Ref{UInt64}), residue, count)
end

# Function 'chfl_residue_atoms' at residue.h:123
function chfl_residue_atoms(residue::Ptr{CHFL_RESIDUE}, atoms::Ptr{UInt64}, count::UInt64)
    ccall((:chfl_residue_atoms, libchemfiles), chfl_status, (Ptr{CHFL_RESIDUE}, Ptr{UInt64}, UInt64), residue, atoms, count)
end

# Function 'chfl_residue_id' at residue.h:136
function chfl_residue_id(residue::Ptr{CHFL_RESIDUE}, id::Ref{Int64})
    ccall((:chfl_residue_id, libchemfiles), chfl_status, (Ptr{CHFL_RESIDUE}, Ref{Int64}), residue, id)
end

# Function 'chfl_residue_name' at residue.h:148
function chfl_residue_name(residue::Ptr{CHFL_RESIDUE}, name::Ptr{UInt8}, buffsize::UInt64)
    ccall((:chfl_residue_name, libchemfiles), chfl_status, (Ptr{CHFL_RESIDUE}, Ptr{UInt8}, UInt64), residue, name, buffsize)
end

# Function 'chfl_residue_add_atom' at residue.h:157
function chfl_residue_add_atom(residue::Ptr{CHFL_RESIDUE}, i::UInt64)
    ccall((:chfl_residue_add_atom, libchemfiles), chfl_status, (Ptr{CHFL_RESIDUE}, UInt64), residue, i)
end

# Function 'chfl_residue_contains' at residue.h:167
function chfl_residue_contains(residue::Ptr{CHFL_RESIDUE}, i::UInt64, result::Ref{Cbool})
    ccall((:chfl_residue_contains, libchemfiles), chfl_status, (Ptr{CHFL_RESIDUE}, UInt64, Ref{Cbool}), residue, i, result)
end

# Function 'chfl_residue_properties_count' at residue.h:176
function chfl_residue_properties_count(residue::Ptr{CHFL_RESIDUE}, count::Ref{UInt64})
    ccall((:chfl_residue_properties_count, libchemfiles), chfl_status, (Ptr{CHFL_RESIDUE}, Ref{UInt64}), residue, count)
end

# Function 'chfl_residue_list_properties' at residue.h:192
function chfl_residue_list_properties(residue::Ptr{CHFL_RESIDUE}, names::Ptr{Ptr{UInt8}}, count::UInt64)
    ccall((:chfl_residue_list_properties, libchemfiles), chfl_status, (Ptr{CHFL_RESIDUE}, Ptr{Ptr{UInt8}}, UInt64), residue, names, count)
end

# Function 'chfl_residue_set_property' at residue.h:204
function chfl_residue_set_property(residue::Ptr{CHFL_RESIDUE}, name::Ptr{UInt8}, property::Ptr{CHFL_PROPERTY})
    ccall((:chfl_residue_set_property, libchemfiles), chfl_status, (Ptr{CHFL_RESIDUE}, Ptr{UInt8}, Ptr{CHFL_PROPERTY}), residue, name, property)
end

# Function 'chfl_residue_get_property' at residue.h:218
function chfl_residue_get_property(residue::Ptr{CHFL_RESIDUE}, name::Ptr{UInt8})
    ccall((:chfl_residue_get_property, libchemfiles), Ptr{CHFL_PROPERTY}, (Ptr{CHFL_RESIDUE}, Ptr{UInt8}), residue, name)
end

# Function 'chfl_topology' at topology.h:25
function chfl_topology()
    ccall((:chfl_topology, libchemfiles), Ptr{CHFL_TOPOLOGY}, (), )
end

# Function 'chfl_topology_from_frame' at topology.h:38
function chfl_topology_from_frame(frame::Ptr{CHFL_FRAME})
    ccall((:chfl_topology_from_frame, libchemfiles), Ptr{CHFL_TOPOLOGY}, (Ptr{CHFL_FRAME},), frame)
end

# Function 'chfl_topology_copy' at topology.h:48
function chfl_topology_copy(topology::Ptr{CHFL_TOPOLOGY})
    ccall((:chfl_topology_copy, libchemfiles), Ptr{CHFL_TOPOLOGY}, (Ptr{CHFL_TOPOLOGY},), topology)
end

# Function 'chfl_topology_atoms_count' at topology.h:56
function chfl_topology_atoms_count(topology::Ptr{CHFL_TOPOLOGY}, count::Ref{UInt64})
    ccall((:chfl_topology_atoms_count, libchemfiles), chfl_status, (Ptr{CHFL_TOPOLOGY}, Ref{UInt64}), topology, count)
end

# Function 'chfl_topology_resize' at topology.h:68
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

# Function 'chfl_topology_bonds_count' at topology.h:95
function chfl_topology_bonds_count(topology::Ptr{CHFL_TOPOLOGY}, count::Ref{UInt64})
    ccall((:chfl_topology_bonds_count, libchemfiles), chfl_status, (Ptr{CHFL_TOPOLOGY}, Ref{UInt64}), topology, count)
end

# Function 'chfl_topology_angles_count' at topology.h:104
function chfl_topology_angles_count(topology::Ptr{CHFL_TOPOLOGY}, count::Ref{UInt64})
    ccall((:chfl_topology_angles_count, libchemfiles), chfl_status, (Ptr{CHFL_TOPOLOGY}, Ref{UInt64}), topology, count)
end

# Function 'chfl_topology_dihedrals_count' at topology.h:113
function chfl_topology_dihedrals_count(topology::Ptr{CHFL_TOPOLOGY}, count::Ref{UInt64})
    ccall((:chfl_topology_dihedrals_count, libchemfiles), chfl_status, (Ptr{CHFL_TOPOLOGY}, Ref{UInt64}), topology, count)
end

# Function 'chfl_topology_impropers_count' at topology.h:122
function chfl_topology_impropers_count(topology::Ptr{CHFL_TOPOLOGY}, count::Ref{UInt64})
    ccall((:chfl_topology_impropers_count, libchemfiles), chfl_status, (Ptr{CHFL_TOPOLOGY}, Ref{UInt64}), topology, count)
end

# Function 'chfl_topology_bonds' at topology.h:135
function chfl_topology_bonds(topology::Ptr{CHFL_TOPOLOGY}, data::Ptr{UInt64}, count::UInt64)
    ccall((:chfl_topology_bonds, libchemfiles), chfl_status, (Ptr{CHFL_TOPOLOGY}, Ptr{UInt64}, UInt64), topology, data, count)
end

# Function 'chfl_topology_angles' at topology.h:148
function chfl_topology_angles(topology::Ptr{CHFL_TOPOLOGY}, data::Ptr{UInt64}, count::UInt64)
    ccall((:chfl_topology_angles, libchemfiles), chfl_status, (Ptr{CHFL_TOPOLOGY}, Ptr{UInt64}, UInt64), topology, data, count)
end

# Function 'chfl_topology_dihedrals' at topology.h:162
function chfl_topology_dihedrals(topology::Ptr{CHFL_TOPOLOGY}, data::Ptr{UInt64}, count::UInt64)
    ccall((:chfl_topology_dihedrals, libchemfiles), chfl_status, (Ptr{CHFL_TOPOLOGY}, Ptr{UInt64}, UInt64), topology, data, count)
end

# Function 'chfl_topology_impropers' at topology.h:176
function chfl_topology_impropers(topology::Ptr{CHFL_TOPOLOGY}, data::Ptr{UInt64}, count::UInt64)
    ccall((:chfl_topology_impropers, libchemfiles), chfl_status, (Ptr{CHFL_TOPOLOGY}, Ptr{UInt64}, UInt64), topology, data, count)
end

# Function 'chfl_topology_add_bond' at topology.h:185
function chfl_topology_add_bond(topology::Ptr{CHFL_TOPOLOGY}, i::UInt64, j::UInt64)
    ccall((:chfl_topology_add_bond, libchemfiles), chfl_status, (Ptr{CHFL_TOPOLOGY}, UInt64, UInt64), topology, i, j)
end

# Function 'chfl_topology_remove_bond' at topology.h:197
function chfl_topology_remove_bond(topology::Ptr{CHFL_TOPOLOGY}, i::UInt64, j::UInt64)
    ccall((:chfl_topology_remove_bond, libchemfiles), chfl_status, (Ptr{CHFL_TOPOLOGY}, UInt64, UInt64), topology, i, j)
end

# Function 'chfl_topology_clear_bonds' at topology.h:207
function chfl_topology_clear_bonds(topology::Ptr{CHFL_TOPOLOGY})
    ccall((:chfl_topology_clear_bonds, libchemfiles), chfl_status, (Ptr{CHFL_TOPOLOGY},), topology)
end

# Function 'chfl_topology_residues_count' at topology.h:215
function chfl_topology_residues_count(topology::Ptr{CHFL_TOPOLOGY}, count::Ref{UInt64})
    ccall((:chfl_topology_residues_count, libchemfiles), chfl_status, (Ptr{CHFL_TOPOLOGY}, Ref{UInt64}), topology, count)
end

# Function 'chfl_topology_add_residue' at topology.h:227
function chfl_topology_add_residue(topology::Ptr{CHFL_TOPOLOGY}, residue::Ptr{CHFL_RESIDUE})
    ccall((:chfl_topology_add_residue, libchemfiles), chfl_status, (Ptr{CHFL_TOPOLOGY}, Ptr{CHFL_RESIDUE}), topology, residue)
end

# Function 'chfl_topology_residues_linked' at topology.h:238
function chfl_topology_residues_linked(topology::Ptr{CHFL_TOPOLOGY}, first::Ptr{CHFL_RESIDUE}, second::Ptr{CHFL_RESIDUE}, result::Ref{Cbool})
    ccall((:chfl_topology_residues_linked, libchemfiles), chfl_status, (Ptr{CHFL_TOPOLOGY}, Ptr{CHFL_RESIDUE}, Ptr{CHFL_RESIDUE}, Ref{Cbool}), topology, first, second, result)
end

# Function 'chfl_topology_bond_with_order' at topology.h:251
function chfl_topology_bond_with_order(topology::Ptr{CHFL_TOPOLOGY}, i::UInt64, j::UInt64, bond_order::chfl_bond_order)
    ccall((:chfl_topology_bond_with_order, libchemfiles), chfl_status, (Ptr{CHFL_TOPOLOGY}, UInt64, UInt64, chfl_bond_order), topology, i, j, bond_order)
end

# Function 'chfl_topology_bond_orders' at topology.h:265
function chfl_topology_bond_orders(topology::Ptr{CHFL_TOPOLOGY}, orders::Ptr{chfl_bond_order}, nbonds::UInt64)
    ccall((:chfl_topology_bond_orders, libchemfiles), chfl_status, (Ptr{CHFL_TOPOLOGY}, Ptr{chfl_bond_order}, UInt64), topology, orders, nbonds)
end

# Function 'chfl_topology_bond_order' at topology.h:278
function chfl_topology_bond_order(topology::Ptr{CHFL_TOPOLOGY}, i::UInt64, j::UInt64, order::Ref{chfl_bond_order})
    ccall((:chfl_topology_bond_order, libchemfiles), chfl_status, (Ptr{CHFL_TOPOLOGY}, UInt64, UInt64, Ref{chfl_bond_order}), topology, i, j, order)
end

# Function 'chfl_cell' at cell.h:40
function chfl_cell(lengths::chfl_vector3d, angles::chfl_vector3d)
    ccall((:chfl_cell, libchemfiles), Ptr{CHFL_CELL}, (Ptr{Float64}, Ptr{Float64}), lengths, angles)
end

# Function 'chfl_cell_from_matrix' at cell.h:55
function chfl_cell_from_matrix(matrix::Ptr{Cdouble})
    ccall((:chfl_cell_from_matrix, libchemfiles), Ptr{CHFL_CELL}, (Ptr{Cdouble},), matrix)
end

# Function 'chfl_cell_from_frame' at cell.h:68
function chfl_cell_from_frame(frame::Ptr{CHFL_FRAME})
    ccall((:chfl_cell_from_frame, libchemfiles), Ptr{CHFL_CELL}, (Ptr{CHFL_FRAME},), frame)
end

# Function 'chfl_cell_copy' at cell.h:78
function chfl_cell_copy(cell::Ptr{CHFL_CELL})
    ccall((:chfl_cell_copy, libchemfiles), Ptr{CHFL_CELL}, (Ptr{CHFL_CELL},), cell)
end

# Function 'chfl_cell_volume' at cell.h:85
function chfl_cell_volume(cell::Ptr{CHFL_CELL}, volume::Ref{Cdouble})
    ccall((:chfl_cell_volume, libchemfiles), chfl_status, (Ptr{CHFL_CELL}, Ref{Cdouble}), cell, volume)
end

# Function 'chfl_cell_lengths' at cell.h:94
function chfl_cell_lengths(cell::Ptr{CHFL_CELL}, lengths::chfl_vector3d)
    ccall((:chfl_cell_lengths, libchemfiles), chfl_status, (Ptr{CHFL_CELL}, Ptr{Float64}), cell, lengths)
end

# Function 'chfl_cell_set_lengths' at cell.h:110
function chfl_cell_set_lengths(cell::Ptr{CHFL_CELL}, lengths::chfl_vector3d)
    ccall((:chfl_cell_set_lengths, libchemfiles), chfl_status, (Ptr{CHFL_CELL}, Ptr{Float64}), cell, lengths)
end

# Function 'chfl_cell_angles' at cell.h:119
function chfl_cell_angles(cell::Ptr{CHFL_CELL}, angles::chfl_vector3d)
    ccall((:chfl_cell_angles, libchemfiles), chfl_status, (Ptr{CHFL_CELL}, Ptr{Float64}), cell, angles)
end

# Function 'chfl_cell_set_angles' at cell.h:137
function chfl_cell_set_angles(cell::Ptr{CHFL_CELL}, angles::chfl_vector3d)
    ccall((:chfl_cell_set_angles, libchemfiles), chfl_status, (Ptr{CHFL_CELL}, Ptr{Float64}), cell, angles)
end

# Function 'chfl_cell_matrix' at cell.h:146
function chfl_cell_matrix(cell::Ptr{CHFL_CELL}, matrix::Ptr{Cdouble})
    ccall((:chfl_cell_matrix, libchemfiles), chfl_status, (Ptr{CHFL_CELL}, Ptr{Cdouble}), cell, matrix)
end

# Function 'chfl_cell_shape' at cell.h:155
function chfl_cell_shape(cell::Ptr{CHFL_CELL}, shape::Ref{chfl_cellshape})
    ccall((:chfl_cell_shape, libchemfiles), chfl_status, (Ptr{CHFL_CELL}, Ref{chfl_cellshape}), cell, shape)
end

# Function 'chfl_cell_set_shape' at cell.h:164
function chfl_cell_set_shape(cell::Ptr{CHFL_CELL}, shape::chfl_cellshape)
    ccall((:chfl_cell_set_shape, libchemfiles), chfl_status, (Ptr{CHFL_CELL}, chfl_cellshape), cell, shape)
end

# Function 'chfl_cell_wrap' at cell.h:173
function chfl_cell_wrap(cell::Ptr{CHFL_CELL}, vector::chfl_vector3d)
    ccall((:chfl_cell_wrap, libchemfiles), chfl_status, (Ptr{CHFL_CELL}, Ptr{Float64}), cell, vector)
end

# Function 'chfl_frame' at frame.h:25
function chfl_frame()
    ccall((:chfl_frame, libchemfiles), Ptr{CHFL_FRAME}, (), )
end

# Function 'chfl_frame_copy' at frame.h:35
function chfl_frame_copy(frame::Ptr{CHFL_FRAME})
    ccall((:chfl_frame_copy, libchemfiles), Ptr{CHFL_FRAME}, (Ptr{CHFL_FRAME},), frame)
end

# Function 'chfl_frame_atoms_count' at frame.h:43
function chfl_frame_atoms_count(frame::Ptr{CHFL_FRAME}, count::Ref{UInt64})
    ccall((:chfl_frame_atoms_count, libchemfiles), chfl_status, (Ptr{CHFL_FRAME}, Ref{UInt64}), frame, count)
end

# Function 'chfl_frame_positions' at frame.h:62
function chfl_frame_positions(frame::Ptr{CHFL_FRAME}, positions::Ref{Ptr{Cdouble}}, size::Ref{UInt64})
    ccall((:chfl_frame_positions, libchemfiles), chfl_status, (Ptr{CHFL_FRAME}, Ref{Ptr{Cdouble}}, Ref{UInt64}), frame, positions, size)
end

# Function 'chfl_frame_velocities' at frame.h:85
function chfl_frame_velocities(frame::Ptr{CHFL_FRAME}, velocities::Ref{Ptr{Cdouble}}, size::Ref{UInt64})
    ccall((:chfl_frame_velocities, libchemfiles), chfl_status, (Ptr{CHFL_FRAME}, Ref{Ptr{Cdouble}}, Ref{UInt64}), frame, velocities, size)
end

# Function 'chfl_frame_add_atom' at frame.h:97
function chfl_frame_add_atom(frame::Ptr{CHFL_FRAME}, atom::Ptr{CHFL_ATOM}, position::chfl_vector3d, velocity::chfl_vector3d)
    ccall((:chfl_frame_add_atom, libchemfiles), chfl_status, (Ptr{CHFL_FRAME}, Ptr{CHFL_ATOM}, Ptr{Float64}, Ptr{Float64}), frame, atom, position, velocity)
end

# Function 'chfl_frame_remove' at frame.h:110
function chfl_frame_remove(frame::Ptr{CHFL_FRAME}, i::UInt64)
    ccall((:chfl_frame_remove, libchemfiles), chfl_status, (Ptr{CHFL_FRAME}, UInt64), frame, i)
end

# Function 'chfl_frame_resize' at frame.h:122
function chfl_frame_resize(frame::Ptr{CHFL_FRAME}, size::UInt64)
    ccall((:chfl_frame_resize, libchemfiles), chfl_status, (Ptr{CHFL_FRAME}, UInt64), frame, size)
end

# Function 'chfl_frame_add_velocities' at frame.h:134
function chfl_frame_add_velocities(frame::Ptr{CHFL_FRAME})
    ccall((:chfl_frame_add_velocities, libchemfiles), chfl_status, (Ptr{CHFL_FRAME},), frame)
end

# Function 'chfl_frame_has_velocities' at frame.h:142
function chfl_frame_has_velocities(frame::Ptr{CHFL_FRAME}, has_velocities::Ref{Cbool})
    ccall((:chfl_frame_has_velocities, libchemfiles), chfl_status, (Ptr{CHFL_FRAME}, Ref{Cbool}), frame, has_velocities)
end

# Function 'chfl_frame_set_cell' at frame.h:151
function chfl_frame_set_cell(frame::Ptr{CHFL_FRAME}, cell::Ptr{CHFL_CELL})
    ccall((:chfl_frame_set_cell, libchemfiles), chfl_status, (Ptr{CHFL_FRAME}, Ptr{CHFL_CELL}), frame, cell)
end

# Function 'chfl_frame_set_topology' at frame.h:163
function chfl_frame_set_topology(frame::Ptr{CHFL_FRAME}, topology::Ptr{CHFL_TOPOLOGY})
    ccall((:chfl_frame_set_topology, libchemfiles), chfl_status, (Ptr{CHFL_FRAME}, Ptr{CHFL_TOPOLOGY}), frame, topology)
end

# Function 'chfl_frame_step' at frame.h:173
function chfl_frame_step(frame::Ptr{CHFL_FRAME}, step::Ref{UInt64})
    ccall((:chfl_frame_step, libchemfiles), chfl_status, (Ptr{CHFL_FRAME}, Ref{UInt64}), frame, step)
end

# Function 'chfl_frame_set_step' at frame.h:182
function chfl_frame_set_step(frame::Ptr{CHFL_FRAME}, step::UInt64)
    ccall((:chfl_frame_set_step, libchemfiles), chfl_status, (Ptr{CHFL_FRAME}, UInt64), frame, step)
end

# Function 'chfl_frame_guess_bonds' at frame.h:194
function chfl_frame_guess_bonds(frame::Ptr{CHFL_FRAME})
    ccall((:chfl_frame_guess_bonds, libchemfiles), chfl_status, (Ptr{CHFL_FRAME},), frame)
end

# Function 'chfl_frame_distance' at frame.h:203
function chfl_frame_distance(frame::Ptr{CHFL_FRAME}, i::UInt64, j::UInt64, distance::Ref{Cdouble})
    ccall((:chfl_frame_distance, libchemfiles), chfl_status, (Ptr{CHFL_FRAME}, UInt64, UInt64, Ref{Cdouble}), frame, i, j, distance)
end

# Function 'chfl_frame_angle' at frame.h:214
function chfl_frame_angle(frame::Ptr{CHFL_FRAME}, i::UInt64, j::UInt64, k::UInt64, angle::Ref{Cdouble})
    ccall((:chfl_frame_angle, libchemfiles), chfl_status, (Ptr{CHFL_FRAME}, UInt64, UInt64, UInt64, Ref{Cdouble}), frame, i, j, k, angle)
end

# Function 'chfl_frame_dihedral' at frame.h:225
function chfl_frame_dihedral(frame::Ptr{CHFL_FRAME}, i::UInt64, j::UInt64, k::UInt64, m::UInt64, dihedral::Ref{Cdouble})
    ccall((:chfl_frame_dihedral, libchemfiles), chfl_status, (Ptr{CHFL_FRAME}, UInt64, UInt64, UInt64, UInt64, Ref{Cdouble}), frame, i, j, k, m, dihedral)
end

# Function 'chfl_frame_out_of_plane' at frame.h:239
function chfl_frame_out_of_plane(frame::Ptr{CHFL_FRAME}, i::UInt64, j::UInt64, k::UInt64, m::UInt64, distance::Ref{Cdouble})
    ccall((:chfl_frame_out_of_plane, libchemfiles), chfl_status, (Ptr{CHFL_FRAME}, UInt64, UInt64, UInt64, UInt64, Ref{Cdouble}), frame, i, j, k, m, distance)
end

# Function 'chfl_frame_properties_count' at frame.h:248
function chfl_frame_properties_count(frame::Ptr{CHFL_FRAME}, count::Ref{UInt64})
    ccall((:chfl_frame_properties_count, libchemfiles), chfl_status, (Ptr{CHFL_FRAME}, Ref{UInt64}), frame, count)
end

# Function 'chfl_frame_list_properties' at frame.h:264
function chfl_frame_list_properties(frame::Ptr{CHFL_FRAME}, names::Ptr{Ptr{UInt8}}, count::UInt64)
    ccall((:chfl_frame_list_properties, libchemfiles), chfl_status, (Ptr{CHFL_FRAME}, Ptr{Ptr{UInt8}}, UInt64), frame, names, count)
end

# Function 'chfl_frame_set_property' at frame.h:276
function chfl_frame_set_property(frame::Ptr{CHFL_FRAME}, name::Ptr{UInt8}, property::Ptr{CHFL_PROPERTY})
    ccall((:chfl_frame_set_property, libchemfiles), chfl_status, (Ptr{CHFL_FRAME}, Ptr{UInt8}, Ptr{CHFL_PROPERTY}), frame, name, property)
end

# Function 'chfl_frame_get_property' at frame.h:290
function chfl_frame_get_property(frame::Ptr{CHFL_FRAME}, name::Ptr{UInt8})
    ccall((:chfl_frame_get_property, libchemfiles), Ptr{CHFL_PROPERTY}, (Ptr{CHFL_FRAME}, Ptr{UInt8}), frame, name)
end

# Function 'chfl_frame_add_bond' at frame.h:299
function chfl_frame_add_bond(frame::Ptr{CHFL_FRAME}, i::UInt64, j::UInt64)
    ccall((:chfl_frame_add_bond, libchemfiles), chfl_status, (Ptr{CHFL_FRAME}, UInt64, UInt64), frame, i, j)
end

# Function 'chfl_frame_bond_with_order' at frame.h:309
function chfl_frame_bond_with_order(frame::Ptr{CHFL_FRAME}, i::UInt64, j::UInt64, bond_order::chfl_bond_order)
    ccall((:chfl_frame_bond_with_order, libchemfiles), chfl_status, (Ptr{CHFL_FRAME}, UInt64, UInt64, chfl_bond_order), frame, i, j, bond_order)
end

# Function 'chfl_frame_remove_bond' at frame.h:321
function chfl_frame_remove_bond(frame::Ptr{CHFL_FRAME}, i::UInt64, j::UInt64)
    ccall((:chfl_frame_remove_bond, libchemfiles), chfl_status, (Ptr{CHFL_FRAME}, UInt64, UInt64), frame, i, j)
end

# Function 'chfl_frame_clear_bonds' at frame.h:331
function chfl_frame_clear_bonds(frame::Ptr{CHFL_FRAME})
    ccall((:chfl_frame_clear_bonds, libchemfiles), chfl_status, (Ptr{CHFL_FRAME},), frame)
end

# Function 'chfl_frame_add_residue' at frame.h:341
function chfl_frame_add_residue(frame::Ptr{CHFL_FRAME}, residue::Ptr{CHFL_RESIDUE})
    ccall((:chfl_frame_add_residue, libchemfiles), chfl_status, (Ptr{CHFL_FRAME}, Ptr{CHFL_RESIDUE}), frame, residue)
end

# Function 'chfl_trajectory_open' at trajectory.h:26
function chfl_trajectory_open(path::Ptr{UInt8}, mode::Cchar)
    ccall((:chfl_trajectory_open, libchemfiles), Ptr{CHFL_TRAJECTORY}, (Ptr{UInt8}, Cchar), path, mode)
end

# Function 'chfl_trajectory_with_format' at trajectory.h:43
function chfl_trajectory_with_format(path::Ptr{UInt8}, mode::Cchar, format::Ptr{UInt8})
    ccall((:chfl_trajectory_with_format, libchemfiles), Ptr{CHFL_TRAJECTORY}, (Ptr{UInt8}, Cchar, Ptr{UInt8}), path, mode, format)
end

# Function 'chfl_trajectory_memory_reader' at trajectory.h:59
function chfl_trajectory_memory_reader(memory::Ptr{UInt8}, size::UInt64, format::Ptr{UInt8})
    ccall((:chfl_trajectory_memory_reader, libchemfiles), Ptr{CHFL_TRAJECTORY}, (Ptr{UInt8}, UInt64, Ptr{UInt8}), memory, size, format)
end

# Function 'chfl_trajectory_memory_writer' at trajectory.h:74
function chfl_trajectory_memory_writer(format::Ptr{UInt8})
    ccall((:chfl_trajectory_memory_writer, libchemfiles), Ptr{CHFL_TRAJECTORY}, (Ptr{UInt8},), format)
end

# Function 'chfl_trajectory_path' at trajectory.h:86
function chfl_trajectory_path(trajectory::Ptr{CHFL_TRAJECTORY}, path::Ptr{UInt8}, buffsize::UInt64)
    ccall((:chfl_trajectory_path, libchemfiles), chfl_status, (Ptr{CHFL_TRAJECTORY}, Ptr{UInt8}, UInt64), trajectory, path, buffsize)
end

# Function 'chfl_trajectory_read' at trajectory.h:98
function chfl_trajectory_read(trajectory::Ptr{CHFL_TRAJECTORY}, frame::Ptr{CHFL_FRAME})
    ccall((:chfl_trajectory_read, libchemfiles), chfl_status, (Ptr{CHFL_TRAJECTORY}, Ptr{CHFL_FRAME}), trajectory, frame)
end

# Function 'chfl_trajectory_read_step' at trajectory.h:110
function chfl_trajectory_read_step(trajectory::Ptr{CHFL_TRAJECTORY}, step::UInt64, frame::Ptr{CHFL_FRAME})
    ccall((:chfl_trajectory_read_step, libchemfiles), chfl_status, (Ptr{CHFL_TRAJECTORY}, UInt64, Ptr{CHFL_FRAME}), trajectory, step, frame)
end

# Function 'chfl_trajectory_write' at trajectory.h:119
function chfl_trajectory_write(trajectory::Ptr{CHFL_TRAJECTORY}, frame::Ptr{CHFL_FRAME})
    ccall((:chfl_trajectory_write, libchemfiles), chfl_status, (Ptr{CHFL_TRAJECTORY}, Ptr{CHFL_FRAME}), trajectory, frame)
end

# Function 'chfl_trajectory_set_topology' at trajectory.h:130
function chfl_trajectory_set_topology(trajectory::Ptr{CHFL_TRAJECTORY}, topology::Ptr{CHFL_TOPOLOGY})
    ccall((:chfl_trajectory_set_topology, libchemfiles), chfl_status, (Ptr{CHFL_TRAJECTORY}, Ptr{CHFL_TOPOLOGY}), trajectory, topology)
end

# Function 'chfl_trajectory_topology_file' at trajectory.h:144
function chfl_trajectory_topology_file(trajectory::Ptr{CHFL_TRAJECTORY}, path::Ptr{UInt8}, format::Ptr{UInt8})
    ccall((:chfl_trajectory_topology_file, libchemfiles), chfl_status, (Ptr{CHFL_TRAJECTORY}, Ptr{UInt8}, Ptr{UInt8}), trajectory, path, format)
end

# Function 'chfl_trajectory_set_cell' at trajectory.h:154
function chfl_trajectory_set_cell(trajectory::Ptr{CHFL_TRAJECTORY}, cell::Ptr{CHFL_CELL})
    ccall((:chfl_trajectory_set_cell, libchemfiles), chfl_status, (Ptr{CHFL_TRAJECTORY}, Ptr{CHFL_CELL}), trajectory, cell)
end

# Function 'chfl_trajectory_nsteps' at trajectory.h:164
function chfl_trajectory_nsteps(trajectory::Ptr{CHFL_TRAJECTORY}, nsteps::Ref{UInt64})
    ccall((:chfl_trajectory_nsteps, libchemfiles), chfl_status, (Ptr{CHFL_TRAJECTORY}, Ref{UInt64}), trajectory, nsteps)
end

# Function 'chfl_trajectory_close' at trajectory.h:188
function chfl_trajectory_close(trajectory::Ptr{CHFL_TRAJECTORY})
    ccall((:chfl_trajectory_close, libchemfiles), Cvoid, (Ptr{CHFL_TRAJECTORY},), trajectory)
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
function chfl_selection_evaluate(selection::Ptr{CHFL_SELECTION}, frame::Ptr{CHFL_FRAME}, n_matches::Ref{UInt64})
    ccall((:chfl_selection_evaluate, libchemfiles), chfl_status, (Ptr{CHFL_SELECTION}, Ptr{CHFL_FRAME}, Ref{UInt64}), selection, frame, n_matches)
end

# Function 'chfl_selection_matches' at selection.h:87
function chfl_selection_matches(selection::Ptr{CHFL_SELECTION}, matches::Ptr{chfl_match}, n_matches::UInt64)
    ccall((:chfl_selection_matches, libchemfiles), chfl_status, (Ptr{CHFL_SELECTION}, Ptr{chfl_match}, UInt64), selection, matches, n_matches)
end
