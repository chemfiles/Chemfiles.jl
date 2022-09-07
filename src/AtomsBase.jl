abstract type BoundaryCondition end
struct DirichletZero <: BoundaryCondition end  # Dirichlet zero boundary (i.e. molecular context)
struct Periodic <: BoundaryCondition end  # Periodic BCs

bounding_box(frame::Frame) = collect.(eachrow(UnitCell(frame)))

boundary_conditions(frame::Frame) = shape(UnitCell(frame)) == Chemfiles.Infinite ? [DirichletZero(), DirichletZero(), DirichletZero()] : [Periodic(), Periodic(), Periodic()] 

#???
function periodicity end

n_dimensions(frame::Frame) = 3

#???
function species_type end

#???
function element end

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

atomic_mass(frame::Frame) = mass.(frame)
atomic_mass(frame::Frame, index) = mass(Atom(frame, index))

atomic_symbol(frame::Frame) = Symbol.(type.(frame))
atomic_symbol(frame::Frame, index) = Symbol(type(Atom(frame, index)))
 

atomic_number(frame::Frame) = atomic_number.(frame)
atomic_number(frame::Frame, index) = atomic_number(Atom(frame, index))
