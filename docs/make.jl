using Documenter
using Documenter: Selectors, Expanders
using Markdown


# Include external code inside documentation
struct LiteralInclude <: Expanders.ExpanderPipeline end

Selectors.order(::Type{LiteralInclude}) = 0.5
Selectors.matcher(::Type{LiteralInclude}, node::Markdown.Code, page, doc) = occursin("@literalinclude", node.language)
Selectors.matcher(::Type{LiteralInclude}, node, page, doc) = false

function Selectors.runner(::Type{LiteralInclude}, node, page, doc)
    if node.code != ""
        error("content is not supported in @literalinclude")
    end

    matched = match(r"@literalinclude (.*) (\d+)-(\d*)", node.language)
    if matched === nothing
        error("@literalinclude should look like '@literalinclude path/to/file.jl 3-5'")
    end

    path = matched[1]
    start = parse(Int, matched[2])
    if matched[3] == ""
        stop = nothing
    else
        stop = parse(Int, matched[3])
        if stop < start
            error("@literalinclude last line should be larger than start line")
        end
    end

    content = open(path) do fd
        lines = readlines(fd)
        if stop !== nothing
            join(lines[start:stop], '\n')
        else
            join(lines[start:end], '\n')
        end
    end
    page.mapping[node] = Markdown.Code("julia", content)
end


using Pkg
Pkg.activate(joinpath(@__DIR__, ".."))
using Chemfiles

makedocs(
    sitename="Chemfiles.jl",
    modules=[Chemfiles],
    strict=true,
    checkdocs=:all,
    format=Documenter.HTML(
       prettyurls=get(ENV, "CI", nothing) == "true",
    ),
    pages=[
        "index.md",
        "tutorials.md",
        "reference/trajectory.md",
        "reference/frame.md",
        "reference/atom.md",
        "reference/cell.md",
        "reference/topology.md",
        "reference/residue.md",
        "reference/selection.md",
        "reference/misc.md",
    ]
)
