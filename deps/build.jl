using BinDeps
@BinDeps.setup

libchemfiles = library_dependency("libchemfiles")
version = "0.6.0"

@unix_only begin
    if Pkg.installed("Conda") === nothing
        error("Conda package not installed, please run Pkg.add(\"Conda\")")
    end
    using Conda
    if !("luthaf" in Conda.channels())
        Conda.add_channel("luthaf")
    end
    provides(Conda.Manager, "chemfiles-lib", libchemfiles, os = :Unix)
end

@windows_only begin
    using WinRPM
    push!(WinRPM.sources, "http://download.opensuse.org/repositories/home:Luthaf/openSUSE_13.2/")
    WinRPM.update()
    provides(WinRPM.RPM, "chemfiles", [libchemfiles], os = :Windows)
end

@BinDeps.install Dict(:libchemfiles => :libchemfiles)
