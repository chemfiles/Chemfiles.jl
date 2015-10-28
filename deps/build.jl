using BinDeps
@BinDeps.setup

libchemfiles = library_dependency("libchemfiles")
version = "0.4.0"

@unix_only begin
    if Pkg.installed("Conda") === nothing
        error("Conda package not installed, please run Pkg.add(\"Conda\")")
    end
    using Conda
    push!(Conda.CHANNELS, "https://conda.anaconda.org/luthaf")
    provides(Conda.Manager, "chemfiles-lib", libchemfiles, os = :Unix, onload =
    """
    function __init__()
        ENV["CHEMFILES_PLUGINS"] = joinpath("$(Conda.PREFIX)", "lib", "molfiles")
    end
    """ )
end

@windows_only begin
    using WinRPM
    push!(WinRPM.sources, "http://download.opensuse.org/repositories/home:Luthaf/openSUSE_13.2/")
    WinRPM.update()
    provides(WinRPM.RPM, "chemfiles", [libchemfiles], os = :Windows, onload =
    """
    function __init__()
        ENV["CHEMFILES_PLUGINS"] = joinpath(
            $(WinRPM.installdir), "usr", "$(Sys.ARCH)-w64-mingw32",
            "sys-root", "mingw", "bin", "molfiles"
        )
    """ )
end

provides(Sources,
         URI("https://github.com/chemfiles/chemfiles/archive/$version.tar.gz"),
         libchemfiles,
         unpacked_dir="chemfiles-$version")

prefix = joinpath(BinDeps.depsdir(libchemfiles), "usr")
srcdir = joinpath(BinDeps.depsdir(libchemfiles), "src", "chemfiles-$version")
builddir = joinpath(BinDeps.depsdir(libchemfiles), "builds", "chemfiles-$version")

DL_EXT = VERSION >= v"0.4.0-dev" ? Libdl.dlext : Base.Sys.shlib_ext

provides(BuildProcess,
    (@build_steps begin
        GetSources(libchemfiles)
        CreateDirectory(builddir)
        @build_steps begin
            ChangeDirectory(builddir)
            FileRule(joinpath(prefix, "lib", "libchemfiles.$(DL_EXT)"),
                @build_steps begin
                    `cmake -DCMAKE_INSTALL_PREFIX="$prefix" -DBUILD_SHARED_LIBS=ON $srcdir`
                    `make`
                    `make install`
                end
            )
        end
    end), libchemfiles)

@BinDeps.install Dict(:libchemfiles => :libchemfiles)
