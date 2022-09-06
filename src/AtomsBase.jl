identity(obj) = obj

function position(frame::Frame)
    cf_pos = positions(frame)
    ab_pos = [cf_pos[:,i] for i in 1:size(cf_pos,2)]
    return ab_pos
end

position(frame::Frame, index) = position(frame)[index] 

function velocity(frame::Frame)
    cf_vel = positions(frame)
    ab_vel = [cf_vel[:,i] for i in 1:size(cf_vel,2)]
    return ab_pos
end

velocity(frame::Frame, index) = velocity(frame)[index]

function atomic_mass(frame::Frame)
end

function atomic_mass(frame::Frame, index)
end

function atomic_symbol(frame::Frame)
end

function atomic_symbol(frame::Frame, index)
end

#atomic_number(frame::Frame) = atomic_number.(frame, 0:length(frame)-1)
atomic_number(frame::Frame, index) = atomic_number(Atom(frame, index))
