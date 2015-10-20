using Chemfiles
using FactCheck

TESTS = ["errors.jl", "Atom.jl", "Topology.jl", "UnitCell.jl", "Frame.jl", "Trajectory.jl"]

function main()
    Chemfiles.logfile("chemfiles.log")
    for test in TESTS
        include(test)
    end
    Chemfiles.log_to_stderr()
    rm("chemfiles.log")
    FactCheck.exitstatus()
end

main()
