
facts("Error functions") do

    err = ChemfilesError("oops")
    iobuf = IOBuffer()
    show(iobuf, err)
    @fact ASCIIString(iobuf.data) --> "\"Chemfiles error: oops\""

    @fact Chemfiles.last_error() --> ""

    @fact Chemfiles.strerror(1) --> "Error in C++ runtime. Use chfl_last_error for more informations."

    # Functions called in the runtests.jl file
    # Chemfiles.logfile("chemfiles.log")
    # Chemfiles.log_to_stderr()
    root = dirname(@__FILE__)
    @fact isfile(joinpath(root, "chemfiles.log")) --> true

    @fact Chemfiles.loglevel() --> Chemfiles.WARNING
    Chemfiles.set_loglevel(Chemfiles.ERROR)
end
