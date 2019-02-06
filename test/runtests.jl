using Chemfiles
using Test

TESTS = [
    "misc.jl", "Atom.jl", "Topology.jl", "UnitCell.jl", "Frame.jl",
    "Trajectory.jl", "Selection.jl", "Residue.jl", "Property.jl"
]

include("utils.jl")

function main()
    @testset "Generics" begin
        @test Chemfiles.version() == "0.8.0"
    end
    root = dirname(@__FILE__)
    for test in TESTS
        include(test)
    end
end

main()
