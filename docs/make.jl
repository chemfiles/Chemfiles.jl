using Documenter
using Documenter: Selectors, Expanders
using MarkdownAST


# Include external code inside documentation
struct LiteralInclude <: Expanders.ExpanderPipeline end

Selectors.order(::Type{LiteralInclude}) = 0.5
Selectors.matcher(::Type{LiteralInclude}, node, page, doc) = Documenter.iscode(node, r"^@literalinclude")

function Selectors.runner(::Type{LiteralInclude}, node, page, doc)
    if node.element.code != ""
        error("content is not supported in @literalinclude")
    end

    matched = match(r"@literalinclude (.*) (\d+)-(\d*)", node.element.info)
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

    code = MarkdownAST.CodeBlock("julia", content)
    MarkdownAST.insert_after!(node, MarkdownAST.Node(code))
    MarkdownAST.unlink!(node)
end


using Pkg
Pkg.activate(joinpath(@__DIR__, ".."))
Pkg.instantiate()
using Chemfiles
using AtomsBase

makedocs(
    sitename="Chemfiles.jl",
    modules=[Chemfiles],
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
        "reference/atomsbase.md"
    ]
)
