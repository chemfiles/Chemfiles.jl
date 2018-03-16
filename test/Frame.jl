@testset "Frame type" begin
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

    @testset "Geometry tests" begin
        frame = Frame()
        add_atom!(frame, Atom(""), [0.0, 0.0, 0.0])
        add_atom!(frame, Atom(""), [1.0, 2.0, 3.0])
        @test distance(frame, 0, 1) ≈ sqrt(14.0) atol=1e-10

        frame = Frame()
        add_atom!(frame, Atom(""), [1.0, 0.0, 0.0])
        add_atom!(frame, Atom(""), [0.0, 0.0, 0.0])
        add_atom!(frame, Atom(""), [0.0, 1.0, 0.0])
        @test angle(frame, 0, 1, 2) ≈ pi/2 atol=1e-10

        frame = Frame()
        add_atom!(frame, Atom(""), [1.0, 0.0, 0.0])
        add_atom!(frame, Atom(""), [0.0, 0.0, 0.0])
        add_atom!(frame, Atom(""), [0.0, 1.0, 0.0])
        add_atom!(frame, Atom(""), [0.0, 1.0, 1.0])
        @test dihedral(frame, 0, 1, 2, 3) ≈ pi/2 atol=1e-10

        frame = Frame()
        add_atom!(frame, Atom(""), [0.0, 0.0, 0.0])
        add_atom!(frame, Atom(""), [0.0, 0.0, 2.0])
        add_atom!(frame, Atom(""), [1.0, 0.0, 0.0])
        add_atom!(frame, Atom(""), [0.0, 1.0, 0.0])
        @test out_of_plane(frame, 0, 1, 2, 3) ≈ 2 atol=1e-10
    end

    @testset "Frame add/remove bonds" begin
        frame = Frame();
        add_atom!(frame, Atom("H"), [1.0, 0.0, 0.0])
        add_atom!(frame, Atom("O"), [0.0, 0.0, 0.0])
        add_atom!(frame, Atom("H"), [0.0, 1.0, 0.0])

        add_bond!(frame, 0, 1)
        add_bond!(frame, 1, 2)

        # the bonds are actually stored inside the topology
        @test bonds(Topology(frame)) == reshape(UInt64[0,1, 1,2], (2,2))
        # angles are automaticaly computed too
        @test angles(Topology(frame)) == reshape(UInt64[0, 1, 2], (3,1))

        remove_bond!(frame, 1, 0)
        @test bonds(Topology(frame)) == reshape(UInt64[1,2], (2,1))
    end

    @testset "Frame add residues" begin
        frame = Frame()
        add_atom!(frame, Atom("Zn"), [0.0, 0.0, 0.0])
        add_atom!(frame, Atom("Fe"), [1.0, 2.0, 3.0])

        residue = Residue("first")
        add_atom!(residue,0)
        add_residue!(frame,residue)

        # residues are actually stored in the topology
        @test count_residues(Topology(frame)) == 1
    end

    @testset "Frame iteration" begin
        frame = Frame()
        add_atom!(frame, Atom(""), [0.0, 0.0, 0.0])
        add_atom!(frame, Atom(""), [0.0, 0.0, 0.0])
        add_atom!(frame, Atom(""), [0.0, 0.0, 0.0])
        add_atom!(frame, Atom(""), [0.0, 0.0, 0.0])

        count = 0
        for atom in frame
            count += 1
        end

        @test count == 4
    end
end
