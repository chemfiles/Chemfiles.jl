
facts("Error functions") do
    @fact Chemharp.last_error() => ""

    # Functions called in the runtests.jl file
    # Chemharp.logfile("chemharp.log")
    # Chemharp.log_to_stderr()
    @fact isfile("chemharp.log") => true

    Chemharp.loglevel(Chemharp.ERROR)
end
