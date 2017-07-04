function warning_callback(message::Ptr{UInt8})
    warn("Warn Test")
end

@testset "Error Functions" begin
    err = ChemfilesError("oops")
    iobuf = IOBuffer(19 + length(err.message))
    show(iobuf, err)
    @test String(iobuf.data) == "\"Chemfiles error: oops\""

    @test Chemfiles.last_error() == ""

    # TODO: Tests warning_callback
    # set_warning_callback(warning_callback)
    # @test_warn "Warn Test" Residue(Topology(), 3)
end
