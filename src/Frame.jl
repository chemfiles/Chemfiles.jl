export positions, positions!, set_positions!, velocities, velocities!, set_velocities,
       has_velocities, set_cell!, set_topology!, set_step!, guess_topology!

function Frame(natoms::Integer = 0)
    handle = lib.chrp_frame(Csize_t(natoms))
    if Int(handle) == 0
        throw(ChemharpError("Error while creating Frame"))
    end
    return Frame(handle)
end

function free(frame::Frame)
    lib.chrp_frame_free(frame.handle)
end

function Base.size(frame::Frame)
    n = Csize_t[0]
    check(
        lib.chrp_frame_size(frame.handle, pointer(n))
    )
    return n[1]
end

function positions(frame::Frame)
    natoms = size(frame)
    data = Array(Cfloat, 3, natoms)
    return positions!(frame, data)
end

function positions!(frame::Frame, data::Array{Float32, 2})
    check(
        lib.chrp_frame_positions(frame.handle, pointer(data), size(data, 2))
    )
    return data
end

function set_positions!(frame::Frame, data::Array{Float32, 2})
    check(
        lib.chrp_frame_positions_set(frame.handle, pointer(data), size(data, 2))
    )
    return nothing
end

function velocities(frame::Frame)
    natoms = size(frame)
    data = Array(Cfloat, 3, natoms)
    return velocities!(frame, data)
end

function velocities!(frame::Frame, data::Array{Float32, 2})
    check(
        lib.chrp_frame_velocities(frame.handle, pointer(data), size(data, 2))
    )
    return data
end

function set_velocities!(frame::Frame, data::Array{Float32, 2})
    check(
        lib.chrp_frame_velocities_set(frame.handle, pointer(data), size(data, 2))
    )
    return nothing
end

function has_velocities(frame::Frame)
    res = Bool[false]
    check(
        lib.chrp_frame_has_velocities(frame.handle, pointer(res))
    )
    return res[1]
end

function set_cell!(frame::Frame, cell::UnitCell)
    check(
        lib.chrp_frame_cell_set(frame.handle, cell.handle)
    )
    return nothing
end

function set_topology!(frame::Frame, topology::Topology)
    check(
        lib.chrp_frame_cell_set(frame.handle, topology.handle)
    )
    return nothing
end

function Base.step(frame::Frame)
    res = Csize_t[0]
    check(
        lib.chrp_frame_step(frame.handle, pointer(res))
    )
    return res[1]
end

function set_step!(frame::Frame, step::Integer)
    check(
        lib.chrp_frame_step_set(frame.handle, Csize_t(step))
    )
    return nothing
end

function guess_topology!(frame::Frame, bonds::Bool=true)
    check(
        lib.chrp_frame_guess_topology(frame.handle, bonds)
    )
    return nothing
end
