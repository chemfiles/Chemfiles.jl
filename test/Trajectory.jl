
const DATAPATH = joinpath(@__DIR__, "data")

@testset "Trajectory type" begin
    @testset "Errors handling" begin
        remove_chemfiles_warning() do
            @test_throws ChemfilesError Trajectory(joinpath(DATAPATH, "not-here.xyz"))
            @test_throws ChemfilesError Trajectory(joinpath(DATAPATH, "empty.unknown"))
        end
    end

    @testset "Read frames" begin
        trajectory = Trajectory(joinpath(DATAPATH, "water.xyz"))

        @test path(trajectory) == joinpath(DATAPATH, "water.xyz")

        @test nsteps(trajectory) == 100

        frame = read(trajectory)

        @test size(frame) == 297
        pos = positions(frame)
        @test pos[:, 1] == Float64[0.417219, 8.303366, 11.737172]
        @test pos[:, 125] == Float64[5.099554, -0.045104, 14.153846]

        topology = Topology(frame)
        @test size(frame) == 297
        @test name(Atom(frame, 0)) == "O"
        @test name(Atom(frame, 1)) == "H"

        set_cell!(trajectory, UnitCell(30, 30, 30))
        frame = read_step(trajectory, 41)

        @test lengths(UnitCell(frame)) == [30.0, 30.0, 30.0]

        pos = positions(frame)
        @test pos[:, 1] == Float64[0.761277, 8.106125, 10.622949]
        @test pos[:, 125] == Float64[5.13242, 0.079862, 14.194161]

        topology = Topology(frame)
        @test size(topology) == 297
        @test bonds_count(topology) == 0

        guess_bonds!(frame)
        topology = Topology(frame)
        @test bonds_count(topology) == 181
        @test angles_count(topology) == 87

        topology = Topology()
        a = Atom("Cs")
        for i=1:297
            add_atom!(topology, a)
        end

        set_topology!(trajectory, topology)
        frame = read_step(trajectory, 10)
        @test name(Atom(frame, 10)) == "Cs"

        set_topology!(trajectory, joinpath(DATAPATH, "topology.xyz"))
        frame = read(trajectory)
        @test name(Atom(frame, 100)) == "Rd"
    end

    @testset "Iteration" begin
        trajectory = Trajectory(joinpath(DATAPATH, "water.xyz"))

        count = 0
        for frame in trajectory
            count += 1
        end

        @test count == nsteps(trajectory)
    end

    @testset "Write frames" begin
        EXPECTED_CONTENT = """4
                              Written by the chemfiles library
                              X 1 2 3
                              X 1 2 3
                              X 1 2 3
                              X 1 2 3
                              6
                              Written by the chemfiles library
                              X 4 5 6
                              X 4 5 6
                              X 4 5 6
                              X 4 5 6
                              X 4 5 6
                              X 4 5 6
                              """

        frame = Frame()
        resize!(frame, 4)
        pos = positions(frame)
        for i=1:4
            pos[:, i] = Float64[1, 2, 3]
        end

        topology = Topology()
        for i=1:4
            add_atom!(topology, Atom("X"))
        end
        set_topology!(frame, topology)

        trajectory = Trajectory("test-tmp.xyz", 'w');
        write(trajectory, frame)

        resize!(frame, 6)
        pos = positions(frame)
        for i=1:6
            pos[:, i] = Float64[4, 5, 6]
        end

        topology = Topology()
        for i=1:6
            add_atom!(topology, Atom("X"))
        end
        set_topology!(frame, topology)

        write(trajectory, frame)
        close(trajectory)
        @test isopen(trajectory) == false

        s = open("test-tmp.xyz") do file
            read(file, String)
        end

        @test s == EXPECTED_CONTENT

        rm("test-tmp.xyz")
    end
end
