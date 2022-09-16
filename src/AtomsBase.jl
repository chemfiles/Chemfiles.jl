#export position, velocity, bounding_box, boundary_conditions, periodicity
#export n_dimensions, species_type, atomic_mass, atomic_symbol, atomic_number

#TODO Eigene Markdown Erklärung D:

import AtomsBase: velocity

"""
    position(frame::Frame)
    position(frame::Frame, index)

This function is part of the AtomsBase.jl interface

Return a vector of positions of every particle in the system `frame`. Return type
should be a vector of vectors each containing `3` elements that are
`<:Unitful.Length`. If an index is passed or the action is on an `Atom`,
return only the position of the referenced `Atom` on that index.
"""
function position(frame::Frame)
    cf_pos = positions(frame)
    ab_pos = [cf_pos[:,i] for i in 1:size(cf_pos,2)]*u"Å"
    return ab_pos
end
position(frame::Frame, index) = position(frame)[index] 
#TODO
position(atom::Atom) = [0, 0, 0]

"""
    velocity(frame::Frame)
    velocity(frame::Frame, index)

This function is part of the AtomsBase.jl interface

Return a vector of velocities of every particle in the system `frame`. Return
type should be a vector of vectors each containing `3` elements that are
`<:Unitful.Velocity`. If an index is passed or the action is on an `Atom`,
return only the velocity of the referenced `Atom`. Returned value of the function
may be `missing`.
"""
function velocity(frame::Frame)
    if has_velocities(frame)
        cf_vel = velocities(frame)
        ab_vel = [cf_vel[:,i] for i in 1:size(cf_vel,2)]*u"Å/ps"
        return ab_vel
    else
        return missing
    end
end
velocity(frame::Frame, index) = velocity(frame)[index]
#TODO
velocity(atom::Atom) = missing

"""
    bounding_box(frame::Frame)

This function is part of the AtomsBase.jl interface

Return a vector of length `3` of vectors of length `3` that describe the "box" in which the system `frame` is defined.
"""
bounding_box(frame::Frame) = collect.(eachrow(matrix(UnitCell(frame))))*u"Å"

"""
    boundary_conditions(farme::Frame)

This function is part of the AtomsBase.jl interface

Return a vector of length `3` of `BoundaryCondition` objects, one for each direction described by `bounding_box(sys)`.
"""
boundary_conditions(frame::Frame) = shape(UnitCell(frame)) == Chemfiles.Infinite ? [DirichletZero(), DirichletZero(), DirichletZero()] : [Periodic(), Periodic(), Periodic()] 

"""
This function is part of the AtomsBase.jl interface

Return vector indicating whether the system is periodic along a dimension.
"""
periodicity(frame::Frame) = shape(UnitCell(frame)) == Chemfiles.Infinite ? [false, false, false] : [true, true, true]

"""
    n_dimensions(::AbstractSystem)
    n_dimensions(atom)

This function is part of the AtomsBase.jl interface

Return number of dimensions, which is always 3 for every frame.
"""
n_dimensions(frame::Frame) = 3
n_dimensions(atom::Atom) = 3

"""
    species_type(frame::Frame)

This function is part of the AtomsBase.jl interface

Return the type used to represent a species or atom, which is always Chemfiles.Atom.
"""
species_type(frame::Frame) = Chemfiles.Atom

"""
    atomic_mass(frame::Frame)
    atomic_mass(frame::Frame, index)

This function is part of the AtomsBase.jl interface

Vector of atomic masses in the system `frame` or the atomic mass of a particular `Atom` /
the `index`th species in `frame`. The elements are `<: Unitful.Mass`.
"""
atomic_mass(frame::Frame) = mass.(frame)*u"u"
atomic_mass(frame::Frame, index) = mass(Atom(frame, index))*u"u"
atomic_mass(atom::Atom) = mass(atom)*u"u"

"""
    atomic_symbol(frame::Frame)
    atomic_symbol(frame::Frame, index)

This function is part of the AtomsBase.jl interface

Vector of atomic symbols in the system `sys` or the atomic symbol of a particular `Atom` /
the `index`th species in `frame`.
"""
atomic_symbol(frame::Frame) = Symbol.(type.(frame))
atomic_symbol(frame::Frame, index) = Symbol(type(Atom(frame, index)))
atomic_symbol(atom::Atom) = Symbol(type(atom))

element(atom::Atom) = elements[atomic_symbol(atom)]

"""
    atomic_number(frame::Frame)
    atomic_number(frame::Frame, index)

This function is part of the AtomsBase.jl interface

Vector of atomic numbers in the system `frNW` or the atomic number of a particular `aTOM` /
the `index`th species in `frame`.
"""
atomic_number(frame::Frame) = atomic_number.(frame)
atomic_number(frame::Frame, index) = atomic_number(Atom(frame, index))
#atomic_number(atom::Atom) already implemented by Chemfiles
