@testset "Frame Type" begin
    frame = Frame()
    @test size(frame) == 0

    resize!(frame, 4)
    @test size(frame) == 4

    pos = positions(frame)
    expected = Array{Float64}(3, 4)
    for i=1:3, j=1:4
        pos[i, j] = i*j
        expected[i, j] = i*j
    end
    @test positions(frame) == expected

    @test has_velocities(frame) == false
    add_velocities!(frame)
    @test has_velocities(frame) == true

    vel = velocities(frame)
    for i=1:3, j=1:4
        vel[i, j] = i*j
    end
    @test velocities(frame) == expected

    set_cell!(frame, UnitCell(3, 4, 5))
    cell = UnitCell(frame)
    @test lengths(cell) == [3.0, 4.0, 5.0]

    topology = Topology()
    add_atom!(topology, Atom("H"))
    add_atom!(topology, Atom("O"))
    add_atom!(topology, Atom("Zn"))
    add_atom!(topology, Atom("H"))
    set_topology!(frame, topology)
    new_topology = Topology(frame)

    @test name(Atom(new_topology, 0)) == "H"
    @test name(Atom(new_topology, 2)) == "Zn"

    @test step(frame) == 0
    set_step!(frame, 42)
    @test step(frame) == 42

    @test size(frame) == 4

    position = Float64[0.2, 0.8, 0]
    velocity = Float64[1, 2, 1]
    add_atom!(frame, Atom("H"), position, velocity)
    @test size(frame) == 5

    remove_atom!(frame, 4)
    @test size(frame) == 4

    copy = deepcopy(frame)
    @test size(copy) == 4

    resize!(copy, 10)
    @test size(copy) == 10
    @test size(frame) == 4
end
