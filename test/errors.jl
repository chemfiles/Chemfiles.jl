
facts("Error functions") do
    err = ChemfilesError("oops")
    iobuf = IOBuffer()
    show(iobuf, err)
    @fact String(iobuf.data) --> "\"Chemfiles error: oops\""

    @fact Chemfiles.last_error() --> ""
end
