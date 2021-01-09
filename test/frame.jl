@testset "Frame" begin
    @testset "Basic usage" begin
        frame = Frame()
        @test size(frame) == 0

        resize!(frame, 4)
        @test size(frame) == 4
        @test length(frame) == 4

        pos = positions(frame)
        expected = Array{Float64}(undef, 3, 4)
        for i in 1:3, j in 1:4
            pos[i, j] = i * j
            expected[i, j] = i * j
        end
        @test positions(frame) == expected

        @test has_velocities(frame) == false
        add_velocities!(frame)
        @test has_velocities(frame) == true

        vel = velocities(frame)
        for i in 1:3, j in 1:4
            vel[i, j] = i * j
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

        @test name(Atom(frame, 0)) == "H"
        @test name(Atom(frame, 2)) == "Zn"

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
    end

    @testset "Frame copy" begin
        frame = Frame()
        @test size(frame) == 0

        resize!(frame, 4)
        @test size(frame) == 4

        copy = deepcopy(frame)
        @test size(copy) == 4

        resize!(copy, 10)
        @test size(copy) == 10
        @test size(frame) == 4
    end

    @testset "Geometry tests" begin
        frame = Frame()
        add_atom!(frame, Atom(""), [0.0, 0.0, 0.0])
        add_atom!(frame, Atom(""), [1.0, 2.0, 3.0])
        @test distance(frame, 0, 1) ≈ sqrt(14.0) atol = 1e-10

        frame = Frame()
        add_atom!(frame, Atom(""), [1.0, 0.0, 0.0])
        add_atom!(frame, Atom(""), [0.0, 0.0, 0.0])
        add_atom!(frame, Atom(""), [0.0, 1.0, 0.0])
        @test angle(frame, 0, 1, 2) ≈ pi / 2 atol = 1e-10

        frame = Frame()
        add_atom!(frame, Atom(""), [1.0, 0.0, 0.0])
        add_atom!(frame, Atom(""), [0.0, 0.0, 0.0])
        add_atom!(frame, Atom(""), [0.0, 1.0, 0.0])
        add_atom!(frame, Atom(""), [0.0, 1.0, 1.0])
        @test dihedral(frame, 0, 1, 2, 3) ≈ pi / 2 atol = 1e-10

        frame = Frame()
        add_atom!(frame, Atom(""), [0.0, 0.0, 0.0])
        add_atom!(frame, Atom(""), [0.0, 0.0, 2.0])
        add_atom!(frame, Atom(""), [1.0, 0.0, 0.0])
        add_atom!(frame, Atom(""), [0.0, 1.0, 0.0])
        @test out_of_plane(frame, 0, 1, 2, 3) ≈ 2 atol = 1e-10
    end

    @testset "Frame add/remove bonds" begin
        frame = Frame();
        add_atom!(frame, Atom("H"), [1.0, 0.0, 0.0])
        add_atom!(frame, Atom("O"), [0.0, 0.0, 0.0])
        add_atom!(frame, Atom("H"), [0.0, 1.0, 0.0])

        add_bond!(frame, 0, 1)
        add_bond!(frame, 1, 2, Chemfiles.TripleBond)

        # the bonds are actually stored inside the topology
        topology = Topology(frame)

        @test bonds(topology) == reshape(UInt64[0, 1, 1, 2], (2, 2))
        @test angles(topology) == reshape(UInt64[0, 1, 2], (3, 1))

        @test bond_order(topology, 0, 1) == Chemfiles.UnknownBond
        @test bond_order(topology, 1, 2) == Chemfiles.TripleBond

        remove_bond!(frame, 1, 0)
        @test bonds(Topology(frame)) == reshape(UInt64[1, 2], (2, 1))

        @test bonds_count(Topology(frame)) == 1
        clear_bonds!(frame)
        @test bonds_count(Topology(frame)) == 0
    end

    @testset "Frame add residues" begin
        frame = Frame()
        add_atom!(frame, Atom("Zn"), [0.0, 0.0, 0.0])
        add_atom!(frame, Atom("Fe"), [1.0, 2.0, 3.0])

        residue = Residue("first")
        add_atom!(residue, 0)
        add_residue!(frame, residue)

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
