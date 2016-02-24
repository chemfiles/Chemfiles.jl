
facts("Error functions") do
    err = ChemfilesError("oops")
    iobuf = IOBuffer()
    show(iobuf, err)
    @fact ASCIIString(iobuf.data) --> "\"Chemfiles error: oops\""

    @fact Chemfiles.last_error() --> ""

    @fact Chemfiles.strerror(1) --> "Memory error. Use chfl_last_error for more informations."
end
