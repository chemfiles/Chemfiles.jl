using Chemfiles
using Test

TESTS = [
    "Atom.jl",
    "Residue.jl",
    "Topology.jl",
    "UnitCell.jl",
    "Frame.jl",
    "Property.jl",
    "Trajectory.jl",
    "Selection.jl",
    "misc.jl",
]

include("utils.jl")

function main()
    @testset "Generics" begin
        @test split(Chemfiles.version(), '-')[1] == "0.9.3"
    end
    root = dirname(@__FILE__)
    for test in TESTS
        include(test)
    end
end

main()
