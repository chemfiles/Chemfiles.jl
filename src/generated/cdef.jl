# Julia wrapper for header: /usr/local/include/chemharp.h
# Automatically generated using Clang.jl wrap_c, version 0.0.0


function chrp_strerror(status::Cint)
    ccall((:chrp_strerror,libchemharp),Ptr{Uint8},(Cint,),status)
end

function chrp_last_error()
    ccall((:chrp_last_error,libchemharp),Ptr{Uint8},())
end

function chrp_loglevel(level::chrp_log_level_t)
    ccall((:chrp_loglevel,libchemharp),Cint,(chrp_log_level_t,),level)
end

function chrp_logfile(file::Ptr{Uint8})
    ccall((:chrp_logfile,libchemharp),Cint,(Ptr{Uint8},),file)
end

function chrp_log_stderr()
    ccall((:chrp_log_stderr,libchemharp),Cint,())
end

function chrp_open(filename::Ptr{Uint8},mode::Ptr{Uint8})
    ccall((:chrp_open,libchemharp),Ptr{CHRP_TRAJECTORY},(Ptr{Uint8},Ptr{Uint8}),filename,mode)
end

function chrp_trajectory_read(file::Ptr{CHRP_TRAJECTORY},frame::Ptr{CHRP_FRAME})
    ccall((:chrp_trajectory_read,libchemharp),Cint,(Ptr{CHRP_TRAJECTORY},Ptr{CHRP_FRAME}),file,frame)
end

function chrp_trajectory_read_at(file::Ptr{CHRP_TRAJECTORY},step::Csize_t,frame::Ptr{CHRP_FRAME})
    ccall((:chrp_trajectory_read_at,libchemharp),Cint,(Ptr{CHRP_TRAJECTORY},Csize_t,Ptr{CHRP_FRAME}),file,step,frame)
end

function chrp_trajectory_write(file::Ptr{CHRP_TRAJECTORY},frame::Ptr{CHRP_FRAME})
    ccall((:chrp_trajectory_write,libchemharp),Cint,(Ptr{CHRP_TRAJECTORY},Ptr{CHRP_FRAME}),file,frame)
end

function chrp_trajectory_topology(file::Ptr{CHRP_TRAJECTORY},topology::Ptr{CHRP_TOPOLOGY})
    ccall((:chrp_trajectory_topology,libchemharp),Cint,(Ptr{CHRP_TRAJECTORY},Ptr{CHRP_TOPOLOGY}),file,topology)
end

function chrp_trajectory_topology_file(file::Ptr{CHRP_TRAJECTORY},filename::Ptr{Uint8})
    ccall((:chrp_trajectory_topology_file,libchemharp),Cint,(Ptr{CHRP_TRAJECTORY},Ptr{Uint8}),file,filename)
end

function chrp_trajectory_cell(file::Ptr{CHRP_TRAJECTORY},cell::Ptr{CHRP_CELL})
    ccall((:chrp_trajectory_cell,libchemharp),Cint,(Ptr{CHRP_TRAJECTORY},Ptr{CHRP_CELL}),file,cell)
end

function chrp_trajectory_nsteps(file::Ptr{CHRP_TRAJECTORY},nsteps::Ptr{Csize_t})
    ccall((:chrp_trajectory_nsteps,libchemharp),Cint,(Ptr{CHRP_TRAJECTORY},Ptr{Csize_t}),file,nsteps)
end

function chrp_trajectory_close(file::Ptr{CHRP_TRAJECTORY})
    ccall((:chrp_trajectory_close,libchemharp),Cint,(Ptr{CHRP_TRAJECTORY},),file)
end

function chrp_frame(natoms::Csize_t)
    ccall((:chrp_frame,libchemharp),Ptr{CHRP_FRAME},(Csize_t,),natoms)
end

function chrp_frame_size(frame::Ptr{CHRP_FRAME},natoms::Ptr{Csize_t})
    ccall((:chrp_frame_size,libchemharp),Cint,(Ptr{CHRP_FRAME},Ptr{Csize_t}),frame,natoms)
end

function chrp_frame_positions(frame::Ptr{CHRP_FRAME},data::Ptr{Void},size::Csize_t)
    ccall((:chrp_frame_positions,libchemharp),Cint,(Ptr{CHRP_FRAME},Ptr{Void},Csize_t),frame,data,size)
end

function chrp_frame_positions_set(frame::Ptr{CHRP_FRAME},data::Ptr{Void},size::Csize_t)
    ccall((:chrp_frame_positions_set,libchemharp),Cint,(Ptr{CHRP_FRAME},Ptr{Void},Csize_t),frame,data,size)
end

function chrp_frame_velocities(frame::Ptr{CHRP_FRAME},data::Ptr{Void},size::Csize_t)
    ccall((:chrp_frame_velocities,libchemharp),Cint,(Ptr{CHRP_FRAME},Ptr{Void},Csize_t),frame,data,size)
end

function chrp_frame_velocities_set(frame::Ptr{CHRP_FRAME},data::Ptr{Void},size::Csize_t)
    ccall((:chrp_frame_velocities_set,libchemharp),Cint,(Ptr{CHRP_FRAME},Ptr{Void},Csize_t),frame,data,size)
end

function chrp_frame_has_velocities(frame::Ptr{CHRP_FRAME},has_vel::Ptr{Bool})
    ccall((:chrp_frame_has_velocities,libchemharp),Cint,(Ptr{CHRP_FRAME},Ptr{Bool}),frame,has_vel)
end

function chrp_frame_cell_set(frame::Ptr{CHRP_FRAME},cell::Ptr{CHRP_CELL})
    ccall((:chrp_frame_cell_set,libchemharp),Cint,(Ptr{CHRP_FRAME},Ptr{CHRP_CELL}),frame,cell)
end

function chrp_frame_topology_set(frame::Ptr{CHRP_FRAME},topology::Ptr{CHRP_TOPOLOGY})
    ccall((:chrp_frame_topology_set,libchemharp),Cint,(Ptr{CHRP_FRAME},Ptr{CHRP_TOPOLOGY}),frame,topology)
end

function chrp_frame_step(frame::Ptr{CHRP_FRAME},step::Ptr{Csize_t})
    ccall((:chrp_frame_step,libchemharp),Cint,(Ptr{CHRP_FRAME},Ptr{Csize_t}),frame,step)
end

function chrp_frame_step_set(frame::Ptr{CHRP_FRAME},step::Csize_t)
    ccall((:chrp_frame_step_set,libchemharp),Cint,(Ptr{CHRP_FRAME},Csize_t),frame,step)
end

function chrp_frame_guess_topology(frame::Ptr{CHRP_FRAME},bonds::Bool)
    ccall((:chrp_frame_guess_topology,libchemharp),Cint,(Ptr{CHRP_FRAME},Bool),frame,bonds)
end

function chrp_frame_free(frame::Ptr{CHRP_FRAME})
    ccall((:chrp_frame_free,libchemharp),Cint,(Ptr{CHRP_FRAME},),frame)
end

function chrp_cell(a::Cdouble,b::Cdouble,c::Cdouble,alpha::Cdouble,beta::Cdouble,gamma::Cdouble)
    ccall((:chrp_cell,libchemharp),Ptr{CHRP_CELL},(Cdouble,Cdouble,Cdouble,Cdouble,Cdouble,Cdouble),a,b,c,alpha,beta,gamma)
end

function chrp_cell_from_frame(frame::Ptr{CHRP_FRAME})
    ccall((:chrp_cell_from_frame,libchemharp),Ptr{CHRP_CELL},(Ptr{CHRP_FRAME},),frame)
end

function chrp_cell_lengths(cell::Ptr{CHRP_CELL},a::Ptr{Cdouble},b::Ptr{Cdouble},c::Ptr{Cdouble})
    ccall((:chrp_cell_lengths,libchemharp),Cint,(Ptr{CHRP_CELL},Ptr{Cdouble},Ptr{Cdouble},Ptr{Cdouble}),cell,a,b,c)
end

function chrp_cell_lengths_set(cell::Ptr{CHRP_CELL},a::Cdouble,b::Cdouble,c::Cdouble)
    ccall((:chrp_cell_lengths_set,libchemharp),Cint,(Ptr{CHRP_CELL},Cdouble,Cdouble,Cdouble),cell,a,b,c)
end

function chrp_cell_angles(cell::Ptr{CHRP_CELL},alpha::Ptr{Cdouble},beta::Ptr{Cdouble},gamma::Ptr{Cdouble})
    ccall((:chrp_cell_angles,libchemharp),Cint,(Ptr{CHRP_CELL},Ptr{Cdouble},Ptr{Cdouble},Ptr{Cdouble}),cell,alpha,beta,gamma)
end

function chrp_cell_angles_set(cell::Ptr{CHRP_CELL},alpha::Cdouble,beta::Cdouble,gamma::Cdouble)
    ccall((:chrp_cell_angles_set,libchemharp),Cint,(Ptr{CHRP_CELL},Cdouble,Cdouble,Cdouble),cell,alpha,beta,gamma)
end

function chrp_cell_matrix(cell::Ptr{CHRP_CELL},mat::Ptr{Array_3_Cdouble})
    ccall((:chrp_cell_matrix,libchemharp),Cint,(Ptr{CHRP_CELL},Ptr{Array_3_Cdouble}),cell,mat)
end

function chrp_cell_type(cell::Ptr{CHRP_CELL},_type::Ptr{chrp_cell_type_t})
    ccall((:chrp_cell_type,libchemharp),Cint,(Ptr{CHRP_CELL},Ptr{chrp_cell_type_t}),cell,_type)
end

function chrp_cell_type_set(cell::Ptr{CHRP_CELL},_type::chrp_cell_type_t)
    ccall((:chrp_cell_type_set,libchemharp),Cint,(Ptr{CHRP_CELL},chrp_cell_type_t),cell,_type)
end

function chrp_cell_periodicity(cell::Ptr{CHRP_CELL},x::Ptr{Bool},y::Ptr{Bool},z::Ptr{Bool})
    ccall((:chrp_cell_periodicity,libchemharp),Cint,(Ptr{CHRP_CELL},Ptr{Bool},Ptr{Bool},Ptr{Bool}),cell,x,y,z)
end

function chrp_cell_periodicity_set(cell::Ptr{CHRP_CELL},x::Bool,y::Bool,z::Bool)
    ccall((:chrp_cell_periodicity_set,libchemharp),Cint,(Ptr{CHRP_CELL},Bool,Bool,Bool),cell,x,y,z)
end

function chrp_cell_free(cell::Ptr{CHRP_CELL})
    ccall((:chrp_cell_free,libchemharp),Cint,(Ptr{CHRP_CELL},),cell)
end

function chrp_topology()
    ccall((:chrp_topology,libchemharp),Ptr{CHRP_TOPOLOGY},())
end

function chrp_topology_from_frame(frame::Ptr{CHRP_FRAME})
    ccall((:chrp_topology_from_frame,libchemharp),Ptr{CHRP_TOPOLOGY},(Ptr{CHRP_FRAME},),frame)
end

function chrp_topology_size(topology::Ptr{CHRP_TOPOLOGY},natoms::Ptr{Csize_t})
    ccall((:chrp_topology_size,libchemharp),Cint,(Ptr{CHRP_TOPOLOGY},Ptr{Csize_t}),topology,natoms)
end

function chrp_topology_append(topology::Ptr{CHRP_TOPOLOGY},atom::Ptr{CHRP_ATOM})
    ccall((:chrp_topology_append,libchemharp),Cint,(Ptr{CHRP_TOPOLOGY},Ptr{CHRP_ATOM}),topology,atom)
end

function chrp_topology_remove(topology::Ptr{CHRP_TOPOLOGY},i::Csize_t)
    ccall((:chrp_topology_remove,libchemharp),Cint,(Ptr{CHRP_TOPOLOGY},Csize_t),topology,i)
end

function chrp_topology_isbond(topology::Ptr{CHRP_TOPOLOGY},i::Csize_t,j::Csize_t,result::Ptr{Bool})
    ccall((:chrp_topology_isbond,libchemharp),Cint,(Ptr{CHRP_TOPOLOGY},Csize_t,Csize_t,Ptr{Bool}),topology,i,j,result)
end

function chrp_topology_isangle(topology::Ptr{CHRP_TOPOLOGY},i::Csize_t,j::Csize_t,k::Csize_t,result::Ptr{Bool})
    ccall((:chrp_topology_isangle,libchemharp),Cint,(Ptr{CHRP_TOPOLOGY},Csize_t,Csize_t,Csize_t,Ptr{Bool}),topology,i,j,k,result)
end

function chrp_topology_isdihedral(topology::Ptr{CHRP_TOPOLOGY},i::Csize_t,j::Csize_t,k::Csize_t,m::Csize_t,result::Ptr{Bool})
    ccall((:chrp_topology_isdihedral,libchemharp),Cint,(Ptr{CHRP_TOPOLOGY},Csize_t,Csize_t,Csize_t,Csize_t,Ptr{Bool}),topology,i,j,k,m,result)
end

function chrp_topology_bonds_count(topology::Ptr{CHRP_TOPOLOGY},nbonds::Ptr{Csize_t})
    ccall((:chrp_topology_bonds_count,libchemharp),Cint,(Ptr{CHRP_TOPOLOGY},Ptr{Csize_t}),topology,nbonds)
end

function chrp_topology_angles_count(topology::Ptr{CHRP_TOPOLOGY},nangles::Ptr{Csize_t})
    ccall((:chrp_topology_angles_count,libchemharp),Cint,(Ptr{CHRP_TOPOLOGY},Ptr{Csize_t}),topology,nangles)
end

function chrp_topology_dihedrals_count(topology::Ptr{CHRP_TOPOLOGY},ndihedrals::Ptr{Csize_t})
    ccall((:chrp_topology_dihedrals_count,libchemharp),Cint,(Ptr{CHRP_TOPOLOGY},Ptr{Csize_t}),topology,ndihedrals)
end

function chrp_topology_bonds(topology::Ptr{CHRP_TOPOLOGY},data::Ptr{Void},nbonds::Csize_t)
    ccall((:chrp_topology_bonds,libchemharp),Cint,(Ptr{CHRP_TOPOLOGY},Ptr{Void},Csize_t),topology,data,nbonds)
end

function chrp_topology_angles(topology::Ptr{CHRP_TOPOLOGY},data::Ptr{Void},nangles::Csize_t)
    ccall((:chrp_topology_angles,libchemharp),Cint,(Ptr{CHRP_TOPOLOGY},Ptr{Void},Csize_t),topology,data,nangles)
end

function chrp_topology_dihedrals(topology::Ptr{CHRP_TOPOLOGY},data::Ptr{Void},ndihedrals::Csize_t)
    ccall((:chrp_topology_dihedrals,libchemharp),Cint,(Ptr{CHRP_TOPOLOGY},Ptr{Void},Csize_t),topology,data,ndihedrals)
end

function chrp_topology_add_bond(topology::Ptr{CHRP_TOPOLOGY},i::Csize_t,j::Csize_t)
    ccall((:chrp_topology_add_bond,libchemharp),Cint,(Ptr{CHRP_TOPOLOGY},Csize_t,Csize_t),topology,i,j)
end

function chrp_topology_remove_bond(topology::Ptr{CHRP_TOPOLOGY},i::Csize_t,j::Csize_t)
    ccall((:chrp_topology_remove_bond,libchemharp),Cint,(Ptr{CHRP_TOPOLOGY},Csize_t,Csize_t),topology,i,j)
end

function chrp_topology_free(topology::Ptr{CHRP_TOPOLOGY})
    ccall((:chrp_topology_free,libchemharp),Cint,(Ptr{CHRP_TOPOLOGY},),topology)
end

function chrp_atom(name::Ptr{Uint8})
    ccall((:chrp_atom,libchemharp),Ptr{CHRP_ATOM},(Ptr{Uint8},),name)
end

function chrp_atom_from_frame(frame::Ptr{CHRP_FRAME},idx::Csize_t)
    ccall((:chrp_atom_from_frame,libchemharp),Ptr{CHRP_ATOM},(Ptr{CHRP_FRAME},Csize_t),frame,idx)
end

function chrp_atom_from_topology(topology::Ptr{CHRP_TOPOLOGY},idx::Csize_t)
    ccall((:chrp_atom_from_topology,libchemharp),Ptr{CHRP_ATOM},(Ptr{CHRP_TOPOLOGY},Csize_t),topology,idx)
end

function chrp_atom_mass(atom::Ptr{CHRP_ATOM},mass::Ptr{Cfloat})
    ccall((:chrp_atom_mass,libchemharp),Cint,(Ptr{CHRP_ATOM},Ptr{Cfloat}),atom,mass)
end

function chrp_atom_mass_set(atom::Ptr{CHRP_ATOM},mass::Cfloat)
    ccall((:chrp_atom_mass_set,libchemharp),Cint,(Ptr{CHRP_ATOM},Cfloat),atom,mass)
end

function chrp_atom_charge(atom::Ptr{CHRP_ATOM},charge::Ptr{Cfloat})
    ccall((:chrp_atom_charge,libchemharp),Cint,(Ptr{CHRP_ATOM},Ptr{Cfloat}),atom,charge)
end

function chrp_atom_charge_set(atom::Ptr{CHRP_ATOM},charge::Cfloat)
    ccall((:chrp_atom_charge_set,libchemharp),Cint,(Ptr{CHRP_ATOM},Cfloat),atom,charge)
end

function chrp_atom_name(atom::Ptr{CHRP_ATOM},name::Ptr{Uint8},buffsize::Csize_t)
    ccall((:chrp_atom_name,libchemharp),Cint,(Ptr{CHRP_ATOM},Ptr{Uint8},Csize_t),atom,name,buffsize)
end

function chrp_atom_name_set(atom::Ptr{CHRP_ATOM},name::Ptr{Uint8})
    ccall((:chrp_atom_name_set,libchemharp),Cint,(Ptr{CHRP_ATOM},Ptr{Uint8}),atom,name)
end

function chrp_atom_full_name(atom::Ptr{CHRP_ATOM},name::Ptr{Uint8},buffsize::Csize_t)
    ccall((:chrp_atom_full_name,libchemharp),Cint,(Ptr{CHRP_ATOM},Ptr{Uint8},Csize_t),atom,name,buffsize)
end

function chrp_atom_vdw_radius(atom::Ptr{CHRP_ATOM},radius::Ptr{Cdouble})
    ccall((:chrp_atom_vdw_radius,libchemharp),Cint,(Ptr{CHRP_ATOM},Ptr{Cdouble}),atom,radius)
end

function chrp_atom_covalent_radius(atom::Ptr{CHRP_ATOM},radius::Ptr{Cdouble})
    ccall((:chrp_atom_covalent_radius,libchemharp),Cint,(Ptr{CHRP_ATOM},Ptr{Cdouble}),atom,radius)
end

function chrp_atom_atomic_number(atom::Ptr{CHRP_ATOM},number::Ptr{Cint})
    ccall((:chrp_atom_atomic_number,libchemharp),Cint,(Ptr{CHRP_ATOM},Ptr{Cint}),atom,number)
end

function chrp_atom_free(atom::Ptr{CHRP_ATOM})
    ccall((:chrp_atom_free,libchemharp),Cint,(Ptr{CHRP_ATOM},),atom)
end
