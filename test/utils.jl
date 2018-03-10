function warning_callback(message::String)
    global TEST_CALLBACK = true
    nothing
end

@testset "Error Functions" begin
    err = ChemfilesError("oops")
    iobuf = IOBuffer(19 + length(err.message))
    show(iobuf, err)
    @test String(iobuf.data) == "\"Chemfiles error: oops\""

    @test Chemfiles.last_error() == ""

    @test_throws ChemfilesError Residue(Topology(), 3)
    @test_throws UndefVarError TEST_CALLBACK == false

    @test Chemfiles.last_error() == "Residue index out of bounds in topology: we have 0 residues, but the index is 3"

    Chemfiles.clear_errors()
    @test Chemfiles.last_error() == ""

    Chemfiles.set_warning_callback(warning_callback)
    @test_throws ChemfilesError Residue(Topology(), 3)
    @test TEST_CALLBACK == true
end

@testset "Configuration files" begin
    config = joinpath(@__DIR__, "data", "config.toml")
    Chemfiles.add_configuration(config)

    trajectory = joinpath(@__DIR__, "data", "water.xyz")
    frame = read(Trajectory(trajectory))

    @test name(Atom(frame, 9)) == "Oz"
    @test atom_type(Atom(frame, 9)) == "F"
end
