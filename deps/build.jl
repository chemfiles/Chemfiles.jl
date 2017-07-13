using BinDeps
@BinDeps.setup

libchemfiles = library_dependency("libchemfiles", aliases = ["chemfiles"])
version = "0.7.4"

if Pkg.installed("Conda") === nothing
    error("Conda package not installed, please run Pkg.add(\"Conda\")")
end
using Conda
if !("conda-forge" in Conda.channels())
    Conda.add_channel("conda-forge")
end
provides(Conda.Manager, "chemfiles-lib==$(version)", libchemfiles)

@BinDeps.install Dict(:libchemfiles => :libchemfiles)
