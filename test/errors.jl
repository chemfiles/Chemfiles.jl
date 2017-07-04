function warning_callback(message::String)
    warn("[TEST][chemfiles] ", message)
end

@testset "Error Functions" begin
    err = ChemfilesError("oops")
    iobuf = IOBuffer(19 + length(err.message))
    show(iobuf, err)
    @test String(iobuf.data) == "\"Chemfiles error: oops\""

    @test Chemfiles.last_error() == ""

    @test_warn "[chemfiles]" @test_throws ChemfilesError Residue(Topology(), 3)
    set_warning_callback(warning_callback)
    @test_warn "[TEST][chemfiles]" @test_throws ChemfilesError Residue(Topology(), 3)
end
