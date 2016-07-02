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

# Function 'chfl_version' at chemfiles.h:81
function chfl_version()
    ccall((:chfl_version, libchemfiles), Ptr{UInt8}, (), )
end

# Function 'chfl_strerror' at chemfiles.h:89
function chfl_strerror(status::Cint)
    ccall((:chfl_strerror, libchemfiles), Ptr{UInt8}, (Cint,), status)
end

# Function 'chfl_last_error' at chemfiles.h:96
function chfl_last_error()
    ccall((:chfl_last_error, libchemfiles), Ptr{UInt8}, (), )
end

# Function 'chfl_clear_errors' at chemfiles.h:102
function chfl_clear_errors()
    ccall((:chfl_clear_errors, libchemfiles), Cint, (), )
end

# Function 'chfl_loglevel' at chemfiles.h:121
function chfl_loglevel(level::Ref{CHFL_LOG_LEVEL})
    ccall((:chfl_loglevel, libchemfiles), Cint, (Ref{CHFL_LOG_LEVEL},), level)
end

# Function 'chfl_set_loglevel' at chemfiles.h:128
function chfl_set_loglevel(level::CHFL_LOG_LEVEL)
    ccall((:chfl_set_loglevel, libchemfiles), Cint, (CHFL_LOG_LEVEL,), level)
end

# Function 'chfl_logfile' at chemfiles.h:135
function chfl_logfile(file::Ptr{UInt8})
    ccall((:chfl_logfile, libchemfiles), Cint, (Ptr{UInt8},), file)
end

# Function 'chfl_log_stdout' at chemfiles.h:141
function chfl_log_stdout()
    ccall((:chfl_log_stdout, libchemfiles), Cint, (), )
end

# Function 'chfl_log_stderr' at chemfiles.h:148
function chfl_log_stderr()
    ccall((:chfl_log_stderr, libchemfiles), Cint, (), )
end

# Function 'chfl_log_silent' at chemfiles.h:154
function chfl_log_silent()
    ccall((:chfl_log_silent, libchemfiles), Cint, (), )
end

# Function 'chfl_log_callback' at chemfiles.h:165
function chfl_log_callback(callback::Ptr{Void})
    ccall((:chfl_log_callback, libchemfiles), Cint, (Ptr{Void},), callback)
end

# Function 'chfl_trajectory_open' at chemfiles.h:174
function chfl_trajectory_open(filename::Ptr{UInt8}, mode::Cchar)
    ccall((:chfl_trajectory_open, libchemfiles), Ptr{CHFL_TRAJECTORY}, (Ptr{UInt8}, Cchar), filename, mode)
end

# Function 'chfl_trajectory_with_format' at chemfiles.h:188
function chfl_trajectory_with_format(filename::Ptr{UInt8}, mode::Cchar, format::Ptr{UInt8})
    ccall((:chfl_trajectory_with_format, libchemfiles), Ptr{CHFL_TRAJECTORY}, (Ptr{UInt8}, Cchar, Ptr{UInt8}), filename, mode, format)
end

# Function 'chfl_trajectory_read' at chemfiles.h:198
function chfl_trajectory_read(file::Ptr{CHFL_TRAJECTORY}, frame::Ptr{CHFL_FRAME})
    ccall((:chfl_trajectory_read, libchemfiles), Cint, (Ptr{CHFL_TRAJECTORY}, Ptr{CHFL_FRAME}), file, frame)
end

# Function 'chfl_trajectory_read_step' at chemfiles.h:207
function chfl_trajectory_read_step(file::Ptr{CHFL_TRAJECTORY}, step::Csize_t, frame::Ptr{CHFL_FRAME})
    ccall((:chfl_trajectory_read_step, libchemfiles), Cint, (Ptr{CHFL_TRAJECTORY}, Csize_t, Ptr{CHFL_FRAME}), file, step, frame)
end

# Function 'chfl_trajectory_write' at chemfiles.h:217
function chfl_trajectory_write(file::Ptr{CHFL_TRAJECTORY}, frame::Ptr{CHFL_FRAME})
    ccall((:chfl_trajectory_write, libchemfiles), Cint, (Ptr{CHFL_TRAJECTORY}, Ptr{CHFL_FRAME}), file, frame)
end

# Function 'chfl_trajectory_set_topology' at chemfiles.h:228
function chfl_trajectory_set_topology(file::Ptr{CHFL_TRAJECTORY}, topology::Ptr{CHFL_TOPOLOGY})
    ccall((:chfl_trajectory_set_topology, libchemfiles), Cint, (Ptr{CHFL_TRAJECTORY}, Ptr{CHFL_TOPOLOGY}), file, topology)
end

# Function 'chfl_trajectory_set_topology_file' at chemfiles.h:238
function chfl_trajectory_set_topology_file(file::Ptr{CHFL_TRAJECTORY}, filename::Ptr{UInt8})
    ccall((:chfl_trajectory_set_topology_file, libchemfiles), Cint, (Ptr{CHFL_TRAJECTORY}, Ptr{UInt8}), file, filename)
end

# Function 'chfl_trajectory_set_topology_with_format' at chemfiles.h:256
function chfl_trajectory_set_topology_with_format(file::Ptr{CHFL_TRAJECTORY}, filename::Ptr{UInt8}, format::Ptr{UInt8})
    ccall((:chfl_trajectory_set_topology_with_format, libchemfiles), Cint, (Ptr{CHFL_TRAJECTORY}, Ptr{UInt8}, Ptr{UInt8}), file, filename, format)
end

# Function 'chfl_trajectory_set_cell' at chemfiles.h:268
function chfl_trajectory_set_cell(file::Ptr{CHFL_TRAJECTORY}, cell::Ptr{CHFL_CELL})
    ccall((:chfl_trajectory_set_cell, libchemfiles), Cint, (Ptr{CHFL_TRAJECTORY}, Ptr{CHFL_CELL}), file, cell)
end

# Function 'chfl_trajectory_nsteps' at chemfiles.h:277
function chfl_trajectory_nsteps(file::Ptr{CHFL_TRAJECTORY}, nsteps::Ref{Csize_t})
    ccall((:chfl_trajectory_nsteps, libchemfiles), Cint, (Ptr{CHFL_TRAJECTORY}, Ref{Csize_t}), file, nsteps)
end

# Function 'chfl_trajectory_sync' at chemfiles.h:284
function chfl_trajectory_sync(file::Ptr{CHFL_TRAJECTORY})
    ccall((:chfl_trajectory_sync, libchemfiles), Cint, (Ptr{CHFL_TRAJECTORY},), file)
end

# Function 'chfl_trajectory_close' at chemfiles.h:291
function chfl_trajectory_close(file::Ptr{CHFL_TRAJECTORY})
    ccall((:chfl_trajectory_close, libchemfiles), Cint, (Ptr{CHFL_TRAJECTORY},), file)
end

# Function 'chfl_frame' at chemfiles.h:300
function chfl_frame(natoms::Csize_t)
    ccall((:chfl_frame, libchemfiles), Ptr{CHFL_FRAME}, (Csize_t,), natoms)
end

# Function 'chfl_frame_atoms_count' at chemfiles.h:308
function chfl_frame_atoms_count(frame::Ptr{CHFL_FRAME}, natoms::Ref{Csize_t})
    ccall((:chfl_frame_atoms_count, libchemfiles), Cint, (Ptr{CHFL_FRAME}, Ref{Csize_t}), frame, natoms)
end

# Function 'chfl_frame_positions' at chemfiles.h:325
function chfl_frame_positions(frame::Ptr{CHFL_FRAME}, data::Ref{Ptr{Cfloat}}, size::Ref{Csize_t})
    ccall((:chfl_frame_positions, libchemfiles), Cint, (Ptr{CHFL_FRAME}, Ref{Ptr{Cfloat}}, Ref{Csize_t}), frame, data, size)
end

# Function 'chfl_frame_velocities' at chemfiles.h:346
function chfl_frame_velocities(frame::Ptr{CHFL_FRAME}, data::Ref{Ptr{Cfloat}}, size::Ref{Csize_t})
    ccall((:chfl_frame_velocities, libchemfiles), Cint, (Ptr{CHFL_FRAME}, Ref{Ptr{Cfloat}}, Ref{Csize_t}), frame, data, size)
end

# Function 'chfl_frame_resize' at chemfiles.h:361
function chfl_frame_resize(frame::Ptr{CHFL_FRAME}, natoms::Csize_t)
    ccall((:chfl_frame_resize, libchemfiles), Cint, (Ptr{CHFL_FRAME}, Csize_t), frame, natoms)
end

# Function 'chfl_frame_add_velocities' at chemfiles.h:372
function chfl_frame_add_velocities(frame::Ptr{CHFL_FRAME})
    ccall((:chfl_frame_add_velocities, libchemfiles), Cint, (Ptr{CHFL_FRAME},), frame)
end

# Function 'chfl_frame_has_velocities' at chemfiles.h:381
function chfl_frame_has_velocities(frame::Ptr{CHFL_FRAME}, has_velocities::Ref{CBool})
    ccall((:chfl_frame_has_velocities, libchemfiles), Cint, (Ptr{CHFL_FRAME}, Ref{CBool}), frame, has_velocities)
end

# Function 'chfl_frame_set_cell' at chemfiles.h:390
function chfl_frame_set_cell(frame::Ptr{CHFL_FRAME}, cell::Ptr{CHFL_CELL})
    ccall((:chfl_frame_set_cell, libchemfiles), Cint, (Ptr{CHFL_FRAME}, Ptr{CHFL_CELL}), frame, cell)
end

# Function 'chfl_frame_set_topology' at chemfiles.h:398
function chfl_frame_set_topology(frame::Ptr{CHFL_FRAME}, topology::Ptr{CHFL_TOPOLOGY})
    ccall((:chfl_frame_set_topology, libchemfiles), Cint, (Ptr{CHFL_FRAME}, Ptr{CHFL_TOPOLOGY}), frame, topology)
end

# Function 'chfl_frame_step' at chemfiles.h:407
function chfl_frame_step(frame::Ptr{CHFL_FRAME}, step::Ref{Csize_t})
    ccall((:chfl_frame_step, libchemfiles), Cint, (Ptr{CHFL_FRAME}, Ref{Csize_t}), frame, step)
end

# Function 'chfl_frame_set_step' at chemfiles.h:415
function chfl_frame_set_step(frame::Ptr{CHFL_FRAME}, step::Csize_t)
    ccall((:chfl_frame_set_step, libchemfiles), Cint, (Ptr{CHFL_FRAME}, Csize_t), frame, step)
end

# Function 'chfl_frame_guess_topology' at chemfiles.h:426
function chfl_frame_guess_topology(frame::Ptr{CHFL_FRAME})
    ccall((:chfl_frame_guess_topology, libchemfiles), Cint, (Ptr{CHFL_FRAME},), frame)
end

# Function 'chfl_frame_free' at chemfiles.h:433
function chfl_frame_free(frame::Ptr{CHFL_FRAME})
    ccall((:chfl_frame_free, libchemfiles), Cint, (Ptr{CHFL_FRAME},), frame)
end

# Function 'chfl_cell' at chemfiles.h:443
function chfl_cell(a::Cdouble, b::Cdouble, c::Cdouble)
    ccall((:chfl_cell, libchemfiles), Ptr{CHFL_CELL}, (Cdouble, Cdouble, Cdouble), a, b, c)
end

# Function 'chfl_cell_triclinic' at chemfiles.h:455
function chfl_cell_triclinic(a::Cdouble, b::Cdouble, c::Cdouble, alpha::Cdouble, beta::Cdouble, gamma::Cdouble)
    ccall((:chfl_cell_triclinic, libchemfiles), Ptr{CHFL_CELL}, (Cdouble, Cdouble, Cdouble, Cdouble, Cdouble, Cdouble), a, b, c, alpha, beta, gamma)
end

# Function 'chfl_cell_from_frame' at chemfiles.h:463
function chfl_cell_from_frame(frame::Ptr{CHFL_FRAME})
    ccall((:chfl_cell_from_frame, libchemfiles), Ptr{CHFL_CELL}, (Ptr{CHFL_FRAME},), frame)
end

# Function 'chfl_cell_volume' at chemfiles.h:471
function chfl_cell_volume(cell::Ptr{CHFL_CELL}, V::Ref{Cdouble})
    ccall((:chfl_cell_volume, libchemfiles), Cint, (Ptr{CHFL_CELL}, Ref{Cdouble}), cell, V)
end

# Function 'chfl_cell_lengths' at chemfiles.h:482
function chfl_cell_lengths(cell::Ptr{CHFL_CELL}, a::Ref{Cdouble}, b::Ref{Cdouble}, c::Ref{Cdouble})
    ccall((:chfl_cell_lengths, libchemfiles), Cint, (Ptr{CHFL_CELL}, Ref{Cdouble}, Ref{Cdouble}, Ref{Cdouble}), cell, a, b, c)
end

# Function 'chfl_cell_set_lengths' at chemfiles.h:493
function chfl_cell_set_lengths(cell::Ptr{CHFL_CELL}, a::Cdouble, b::Cdouble, c::Cdouble)
    ccall((:chfl_cell_set_lengths, libchemfiles), Cint, (Ptr{CHFL_CELL}, Cdouble, Cdouble, Cdouble), cell, a, b, c)
end

# Function 'chfl_cell_angles' at chemfiles.h:503
function chfl_cell_angles(cell::Ptr{CHFL_CELL}, alpha::Ref{Cdouble}, beta::Ref{Cdouble}, gamma::Ref{Cdouble})
    ccall((:chfl_cell_angles, libchemfiles), Cint, (Ptr{CHFL_CELL}, Ref{Cdouble}, Ref{Cdouble}, Ref{Cdouble}), cell, alpha, beta, gamma)
end

# Function 'chfl_cell_set_angles' at chemfiles.h:518
function chfl_cell_set_angles(cell::Ptr{CHFL_CELL}, alpha::Cdouble, beta::Cdouble, gamma::Cdouble)
    ccall((:chfl_cell_set_angles, libchemfiles), Cint, (Ptr{CHFL_CELL}, Cdouble, Cdouble, Cdouble), cell, alpha, beta, gamma)
end

# Function 'chfl_cell_matrix' at chemfiles.h:526
function chfl_cell_matrix(cell::Ptr{CHFL_CELL}, matrix::Ptr{Cdouble})
    ccall((:chfl_cell_matrix, libchemfiles), Cint, (Ptr{CHFL_CELL}, Ptr{Cdouble}), cell, matrix)
end

# Function 'chfl_cell_type' at chemfiles.h:544
function chfl_cell_type(cell::Ptr{CHFL_CELL}, typ::Ref{CHFL_CELL_TYPES})
    ccall((:chfl_cell_type, libchemfiles), Cint, (Ptr{CHFL_CELL}, Ref{CHFL_CELL_TYPES}), cell, typ)
end

# Function 'chfl_cell_set_type' at chemfiles.h:552
function chfl_cell_set_type(cell::Ptr{CHFL_CELL}, typ::CHFL_CELL_TYPES)
    ccall((:chfl_cell_set_type, libchemfiles), Cint, (Ptr{CHFL_CELL}, CHFL_CELL_TYPES), cell, typ)
end

# Function 'chfl_cell_free' at chemfiles.h:559
function chfl_cell_free(cell::Ptr{CHFL_CELL})
    ccall((:chfl_cell_free, libchemfiles), Cint, (Ptr{CHFL_CELL},), cell)
end

# Function 'chfl_topology' at chemfiles.h:567
function chfl_topology()
    ccall((:chfl_topology, libchemfiles), Ptr{CHFL_TOPOLOGY}, (), )
end

# Function 'chfl_topology_from_frame' at chemfiles.h:574
function chfl_topology_from_frame(frame::Ptr{CHFL_FRAME})
    ccall((:chfl_topology_from_frame, libchemfiles), Ptr{CHFL_TOPOLOGY}, (Ptr{CHFL_FRAME},), frame)
end

# Function 'chfl_topology_atoms_count' at chemfiles.h:582
function chfl_topology_atoms_count(topology::Ptr{CHFL_TOPOLOGY}, natoms::Ref{Csize_t})
    ccall((:chfl_topology_atoms_count, libchemfiles), Cint, (Ptr{CHFL_TOPOLOGY}, Ref{Csize_t}), topology, natoms)
end

# Function 'chfl_topology_append' at chemfiles.h:591
function chfl_topology_append(topology::Ptr{CHFL_TOPOLOGY}, atom::Ptr{CHFL_ATOM})
    ccall((:chfl_topology_append, libchemfiles), Cint, (Ptr{CHFL_TOPOLOGY}, Ptr{CHFL_ATOM}), topology, atom)
end

# Function 'chfl_topology_remove' at chemfiles.h:601
function chfl_topology_remove(topology::Ptr{CHFL_TOPOLOGY}, i::Csize_t)
    ccall((:chfl_topology_remove, libchemfiles), Cint, (Ptr{CHFL_TOPOLOGY}, Csize_t), topology, i)
end

# Function 'chfl_topology_isbond' at chemfiles.h:611
function chfl_topology_isbond(topology::Ptr{CHFL_TOPOLOGY}, i::Csize_t, j::Csize_t, result::Ref{CBool})
    ccall((:chfl_topology_isbond, libchemfiles), Cint, (Ptr{CHFL_TOPOLOGY}, Csize_t, Csize_t, Ref{CBool}), topology, i, j, result)
end

# Function 'chfl_topology_isangle' at chemfiles.h:625
function chfl_topology_isangle(topology::Ptr{CHFL_TOPOLOGY}, i::Csize_t, j::Csize_t, k::Csize_t, result::Ref{CBool})
    ccall((:chfl_topology_isangle, libchemfiles), Cint, (Ptr{CHFL_TOPOLOGY}, Csize_t, Csize_t, Csize_t, Ref{CBool}), topology, i, j, k, result)
end

# Function 'chfl_topology_isdihedral' at chemfiles.h:638
function chfl_topology_isdihedral(topology::Ptr{CHFL_TOPOLOGY}, i::Csize_t, j::Csize_t, k::Csize_t, m::Csize_t, result::Ref{CBool})
    ccall((:chfl_topology_isdihedral, libchemfiles), Cint, (Ptr{CHFL_TOPOLOGY}, Csize_t, Csize_t, Csize_t, Csize_t, Ref{CBool}), topology, i, j, k, m, result)
end

# Function 'chfl_topology_bonds_count' at chemfiles.h:651
function chfl_topology_bonds_count(topology::Ptr{CHFL_TOPOLOGY}, nbonds::Ref{Csize_t})
    ccall((:chfl_topology_bonds_count, libchemfiles), Cint, (Ptr{CHFL_TOPOLOGY}, Ref{Csize_t}), topology, nbonds)
end

# Function 'chfl_topology_angles_count' at chemfiles.h:660
function chfl_topology_angles_count(topology::Ptr{CHFL_TOPOLOGY}, nangles::Ref{Csize_t})
    ccall((:chfl_topology_angles_count, libchemfiles), Cint, (Ptr{CHFL_TOPOLOGY}, Ref{Csize_t}), topology, nangles)
end

# Function 'chfl_topology_dihedrals_count' at chemfiles.h:669
function chfl_topology_dihedrals_count(topology::Ptr{CHFL_TOPOLOGY}, ndihedrals::Ref{Csize_t})
    ccall((:chfl_topology_dihedrals_count, libchemfiles), Cint, (Ptr{CHFL_TOPOLOGY}, Ref{Csize_t}), topology, ndihedrals)
end

# Function 'chfl_topology_bonds' at chemfiles.h:680
function chfl_topology_bonds(topology::Ptr{CHFL_TOPOLOGY}, data::Ptr{Csize_t}, nbonds::Csize_t)
    ccall((:chfl_topology_bonds, libchemfiles), Cint, (Ptr{CHFL_TOPOLOGY}, Ptr{Csize_t}, Csize_t), topology, data, nbonds)
end

# Function 'chfl_topology_angles' at chemfiles.h:692
function chfl_topology_angles(topology::Ptr{CHFL_TOPOLOGY}, data::Ptr{Csize_t}, nangles::Csize_t)
    ccall((:chfl_topology_angles, libchemfiles), Cint, (Ptr{CHFL_TOPOLOGY}, Ptr{Csize_t}, Csize_t), topology, data, nangles)
end

# Function 'chfl_topology_dihedrals' at chemfiles.h:706
function chfl_topology_dihedrals(topology::Ptr{CHFL_TOPOLOGY}, data::Ptr{Csize_t}, ndihedrals::Csize_t)
    ccall((:chfl_topology_dihedrals, libchemfiles), Cint, (Ptr{CHFL_TOPOLOGY}, Ptr{Csize_t}, Csize_t), topology, data, ndihedrals)
end

# Function 'chfl_topology_add_bond' at chemfiles.h:718
function chfl_topology_add_bond(topology::Ptr{CHFL_TOPOLOGY}, i::Csize_t, j::Csize_t)
    ccall((:chfl_topology_add_bond, libchemfiles), Cint, (Ptr{CHFL_TOPOLOGY}, Csize_t, Csize_t), topology, i, j)
end

# Function 'chfl_topology_remove_bond' at chemfiles.h:728
function chfl_topology_remove_bond(topology::Ptr{CHFL_TOPOLOGY}, i::Csize_t, j::Csize_t)
    ccall((:chfl_topology_remove_bond, libchemfiles), Cint, (Ptr{CHFL_TOPOLOGY}, Csize_t, Csize_t), topology, i, j)
end

# Function 'chfl_topology_free' at chemfiles.h:735
function chfl_topology_free(topology::Ptr{CHFL_TOPOLOGY})
    ccall((:chfl_topology_free, libchemfiles), Cint, (Ptr{CHFL_TOPOLOGY},), topology)
end

# Function 'chfl_atom' at chemfiles.h:744
function chfl_atom(name::Ptr{UInt8})
    ccall((:chfl_atom, libchemfiles), Ptr{CHFL_ATOM}, (Ptr{UInt8},), name)
end

# Function 'chfl_atom_from_frame' at chemfiles.h:753
function chfl_atom_from_frame(frame::Ptr{CHFL_FRAME}, idx::Csize_t)
    ccall((:chfl_atom_from_frame, libchemfiles), Ptr{CHFL_ATOM}, (Ptr{CHFL_FRAME}, Csize_t), frame, idx)
end

# Function 'chfl_atom_from_topology' at chemfiles.h:763
function chfl_atom_from_topology(topology::Ptr{CHFL_TOPOLOGY}, idx::Csize_t)
    ccall((:chfl_atom_from_topology, libchemfiles), Ptr{CHFL_ATOM}, (Ptr{CHFL_TOPOLOGY}, Csize_t), topology, idx)
end

# Function 'chfl_atom_mass' at chemfiles.h:772
function chfl_atom_mass(atom::Ptr{CHFL_ATOM}, mass::Ref{Cfloat})
    ccall((:chfl_atom_mass, libchemfiles), Cint, (Ptr{CHFL_ATOM}, Ref{Cfloat}), atom, mass)
end

# Function 'chfl_atom_set_mass' at chemfiles.h:780
function chfl_atom_set_mass(atom::Ptr{CHFL_ATOM}, mass::Cfloat)
    ccall((:chfl_atom_set_mass, libchemfiles), Cint, (Ptr{CHFL_ATOM}, Cfloat), atom, mass)
end

# Function 'chfl_atom_charge' at chemfiles.h:788
function chfl_atom_charge(atom::Ptr{CHFL_ATOM}, charge::Ref{Cfloat})
    ccall((:chfl_atom_charge, libchemfiles), Cint, (Ptr{CHFL_ATOM}, Ref{Cfloat}), atom, charge)
end

# Function 'chfl_atom_set_charge' at chemfiles.h:796
function chfl_atom_set_charge(atom::Ptr{CHFL_ATOM}, charge::Cfloat)
    ccall((:chfl_atom_set_charge, libchemfiles), Cint, (Ptr{CHFL_ATOM}, Cfloat), atom, charge)
end

# Function 'chfl_atom_name' at chemfiles.h:806
function chfl_atom_name(atom::Ptr{CHFL_ATOM}, name::Ptr{UInt8}, buffsize::Csize_t)
    ccall((:chfl_atom_name, libchemfiles), Cint, (Ptr{CHFL_ATOM}, Ptr{UInt8}, Csize_t), atom, name, buffsize)
end

# Function 'chfl_atom_set_name' at chemfiles.h:814
function chfl_atom_set_name(atom::Ptr{CHFL_ATOM}, name::Ptr{UInt8})
    ccall((:chfl_atom_set_name, libchemfiles), Cint, (Ptr{CHFL_ATOM}, Ptr{UInt8}), atom, name)
end

# Function 'chfl_atom_full_name' at chemfiles.h:824
function chfl_atom_full_name(atom::Ptr{CHFL_ATOM}, name::Ptr{UInt8}, buffsize::Csize_t)
    ccall((:chfl_atom_full_name, libchemfiles), Cint, (Ptr{CHFL_ATOM}, Ptr{UInt8}, Csize_t), atom, name, buffsize)
end

# Function 'chfl_atom_vdw_radius' at chemfiles.h:833
function chfl_atom_vdw_radius(atom::Ptr{CHFL_ATOM}, radius::Ref{Cdouble})
    ccall((:chfl_atom_vdw_radius, libchemfiles), Cint, (Ptr{CHFL_ATOM}, Ref{Cdouble}), atom, radius)
end

# Function 'chfl_atom_covalent_radius' at chemfiles.h:842
function chfl_atom_covalent_radius(atom::Ptr{CHFL_ATOM}, radius::Ref{Cdouble})
    ccall((:chfl_atom_covalent_radius, libchemfiles), Cint, (Ptr{CHFL_ATOM}, Ref{Cdouble}), atom, radius)
end

# Function 'chfl_atom_atomic_number' at chemfiles.h:851
function chfl_atom_atomic_number(atom::Ptr{CHFL_ATOM}, number::Ref{Cint})
    ccall((:chfl_atom_atomic_number, libchemfiles), Cint, (Ptr{CHFL_ATOM}, Ref{Cint}), atom, number)
end

# Function 'chfl_atom_type' at chemfiles.h:872
function chfl_atom_type(atom::Ptr{CHFL_ATOM}, typ::Ref{CHFL_ATOM_TYPES})
    ccall((:chfl_atom_type, libchemfiles), Cint, (Ptr{CHFL_ATOM}, Ref{CHFL_ATOM_TYPES}), atom, typ)
end

# Function 'chfl_atom_set_type' at chemfiles.h:880
function chfl_atom_set_type(atom::Ptr{CHFL_ATOM}, typ::CHFL_ATOM_TYPES)
    ccall((:chfl_atom_set_type, libchemfiles), Cint, (Ptr{CHFL_ATOM}, CHFL_ATOM_TYPES), atom, typ)
end

# Function 'chfl_atom_free' at chemfiles.h:887
function chfl_atom_free(atom::Ptr{CHFL_ATOM})
    ccall((:chfl_atom_free, libchemfiles), Cint, (Ptr{CHFL_ATOM},), atom)
end

# Function 'chfl_selection' at chemfiles.h:895
function chfl_selection(selection::Ptr{UInt8})
    ccall((:chfl_selection, libchemfiles), Ptr{CHFL_SELECTION}, (Ptr{UInt8},), selection)
end

# Function 'chfl_selection_size' at chemfiles.h:909
function chfl_selection_size(selection::Ptr{CHFL_SELECTION}, size::Ref{Csize_t})
    ccall((:chfl_selection_size, libchemfiles), Cint, (Ptr{CHFL_SELECTION}, Ref{Csize_t}), selection, size)
end

# Function 'chfl_selection_evalutate' at chemfiles.h:921
function chfl_selection_evalutate(selection::Ptr{CHFL_SELECTION}, frame::Ptr{CHFL_FRAME}, n_matches::Ref{Csize_t})
    ccall((:chfl_selection_evalutate, libchemfiles), Cint, (Ptr{CHFL_SELECTION}, Ptr{CHFL_FRAME}, Ref{Csize_t}), selection, frame, n_matches)
end

# Function 'chfl_selection_matches' at chemfiles.h:945
function chfl_selection_matches(selection::Ptr{CHFL_SELECTION}, matches::Ptr{chfl_match_t}, n_matches::Csize_t)
    ccall((:chfl_selection_matches, libchemfiles), Cint, (Ptr{CHFL_SELECTION}, Ptr{chfl_match_t}, Csize_t), selection, matches, n_matches)
end

# Function 'chfl_selection_free' at chemfiles.h:954
function chfl_selection_free(selection::Ptr{CHFL_SELECTION})
    ccall((:chfl_selection_free, libchemfiles), Cint, (Ptr{CHFL_SELECTION},), selection)
end
