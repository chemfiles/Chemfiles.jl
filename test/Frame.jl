
facts("Frame type") do
    frame = Frame()
    @fact size(frame) => 0

    frame = Frame(4)
    @fact size(frame) => 4

    pos = Array(Float32, 3, 4)
    for i=1:3, j=1:4
        pos[i, j] = i*j
    end
    set_positions!(frame, pos)
    @fact positions(frame) => pos

    @fact has_velocities(frame) => false

    set_velocities!(frame, pos)
    @fact velocities(frame) => pos

    @fact has_velocities(frame) => true

    # set_cell!(frame, cell)
    # set_topology!(frame, topology)

    @fact step(frame) => 0
    set_step!(frame, 42)
    @fact step(frame) => 42

    # guess_topology!(frame)
end
