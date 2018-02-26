version = "0.8.0"
linux_build_id = "1"
macos_build_id = "1"
windows_build_id = "vc14_1"

function is_64_bits()
    return Int == Int64
end

if VERSION >= v"0.7.0-DEV.3073"
    const _HOME = Sys.BINDIR
else
    const _HOME = JULIA_HOME
end

function unpack(file, directory)
    if is_unix()
        run(`mkdir -p $directory`)
        run(`tar xjf $file --directory=$directory`)
    elseif is_windows()
        exe7z = joinpath(_HOME, "7z.exe")
        run(pipeline(`$exe7z x $file -y -so`, `$exe7z x -si -y -ttar -o$directory`))
    end
end


if is_windows()
    build_id = windows_build_id
    unpacked_file = joinpath("Library", "bin", "chemfiles.dll")
    if is_64_bits()
        platform = "win-64"
    else
        assert(Int == Int32)
        platform = "win-32"
    end
elseif is_linux()
    build_id = linux_build_id
    unpacked_file = joinpath("lib", "libchemfiles.so.$version")
    if !is_64_bits()
        error("There is no prebuilt chemfiles library for 32bit Linux")
    end
    platform = "linux-64"
elseif is_apple()
    build_id = macos_build_id
    unpacked_file = joinpath("lib", "libchemfiles.$version.dylib")
    if !is_64_bits()
        error("There is no prebuilt chemfiles library for 32bit macOS")
    end
    platform = "osx-64"
else
    error("Could not find a prebuilt chemfiles library for the current platform")
end

URL = "https://anaconda.org/conda-forge/chemfiles-lib/$version/download/$platform/chemfiles-lib-$version-$build_id.tar.bz2"
LOCAL_ARCHIVE = joinpath(@__DIR__, basename(URL))

download(URL, LOCAL_ARCHIVE)
unpack(LOCAL_ARCHIVE, joinpath(@__DIR__, "usr"))

LIBPATH = joinpath(@__DIR__, "usr", unpacked_file)

write(joinpath(@__DIR__, "deps.jl"), """
# This is an auto-generated file; do not edit

# Macro to load a library
macro checked_lib(libname, path)
    Base.Libdl.dlopen_e(path) == C_NULL && error("Unable to load \\n\\n\$libname (\$path)\\n\\nPlease re-run Pkg.build(package), and restart Julia.")
    quote const \$(esc(libname)) = \$path end
end

# Load dependencies
@checked_lib libchemfiles "$(escape_string(LIBPATH))"
""")
