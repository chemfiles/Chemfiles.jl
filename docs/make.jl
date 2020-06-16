using Documenter
using Pkg

Pkg.activate(joinpath(@__DIR__, ".."))
using Chemfiles

makedocs(
    sitename = "Chemfiles.jl",
    modules = [Chemfiles],
    strict = true,
    checkdocs = :all,
    format = Documenter.HTML(
       prettyurls = get(ENV, "CI", nothing) == "true",
    ),
)
