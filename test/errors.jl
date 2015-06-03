
facts("Error functions") do

    err = ChemharpError("oops")
    iobuf = IOBuffer()
    show(iobuf, err)
    @fact ASCIIString(iobuf.data) => "\"Chemharp error: oops\""

    @fact Chemharp.last_error() => ""

    @fact Chemharp.strerror(1) => "Error in C++ runtime. Use chrp_last_error for more informations."

    # Functions called in the runtests.jl file
    # Chemharp.logfile("chemharp.log")
    # Chemharp.log_to_stderr()
    @fact isfile("chemharp.log") => true

    Chemharp.loglevel(Chemharp.ERROR)
end
