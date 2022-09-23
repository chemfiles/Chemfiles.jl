using Chemfiles
using Test
using Unitful

TESTS = [
    "atom.jl",
    "residue.jl",
    "topology.jl",
    "cell.jl",
    "frame.jl",
    "property.jl",
    "trajectory.jl",
    "selection.jl",
    "misc.jl",
    "atomsbase.jl",
]

include("utils.jl")

function main()
    @testset "Version" begin
        @test split(Chemfiles.version(), '-')[1] == "0.10.3"
    end
    root = dirname(@__FILE__)
    for test in TESTS
        include(test)
    end
end

main()
