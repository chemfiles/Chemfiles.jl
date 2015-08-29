using BinDeps
@BinDeps.setup

libchemharp = library_dependency("libchemharp")
version = "0.3.1"

@osx_only begin
    if Pkg.installed("Homebrew") === nothing
            error("Homebrew package not installed, please run Pkg.add(\"Homebrew\")")
    end
    using Homebrew
    provides(Homebrew.HB, "chemharp", libchemharp, os = :Darwin, onload =
    """
    function __init__()
        ENV["CHRP_MOLFILES"] = joinpath("$(Homebrew.prefix("chemharp"))","lib")
    end
    """ )
end

@windows_only begin
    using WinRPM
    push!(WinRPM.sources, "http://download.opensuse.org/repositories/home:Luthaf/openSUSE_13.2/")
    WinRPM.update()
    provides(WinRPM.RPM, "Chemharp", [libchemharp], os = :Windows, onload =
    """
    function __init__()
        ENV["CHRP_MOLFILES"] = joinpath($(WinRPM.installdir), "lib", "molfiles")
        println!(ENV["CHRP_MOLFILES"])
    end
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
