using Chemfiles
using FactCheck

TESTS = [
    "errors.jl", "logging.jl", "Atom.jl", "Topology.jl", "UnitCell.jl",
    "Frame.jl", "Trajectory.jl"
]

function main()
    facts("Generics") do
        @fact Chemfiles.version() --> "0.6.0"
    end
    root = dirname(@__FILE__)
    for test in TESTS
        include(test)
    end
    FactCheck.exitstatus()
end

main()
