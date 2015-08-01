
facts("Frame type") do
    frame = Frame()
    @fact size(frame) --> 0

    frame = Frame(4)
    @fact size(frame) --> 4

    pos = Array(Float32, 3, 4)
    for i=1:3, j=1:4
        pos[i, j] = i*j
    end
    set_positions!(frame, pos)
    @fact positions(frame) --> pos

    @fact has_velocities(frame) --> false

    set_velocities!(frame, pos)
    @fact velocities(frame) --> pos

    @fact has_velocities(frame) --> true

    set_cell!(frame, UnitCell(3, 4, 5))
    cell = UnitCell(frame)
    @fact lengths(cell) --> (3.0, 4.0, 5.0)

    top = Topology()
    push!(top, Atom("Zn"))
    push!(top, Atom("Ar"))
    set_topology!(frame, top)
    new_top = Topology(frame)

    @fact name(Atom(new_top, 0)) --> "Zn"
    @fact name(Atom(new_top, 1)) --> "Ar"

    @fact step(frame) --> 0
    set_step!(frame, 42)
    @fact step(frame) --> 42
end
