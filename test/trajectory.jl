
const DATAPATH = joinpath(@__DIR__, "data")

@testset "Trajectory" begin
    @testset "Errors handling" begin
        remove_chemfiles_warning() do
            @test_throws ChemfilesError Trajectory(joinpath(DATAPATH, "not-here.xyz"))
            @test_throws ChemfilesError Trajectory(joinpath(DATAPATH, "empty.unknown"))

            trajectory = Trajectory(joinpath(DATAPATH, "water.xyz"))
            @test_throws ChemfilesError take!(trajectory)
            close(trajectory)
        end
    end

    @testset "Read frames" begin
        trajectory = Trajectory(joinpath(DATAPATH, "water.xyz"))

        @test path(trajectory) == joinpath(DATAPATH, "water.xyz")

        @test length(trajectory) == 100

        frame = read(trajectory)

        @test size(frame) == 297
        pos = positions(frame)
        @test pos[:, 1] ≈ Float64[0.417219, 8.303366, 11.737172]
        @test pos[:, 125] ≈ Float64[5.099554, -0.045104, 14.153846]

        read!(trajectory,frame)
        @test size(frame) == 297
        pos = positions(frame)
        @test pos[:, 1] ≈ Float64[0.357720, 8.306397, 11.744901]
        @test pos[:, 125] ≈ Float64[5.007032, 0.066848, 14.184831]

        topology = Topology(frame)
        @test size(frame) == 297
        @test name(Atom(frame, 0)) == "O"
        @test name(Atom(frame, 1)) == "H"

        set_cell!(trajectory, UnitCell(30, 30, 30))
        frame = read_step(trajectory, 41)

        @test lengths(UnitCell(frame)) == [30.0, 30.0, 30.0]

        pos = positions(frame)
        @test pos[:, 1] ≈ Float64[0.761277, 8.106125, 10.622949]
        @test pos[:, 125] ≈ Float64[5.13242, 0.079862, 14.194161]

        read_step!(trajectory,41,frame)

        @test lengths(UnitCell(frame)) == [30.0, 30.0, 30.0]

        pos = positions(frame)
        @test pos[:, 1] ≈ Float64[0.761277, 8.106125, 10.622949]
        @test pos[:, 125] ≈ Float64[5.13242, 0.079862, 14.194161]

        topology = Topology(frame)
        @test size(topology) == 297
        @test bonds_count(topology) == 0

        guess_bonds!(frame)
        topology = Topology(frame)
        @test bonds_count(topology) == 180
        @test angles_count(topology) == 84

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

        @test count == length(trajectory)
    end

    @testset "Write frames" begin
        EXPECTED_CONTENT = """4
                              Properties=species:S:1:pos:R:3
                              X 1 2 3
                              X 1 2 3
                              X 1 2 3
                              X 1 2 3
                              """

        frame = Frame()
        for i=1:4
            add_atom!(frame, Atom("X"), Float64[1, 2, 3])
        end

        trajectory = Trajectory("test-tmp.xyz", 'w');
        write(trajectory, frame)
        close(trajectory)
        @test isopen(trajectory) == false

        s = open("test-tmp.xyz") do file
            read(file, String)
        end

        @test s == EXPECTED_CONTENT

        rm("test-tmp.xyz")
    end

    @testset "Function syntax" begin
        trajectory = nothing
        Trajectory(joinpath(DATAPATH, "water.xyz")) do tr
            trajectory = tr
            @test isopen(trajectory)
        end
        @test !isopen(trajectory)
    end

    @testset "In-memory reader" begin
        trajectory = MemoryTrajectory("XYZ", """3

H 0 0 0
C 1 2 0
Zn 3 2 -5""")
        frame = read(trajectory)
        expected = transpose([
            0 0 0
            1 2 0
            3 2 -5
        ])
        @test positions(frame) == expected
        @test name(Atom(frame, 0)) == "H"
        @test name(Atom(frame, 1)) == "C"
        @test name(Atom(frame, 2)) == "Zn"
    end

    @testset "In-memory writer" begin
        frame = Frame()
        add_atom!(frame, Atom("Cu"), Float64[2, 1, 4])
        add_atom!(frame, Atom("Hf"), Float64[0, 3.2, 0])
        add_atom!(frame, Atom("Li"), Float64[1, 0, -4])

        trajectory = MemoryTrajectory("PDB")
        write(trajectory, frame)
        expected = """MODEL    1
CRYST1    0.000    0.000    0.000  90.00  90.00  90.00 P 1           1
HETATM    1 Cu           1       2.000   1.000   4.000  1.00  0.00          Cu
HETATM    2 Hf           2       0.000   3.200   0.000  1.00  0.00          Hf
HETATM    3 Li           3       1.000   0.000  -4.000  1.00  0.00          Li
ENDMDL
"""

        @test String(take!(trajectory)) == expected
    end
end
