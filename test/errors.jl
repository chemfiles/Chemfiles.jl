
facts("Error functions") do
    err = ChemfilesError("oops")
    iobuf = IOBuffer(19 + length(err.message))
    show(iobuf, err)
    @fact String(iobuf.data) --> "\"Chemfiles error: oops\""

    @fact Chemfiles.last_error() --> ""
end
