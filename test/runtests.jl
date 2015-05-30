using Chemharp
using FactCheck

TESTS = ["Atom.jl"]

function main()
    for test in TESTS
        include(test)
    end
    FactCheck.exitstatus()
end

main()
