
facts("Logging functions") do
    path = joinpath(dirname(@__FILE__), "chemfiles.log")
    Chemfiles.logfile(path)
    @fact isfile(path) --> true
    Chemfiles.log_to_stdout()

    rm(path)

    @fact Chemfiles.loglevel() --> Chemfiles.WARNING
    Chemfiles.set_loglevel(Chemfiles.ERROR)
    @fact Chemfiles.loglevel() --> Chemfiles.ERROR

    message = ""
    level = 0
    Chemfiles.log_callback((l, m) -> begin
        level = l
        message = m
    end)

    try
        Trajectory("nothere")
    catch
    end

    @fact message --> "Can not find a format associated with the \"\" extension."
    @fact level --> Chemfiles.ERROR

    Chemfiles.log_to_stderr()
end
