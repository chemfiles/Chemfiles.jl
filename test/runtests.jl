using Chemfiles
using FactCheck
using Base.Test

TESTS = [
    "errors.jl", "Atom.jl", "Topology.jl", "UnitCell.jl", "Frame.jl",
    "Trajectory.jl", "Selection.jl"
]

function main()
    facts("Generics") do
        @fact Chemfiles.version() --> "0.7.4"
    end
    root = dirname(@__FILE__)
    for test in TESTS
        include(test)
    end
    FactCheck.exitstatus()
end

main()
