facts("Error functions") do
    @fact Chemharp.last_error() => ""

    Chemharp.logfile("chemharp.log")
    @fact isfile("chemharp.log") => true

    # Just calling the functions to check the interface
    Chemharp.loglevel(Chemharp.ERROR)
    Chemharp.log_to_stderr()
    rm("chemharp.log")
end
