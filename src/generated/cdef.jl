function chfl_strerror(status::Cint)
    ccall((:chfl_strerror, libchemfiles),Ptr{ UInt8},(Cint,),status)
end

function chfl_last_error()
    ccall((:chfl_last_error, libchemfiles),Ptr{ UInt8},())
end

function chfl_loglevel(level::LogLevel)
    ccall((:chfl_loglevel, libchemfiles),Cint,(LogLevel,),level)
end

function chfl_logfile(file::Ptr{UInt8})
    ccall((:chfl_logfile, libchemfiles),Cint,(Ptr{UInt8},),file)
end

function chfl_log_stderr()
    ccall((:chfl_log_stderr, libchemfiles),Cint,())
end

function chfl_open(filename::Ptr{UInt8},mode::Ptr{UInt8})
    ccall((:chfl_open, libchemfiles),Ptr{CHFL_TRAJECTORY},(Ptr{UInt8},Ptr{UInt8}),filename,mode)
end

function chfl_trajectory_read(file::Ptr{CHFL_TRAJECTORY},frame::Ptr{CHFL_FRAME})
    ccall((:chfl_trajectory_read, libchemfiles),Cint,(Ptr{CHFL_TRAJECTORY},Ptr{CHFL_FRAME}),file,frame)
end

function chfl_trajectory_read_step(file::Ptr{CHFL_TRAJECTORY},step::Csize_t,frame::Ptr{CHFL_FRAME})
    ccall((:chfl_trajectory_read_step, libchemfiles),Cint,(Ptr{CHFL_TRAJECTORY},Csize_t,Ptr{CHFL_FRAME}),file,step,frame)
end

function chfl_trajectory_write(file::Ptr{CHFL_TRAJECTORY},frame::Ptr{CHFL_FRAME})
    ccall((:chfl_trajectory_write, libchemfiles),Cint,(Ptr{CHFL_TRAJECTORY},Ptr{CHFL_FRAME}),file,frame)
end

function chfl_trajectory_set_topology(file::Ptr{CHFL_TRAJECTORY},topology::Ptr{CHFL_TOPOLOGY})
    ccall((:chfl_trajectory_set_topology, libchemfiles),Cint,(Ptr{CHFL_TRAJECTORY},Ptr{CHFL_TOPOLOGY}),file,topology)
end

function chfl_trajectory_set_topology_file(file::Ptr{CHFL_TRAJECTORY},filename::Ptr{ UInt8})
    ccall((:chfl_trajectory_set_topology_file, libchemfiles),Cint,(Ptr{CHFL_TRAJECTORY},Ptr{ UInt8}),file,filename)
end

function chfl_trajectory_set_cell(file::Ptr{CHFL_TRAJECTORY},cell::Ptr{CHFL_CELL})
    ccall((:chfl_trajectory_set_cell, libchemfiles),Cint,(Ptr{CHFL_TRAJECTORY},Ptr{CHFL_CELL}),file,cell)
end

function chfl_trajectory_nsteps(file::Ptr{CHFL_TRAJECTORY},nsteps::Ptr{Csize_t})
    ccall((:chfl_trajectory_nsteps, libchemfiles),Cint,(Ptr{CHFL_TRAJECTORY},Ptr{Csize_t}),file,nsteps)
end

function chfl_trajectory_close(file::Ptr{CHFL_TRAJECTORY})
    ccall((:chfl_trajectory_close, libchemfiles),Cint,(Ptr{CHFL_TRAJECTORY},),file)
end

function chfl_frame(natoms::Csize_t)
    ccall((:chfl_frame, libchemfiles),Ptr{CHFL_FRAME},(Csize_t,),natoms)
end

function chfl_frame_atoms_count(frame::Ptr{CHFL_FRAME},natoms::Ptr{Csize_t})
    ccall((:chfl_frame_atoms_count, libchemfiles),Cint,(Ptr{CHFL_FRAME},Ptr{Csize_t}),frame,natoms)
end

function chfl_frame_positions(frame::Ptr{CHFL_FRAME},data::Ptr{Cfloat},size::Csize_t)
    ccall((:chfl_frame_positions, libchemfiles),Cint,(Ptr{CHFL_FRAME},Ptr{Cfloat},Csize_t),frame,data,size)
end

function chfl_frame_set_positions(frame::Ptr{CHFL_FRAME},data::Ptr{Cfloat},size::Csize_t)
    ccall((:chfl_frame_set_positions, libchemfiles),Cint,(Ptr{CHFL_FRAME},Ptr{Cfloat},Csize_t),frame,data,size)
end

function chfl_frame_velocities(frame::Ptr{CHFL_FRAME},data::Ptr{Cfloat},size::Csize_t)
    ccall((:chfl_frame_velocities, libchemfiles),Cint,(Ptr{CHFL_FRAME},Ptr{Cfloat},Csize_t),frame,data,size)
end

function chfl_frame_set_velocities(frame::Ptr{CHFL_FRAME},data::Ptr{Cfloat},size::Csize_t)
    ccall((:chfl_frame_set_velocities, libchemfiles),Cint,(Ptr{CHFL_FRAME},Ptr{Cfloat},Csize_t),frame,data,size)
end

function chfl_frame_has_velocities(frame::Ptr{CHFL_FRAME},has_vel::Ptr{Bool})
    ccall((:chfl_frame_has_velocities, libchemfiles),Cint,(Ptr{CHFL_FRAME},Ptr{Bool}),frame,has_vel)
end

function chfl_frame_set_cell(frame::Ptr{CHFL_FRAME},cell::Ptr{CHFL_CELL})
    ccall((:chfl_frame_set_cell, libchemfiles),Cint,(Ptr{CHFL_FRAME},Ptr{CHFL_CELL}),frame,cell)
end

function chfl_frame_set_topology(frame::Ptr{CHFL_FRAME},topology::Ptr{CHFL_TOPOLOGY})
    ccall((:chfl_frame_set_topology, libchemfiles),Cint,(Ptr{CHFL_FRAME},Ptr{CHFL_TOPOLOGY}),frame,topology)
end

function chfl_frame_step(frame::Ptr{CHFL_FRAME},step::Ptr{Csize_t})
    ccall((:chfl_frame_step, libchemfiles),Cint,(Ptr{CHFL_FRAME},Ptr{Csize_t}),frame,step)
end

function chfl_frame_set_step(frame::Ptr{CHFL_FRAME},step::Csize_t)
    ccall((:chfl_frame_set_step, libchemfiles),Cint,(Ptr{CHFL_FRAME},Csize_t),frame,step)
end

function chfl_frame_guess_topology(frame::Ptr{CHFL_FRAME},bonds::Bool)
    ccall((:chfl_frame_guess_topology, libchemfiles),Cint,(Ptr{CHFL_FRAME},Bool),frame,bonds)
end

function chfl_frame_free(frame::Ptr{CHFL_FRAME})
    ccall((:chfl_frame_free, libchemfiles),Cint,(Ptr{CHFL_FRAME},),frame)
end

function chfl_cell(a::Cdouble,b::Cdouble,c::Cdouble,alpha::Cdouble,beta::Cdouble,gamma::Cdouble)
    ccall((:chfl_cell, libchemfiles),Ptr{CHFL_CELL},(Cdouble,Cdouble,Cdouble,Cdouble,Cdouble,Cdouble),a,b,c,alpha,beta,gamma)
end

function chfl_cell_from_frame(frame::Ptr{CHFL_FRAME})
    ccall((:chfl_cell_from_frame, libchemfiles),Ptr{CHFL_CELL},(Ptr{CHFL_FRAME},),frame)
end

function chfl_cell_volume(cell::Ptr{CHFL_CELL},V::Ptr{Cdouble})
    ccall((:chfl_cell_volume, libchemfiles),Cint,(Ptr{CHFL_CELL},Ptr{Cdouble}),cell,V)
end

function chfl_cell_lengths(cell::Ptr{CHFL_CELL},a::Ptr{Cdouble},b::Ptr{Cdouble},c::Ptr{Cdouble})
    ccall((:chfl_cell_lengths, libchemfiles),Cint,(Ptr{CHFL_CELL},Ptr{Cdouble},Ptr{Cdouble},Ptr{Cdouble}),cell,a,b,c)
end

function chfl_cell_set_lengths(cell::Ptr{CHFL_CELL},a::Cdouble,b::Cdouble,c::Cdouble)
    ccall((:chfl_cell_set_lengths, libchemfiles),Cint,(Ptr{CHFL_CELL},Cdouble,Cdouble,Cdouble),cell,a,b,c)
end

function chfl_cell_angles(cell::Ptr{CHFL_CELL},alpha::Ptr{Cdouble},beta::Ptr{Cdouble},gamma::Ptr{Cdouble})
    ccall((:chfl_cell_angles, libchemfiles),Cint,(Ptr{CHFL_CELL},Ptr{Cdouble},Ptr{Cdouble},Ptr{Cdouble}),cell,alpha,beta,gamma)
end

function chfl_cell_set_angles(cell::Ptr{CHFL_CELL},alpha::Cdouble,beta::Cdouble,gamma::Cdouble)
    ccall((:chfl_cell_set_angles, libchemfiles),Cint,(Ptr{CHFL_CELL},Cdouble,Cdouble,Cdouble),cell,alpha,beta,gamma)
end

function chfl_cell_matrix(cell::Ptr{CHFL_CELL},mat::Ptr{Cdouble})
    ccall((:chfl_cell_matrix, libchemfiles),Cint,(Ptr{CHFL_CELL},Ptr{Cdouble}),cell,mat)
end

function chfl_cell_type(cell::Ptr{CHFL_CELL},_type::Ptr{CellType})
    ccall((:chfl_cell_type, libchemfiles),Cint,(Ptr{CHFL_CELL},Ptr{CellType}),cell,_type)
end

function chfl_cell_set_type(cell::Ptr{CHFL_CELL},_type::CellType)
    ccall((:chfl_cell_set_type, libchemfiles),Cint,(Ptr{CHFL_CELL},CellType),cell,_type)
end

function chfl_cell_periodicity(cell::Ptr{CHFL_CELL},x::Ptr{Bool},y::Ptr{Bool},z::Ptr{Bool})
    ccall((:chfl_cell_periodicity, libchemfiles),Cint,(Ptr{CHFL_CELL},Ptr{Bool},Ptr{Bool},Ptr{Bool}),cell,x,y,z)
end

function chfl_cell_set_periodicity(cell::Ptr{CHFL_CELL},x::Bool,y::Bool,z::Bool)
    ccall((:chfl_cell_set_periodicity, libchemfiles),Cint,(Ptr{CHFL_CELL},Bool,Bool,Bool),cell,x,y,z)
end

function chfl_cell_free(cell::Ptr{CHFL_CELL})
    ccall((:chfl_cell_free, libchemfiles),Cint,(Ptr{CHFL_CELL},),cell)
end

function chfl_topology()
    ccall((:chfl_topology, libchemfiles),Ptr{CHFL_TOPOLOGY},())
end

function chfl_topology_from_frame(frame::Ptr{CHFL_FRAME})
    ccall((:chfl_topology_from_frame, libchemfiles),Ptr{CHFL_TOPOLOGY},(Ptr{CHFL_FRAME},),frame)
end

function chfl_topology_atoms_count(topology::Ptr{CHFL_TOPOLOGY},natoms::Ptr{Csize_t})
    ccall((:chfl_topology_atoms_count, libchemfiles),Cint,(Ptr{CHFL_TOPOLOGY},Ptr{Csize_t}),topology,natoms)
end

function chfl_topology_append(topology::Ptr{CHFL_TOPOLOGY},atom::Ptr{CHFL_ATOM})
    ccall((:chfl_topology_append, libchemfiles),Cint,(Ptr{CHFL_TOPOLOGY},Ptr{CHFL_ATOM}),topology,atom)
end

function chfl_topology_remove(topology::Ptr{CHFL_TOPOLOGY},i::Csize_t)
    ccall((:chfl_topology_remove, libchemfiles),Cint,(Ptr{CHFL_TOPOLOGY},Csize_t),topology,i)
end

function chfl_topology_isbond(topology::Ptr{CHFL_TOPOLOGY},i::Csize_t,j::Csize_t,result::Ptr{Bool})
    ccall((:chfl_topology_isbond, libchemfiles),Cint,(Ptr{CHFL_TOPOLOGY},Csize_t,Csize_t,Ptr{Bool}),topology,i,j,result)
end

function chfl_topology_isangle(topology::Ptr{CHFL_TOPOLOGY},i::Csize_t,j::Csize_t,k::Csize_t,result::Ptr{Bool})
    ccall((:chfl_topology_isangle, libchemfiles),Cint,(Ptr{CHFL_TOPOLOGY},Csize_t,Csize_t,Csize_t,Ptr{Bool}),topology,i,j,k,result)
end

function chfl_topology_isdihedral(topology::Ptr{CHFL_TOPOLOGY},i::Csize_t,j::Csize_t,k::Csize_t,m::Csize_t,result::Ptr{Bool})
    ccall((:chfl_topology_isdihedral, libchemfiles),Cint,(Ptr{CHFL_TOPOLOGY},Csize_t,Csize_t,Csize_t,Csize_t,Ptr{Bool}),topology,i,j,k,m,result)
end

function chfl_topology_bonds_count(topology::Ptr{CHFL_TOPOLOGY},nbonds::Ptr{Csize_t})
    ccall((:chfl_topology_bonds_count, libchemfiles),Cint,(Ptr{CHFL_TOPOLOGY},Ptr{Csize_t}),topology,nbonds)
end

function chfl_topology_angles_count(topology::Ptr{CHFL_TOPOLOGY},nangles::Ptr{Csize_t})
    ccall((:chfl_topology_angles_count, libchemfiles),Cint,(Ptr{CHFL_TOPOLOGY},Ptr{Csize_t}),topology,nangles)
end

function chfl_topology_dihedrals_count(topology::Ptr{CHFL_TOPOLOGY},ndihedrals::Ptr{Csize_t})
    ccall((:chfl_topology_dihedrals_count, libchemfiles),Cint,(Ptr{CHFL_TOPOLOGY},Ptr{Csize_t}),topology,ndihedrals)
end

function chfl_topology_bonds(topology::Ptr{CHFL_TOPOLOGY},data::Ptr{Csize_t},nbonds::Csize_t)
    ccall((:chfl_topology_bonds, libchemfiles),Cint,(Ptr{CHFL_TOPOLOGY},Ptr{Csize_t},Csize_t),topology,data,nbonds)
end

function chfl_topology_angles(topology::Ptr{CHFL_TOPOLOGY},data::Ptr{Csize_t},nangles::Csize_t)
    ccall((:chfl_topology_angles, libchemfiles),Cint,(Ptr{CHFL_TOPOLOGY},Ptr{Csize_t},Csize_t),topology,data,nangles)
end

function chfl_topology_dihedrals(topology::Ptr{CHFL_TOPOLOGY},data::Ptr{Csize_t},ndihedrals::Csize_t)
    ccall((:chfl_topology_dihedrals, libchemfiles),Cint,(Ptr{CHFL_TOPOLOGY},Ptr{Csize_t},Csize_t),topology,data,ndihedrals)
end

function chfl_topology_add_bond(topology::Ptr{CHFL_TOPOLOGY},i::Csize_t,j::Csize_t)
    ccall((:chfl_topology_add_bond, libchemfiles),Cint,(Ptr{CHFL_TOPOLOGY},Csize_t,Csize_t),topology,i,j)
end

function chfl_topology_remove_bond(topology::Ptr{CHFL_TOPOLOGY},i::Csize_t,j::Csize_t)
    ccall((:chfl_topology_remove_bond, libchemfiles),Cint,(Ptr{CHFL_TOPOLOGY},Csize_t,Csize_t),topology,i,j)
end

function chfl_topology_free(topology::Ptr{CHFL_TOPOLOGY})
    ccall((:chfl_topology_free, libchemfiles),Cint,(Ptr{CHFL_TOPOLOGY},),topology)
end

function chfl_atom(name::Ptr{ UInt8})
    ccall((:chfl_atom, libchemfiles),Ptr{CHFL_ATOM},(Ptr{ UInt8},),name)
end

function chfl_atom_from_frame(frame::Ptr{CHFL_FRAME},idx::Csize_t)
    ccall((:chfl_atom_from_frame, libchemfiles),Ptr{CHFL_ATOM},(Ptr{CHFL_FRAME},Csize_t),frame,idx)
end

function chfl_atom_from_topology(topology::Ptr{CHFL_TOPOLOGY},idx::Csize_t)
    ccall((:chfl_atom_from_topology, libchemfiles),Ptr{CHFL_ATOM},(Ptr{CHFL_TOPOLOGY},Csize_t),topology,idx)
end

function chfl_atom_mass(atom::Ptr{CHFL_ATOM},mass::Ptr{Cfloat})
    ccall((:chfl_atom_mass, libchemfiles),Cint,(Ptr{CHFL_ATOM},Ptr{Cfloat}),atom,mass)
end

function chfl_atom_set_mass(atom::Ptr{CHFL_ATOM},mass::Cfloat)
    ccall((:chfl_atom_set_mass, libchemfiles),Cint,(Ptr{CHFL_ATOM},Cfloat),atom,mass)
end

function chfl_atom_charge(atom::Ptr{CHFL_ATOM},charge::Ptr{Cfloat})
    ccall((:chfl_atom_charge, libchemfiles),Cint,(Ptr{CHFL_ATOM},Ptr{Cfloat}),atom,charge)
end

function chfl_atom_set_charge(atom::Ptr{CHFL_ATOM},charge::Cfloat)
    ccall((:chfl_atom_set_charge, libchemfiles),Cint,(Ptr{CHFL_ATOM},Cfloat),atom,charge)
end

function chfl_atom_name(atom::Ptr{CHFL_ATOM},name::Ptr{ UInt8},buffsize::Csize_t)
    ccall((:chfl_atom_name, libchemfiles),Cint,(Ptr{CHFL_ATOM},Ptr{ UInt8},Csize_t),atom,name,buffsize)
end

function chfl_atom_set_name(atom::Ptr{CHFL_ATOM},name::Ptr{ UInt8})
    ccall((:chfl_atom_set_name, libchemfiles),Cint,(Ptr{CHFL_ATOM},Ptr{ UInt8}),atom,name)
end

function chfl_atom_full_name(atom::Ptr{CHFL_ATOM},name::Ptr{ UInt8},buffsize::Csize_t)
    ccall((:chfl_atom_full_name, libchemfiles),Cint,(Ptr{CHFL_ATOM},Ptr{ UInt8},Csize_t),atom,name,buffsize)
end

function chfl_atom_vdw_radius(atom::Ptr{CHFL_ATOM},radius::Ptr{Cdouble})
    ccall((:chfl_atom_vdw_radius, libchemfiles),Cint,(Ptr{CHFL_ATOM},Ptr{Cdouble}),atom,radius)
end

function chfl_atom_covalent_radius(atom::Ptr{CHFL_ATOM},radius::Ptr{Cdouble})
    ccall((:chfl_atom_covalent_radius, libchemfiles),Cint,(Ptr{CHFL_ATOM},Ptr{Cdouble}),atom,radius)
end

function chfl_atom_atomic_number(atom::Ptr{CHFL_ATOM},number::Ptr{Cint})
    ccall((:chfl_atom_atomic_number, libchemfiles),Cint,(Ptr{CHFL_ATOM},Ptr{Cint}),atom,number)
end

function chfl_atom_free(atom::Ptr{CHFL_ATOM})
    ccall((:chfl_atom_free, libchemfiles),Cint,(Ptr{CHFL_ATOM},),atom)
end
