using Chemfiles
using FactCheck

TESTS = ["errors.jl", "Atom.jl", "Topology.jl", "UnitCell.jl", "Frame.jl", "Trajectory.jl"]

function main()
    root = dirname(@__FILE__)
    Chemfiles.logfile(joinpath(root, "chemfiles.log"))
    for test in TESTS
        include(test)
    end
    Chemfiles.log_to_stderr()
    FactCheck.exitstatus()
end

main()
