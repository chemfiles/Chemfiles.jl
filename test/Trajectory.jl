
const DATAPATH = joinpath(dirname(@__FILE__), "data")

facts("Trajectory type") do
    context("Errors handling") do
        @fact_throws Trajectory(joinpath(DATAPATH, "not-here.xyz"))
        @fact_throws Trajectory(joinpath(DATAPATH, "empty.unknown"))
    end

    context("Read frames") do
        file = Trajectory(joinpath(DATAPATH, "water.xyz"))
        frame = read(file)

        @fact natoms(frame) => 297
        pos = positions(frame)
        @fact pos[:, 1] => Float32[0.417219, 8.303366, 11.737172]
        @fact pos[:, 125] => Float32[5.099554, -0.045104, 14.153846]

        topology = Topology(frame)
        @fact natoms(topology) => 297
        @fact name(Atom(topology, 0)) => "O"

        read_step!(file, 41, frame)
        pos = positions(frame)
        @fact pos[:, 1] => Float32[0.761277, 8.106125, 10.622949]
        @fact pos[:, 125] => Float32[5.13242, 0.079862, 14.194161]

        topology = Topology(frame)
        @fact natoms(topology) => 297
        @fact name(Atom(topology, 0)) => "O"
    end

    context("Write frames") do
        expected_content = """4
                              Written by Chemharp
                              X 1 2 3
                              X 1 2 3
                              X 1 2 3
                              X 1 2 3
                              6
                              Written by Chemharp
                              X 4 5 6
                              X 4 5 6
                              X 4 5 6
                              X 4 5 6
                              X 4 5 6
                              X 4 5 6
                              """

        pos = Array(Float32, 3, 4)
        for i=1:4
            pos[:, i] = Float32[1, 2, 3]
        end

        top = Topology()
        for i=1:4
            push!(top, Atom("X"))
        end
        frame = Frame()
        set_positions!(frame, pos)
        set_topology!(frame, top)

        file = Trajectory("test-tmp.xyz", "w");
        write(file, frame)

        pos = Array(Float32, 3, 6)
        for i=1:6
            pos[:, i] = Float32[4, 5, 6]
        end
        top = Topology()
        for i=1:6
            push!(top, Atom("X"))
        end
        set_positions!(frame, pos)
        set_topology!(frame, top)

        write(file, frame)
        close(file)

        @fact isopen(file) => false

        open("test-tmp.xyz") do fd
            @fact readall(fd) => expected_content
        end

        rm("test-tmp.xyz")
    end
end
