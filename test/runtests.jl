using Chemfiles
using Base.Test

TESTS = [
    "errors.jl", "Atom.jl", "Topology.jl", "UnitCell.jl", "Frame.jl",
    "Trajectory.jl", "Selection.jl"
]

function main()
    @testset "Generics" begin
        @test Chemfiles.version() == "0.7.4"
    end
    root = dirname(@__FILE__)
    for test in TESTS
        include(test)
    end
end

main()
