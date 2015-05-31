using Chemharp
using FactCheck

TESTS = ["errors.jl", "Atom.jl", "Topology.jl", "UnitCell.jl", "Frame.jl", "Trajectory.jl"]

function main()
    Chemharp.logfile("chemharp.log")
    for test in TESTS
        include(test)
    end
    Chemharp.log_to_stderr()
    rm("chemharp.log")
    FactCheck.exitstatus()
end

main()
