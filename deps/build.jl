using BinDeps
@BinDeps.setup

libchemharp = library_dependency("libchemharp")

#@BinDeps.if_install begin

version = "0.2.0"

provides(Sources,
         URI("https://github.com/Luthaf/Chemharp/archive/$version.tar.gz"),
         libchemharp,
         unpacked_dir="Chemharp-$version")

prefix = joinpath(BinDeps.depsdir(libchemharp), "usr")
srcdir = joinpath(BinDeps.depsdir(libchemharp), "src", "Chemharp-$version")
builddir = joinpath(BinDeps.depsdir(libchemharp), "builds", "Chemharp-$version")

provides(BuildProcess,
    (@build_steps begin
        GetSources(libchemharp)
        CreateDirectory(builddir)
        @build_steps begin
            ChangeDirectory(builddir)
            FileRule(joinpath(prefix, "lib", "libchemharp.dylib"),
                @build_steps begin
                    `cmake -DCMAKE_INSTALL_PREFIX="$prefix" $srcdir`
                    `make`
                    `make install`
                end
            )
        end
    end), libchemharp)

@BinDeps.install
