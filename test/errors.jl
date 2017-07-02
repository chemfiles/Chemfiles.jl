@testset "Error Functions" begin
    err = ChemfilesError("oops")
    iobuf = IOBuffer(19 + length(err.message))
    show(iobuf, err)
    @test String(iobuf.data) == "\"Chemfiles error: oops\""

    @test Chemfiles.last_error() == ""
end
