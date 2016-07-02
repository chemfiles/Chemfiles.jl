
facts("Frame type") do
    frame = Frame()
    @fact size(frame) --> 0

    frame = Frame(4)
    @fact size(frame) --> 4

    pos = positions(frame)
    expected = Array(Float32, 3, 4)
    for i=1:3, j=1:4
        pos[i, j] = i*j
        expected[i, j] = i*j
    end
    @fact positions(frame) --> expected

    @fact has_velocities(frame) --> false
    add_velocities!(frame)
    @fact has_velocities(frame) --> true

    vel = velocities(frame)
    for i=1:3, j=1:4
        vel[i, j] = i*j
    end
    @fact velocities(frame) --> expected

    set_cell!(frame, UnitCell(3, 4, 5))
    cell = UnitCell(frame)
    @fact lengths(cell) --> (3.0, 4.0, 5.0)

    top = Topology()
    push!(top, Atom("H"))
    push!(top, Atom("O"))
    push!(top, Atom("Zn"))
    push!(top, Atom("H"))
    set_topology!(frame, top)
    new_top = Topology(frame)

    @fact name(Atom(new_top, 0)) --> "H"
    @fact name(Atom(new_top, 2)) --> "Zn"

    @fact step(frame) --> 0
    set_step!(frame, 42)
    @fact step(frame) --> 42
end
