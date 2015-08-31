using BinDeps
@BinDeps.setup

libchemharp = library_dependency("libchemharp")
version = "0.3.1"

@unix_only begin
    if Pkg.installed("Conda") === nothing
        error("Conda package not installed, please run Pkg.add(\"Conda\")")
    end
    using Conda
    push!(Conda.CHANNELS, "https://conda.binstar.org/luthaf")
    provides(Conda.Manager, "chemharp", libchemharp, os = :Unix, onload =
    """
    function __init__()
        ENV["CHRP_MOLFILES"] = joinpath("$(Conda.PREFIX)","lib")
    end
    """ )
end

@windows_only begin
    using WinRPM
    push!(WinRPM.sources, "http://download.opensuse.org/repositories/home:Luthaf/openSUSE_13.2/")
    WinRPM.update()
    provides(WinRPM.RPM, "chemharp", [libchemharp], os = :Windows, onload =
    """
    function __init__()
        ENV["CHRP_MOLFILES"] = joinpath(
            $(WinRPM.installdir), "usr", "$(Sys.ARCH)-w64-mingw32",
            "sys-root", "mingw", "bin", "molfiles"
        )
    """ )
end

provides(Sources,
         URI("https://github.com/Luthaf/Chemharp/archive/$version.tar.gz"),
         libchemharp,
         unpacked_dir="Chemharp-$version")

prefix = joinpath(BinDeps.depsdir(libchemharp), "usr")
srcdir = joinpath(BinDeps.depsdir(libchemharp), "src", "Chemharp-$version")
builddir = joinpath(BinDeps.depsdir(libchemharp), "builds", "Chemharp-$version")

DL_EXT = VERSION >= v"0.4.0-dev" ? Libdl.dlext : Base.Sys.shlib_ext

provides(BuildProcess,
    (@build_steps begin
        GetSources(libchemharp)
        CreateDirectory(builddir)
        @build_steps begin
            ChangeDirectory(builddir)
            FileRule(joinpath(prefix, "lib", "libchemharp.$(DL_EXT)"),
                @build_steps begin
                    `cmake -DCMAKE_INSTALL_PREFIX="$prefix" $srcdir`
                    `make`
                    `make install`
                end
            )
        end
    end), libchemharp)

@BinDeps.install
