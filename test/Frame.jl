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

    top = Topology()
    push!(top, Atom("H"))
    push!(top, Atom("O"))
    push!(top, Atom("Zn"))
    push!(top, Atom("H"))
    set_topology!(frame, top)
    new_top = Topology(frame)

    @test name(Atom(new_top, 0)) == "H"
    @test name(Atom(new_top, 2)) == "Zn"

    @test step(frame) == 0
    set_step!(frame, 42)
    @test step(frame) == 42
end
