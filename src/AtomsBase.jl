function position(frame::Frame)
    cf_pos = positions(frame)
    ab_pos = [cf_pos[:,i] for i in 1:size(cf_pos,2)]
    return ab_pos
end

position(frame::Frame, index) = position(frame)[index] 

function velocity(frame::Frame)
    cf_vel = velocities(frame)
    ab_vel = [cf_vel[:,i] for i in 1:size(cf_vel,2)]
    return ab_vel
end

velocity(frame::Frame, index) = velocity(frame)[index]

bounding_box(frame::Frame) = collect.(eachrow(matrix(UnitCell(frame))))
boundary_conditions(frame::Frame) = shape(UnitCell(frame)) == Chemfiles.Infinite ? [DirichletZero(), DirichletZero(), DirichletZero()] : [Periodic(), Periodic(), Periodic()] 
periodicity(frame::Frame) = shape(UnitCell(frame)) == Chemfiles.Infinite ? [false, false, false] : [true, true, true]

n_dimensions(frame::Frame) = 3

species_type(frame::Frame) = Chemfiles.Atom

atomic_mass(frame::Frame) = mass.(frame)
atomic_mass(frame::Frame, index) = mass(Atom(frame, index))

atomic_symbol(frame::Frame) = Symbol.(type.(frame))
atomic_symbol(frame::Frame, index) = Symbol(type(Atom(frame, index)))

atomic_number(frame::Frame) = atomic_number.(frame)
atomic_number(frame::Frame, index) = atomic_number(Atom(frame, index))