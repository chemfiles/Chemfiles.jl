
const DATAPATH = joinpath(dirname(@__FILE__), "data")

@testset "Trajectory type" begin
    @testset "Errors handling" begin
        @test_throws ChemfilesError Trajectory(joinpath(DATAPATH, "not-here.xyz"))
        @test_throws ChemfilesError Trajectory(joinpath(DATAPATH, "empty.unknown"))
    end

    @testset "Read frames" begin
        file = Trajectory(joinpath(DATAPATH, "water.xyz"))

        @test nsteps(file) == 100

        frame = read(file)

        @test natoms(frame) == 297
        pos = positions(frame)
        @test pos[:, 1] == Float64[0.417219, 8.303366, 11.737172]
        @test pos[:, 125] == Float64[5.099554, -0.045104, 14.153846]

        topology = Topology(frame)
        @test natoms(topology) == 297
        @test name(Atom(topology, 0)) == "O"
        @test name(Atom(frame, 1)) == "H"

        set_cell!(file, UnitCell(30, 30, 30))
        frame = read_step(file, 41)

        @test lengths(UnitCell(frame)) == [30.0, 30.0, 30.0]

        pos = positions(frame)
        @test pos[:, 1] == Float64[0.761277, 8.106125, 10.622949]
        @test pos[:, 125] == Float64[5.13242, 0.079862, 14.194161]

        topology = Topology(frame)
        @test natoms(topology) == 297
        @test nbonds(topology) == 0

        guess_bonds!(frame)
        topology = Topology(frame)
        @test nbonds(topology) == 181
        @test nangles(topology) == 87

        topology = Topology()
        a = Atom("Cs")
        for i=1:297
            push!(topology, a)
        end

        set_topology!(file, topology)
        frame = read_step(file, 10)
        @test name(Atom(frame, 10)) == "Cs"

        set_topology!(file, joinpath(DATAPATH, "topology.xyz"))
        frame = read(file)
        @test name(Atom(frame, 100)) == "Rd"
    end

    @testset "Write frames" begin
        expected_content = """4
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

        top = Topology()
        for i=1:4
            push!(top, Atom("X"))
        end
        set_topology!(frame, top)

        file = Trajectory("test-tmp.xyz", 'w');
        write(file, frame)

        resize!(frame, 6)
        pos = positions(frame)
        for i=1:6
            pos[:, i] = Float64[4, 5, 6]
        end
        top = Topology()
        for i=1:6
            push!(top, Atom("X"))
        end
        set_topology!(frame, top)

        write(file, frame)
        close(file)
        @test isopen(file) == false

        open("test-tmp.xyz") do fd
            @test readstring(fd) == expected_content
        end

        rm("test-tmp.xyz")
    end
end
