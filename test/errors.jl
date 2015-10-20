
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
    @fact isfile("chemfiles.log") --> true

    Chemfiles.loglevel(Chemfiles.ERROR)
end
