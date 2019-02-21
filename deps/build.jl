version = "0.9.0"
linux_build_id = "hf484d3e_0"
macos_build_id = "h0a44026_0"
windows_build_id = "he025d50_0"

function is_64_bits()
    return Int == Int64
end

function unpack(file, directory)
    if Sys.isunix()
        run(`mkdir -p $directory`)
        run(`tar xjf $file --directory=$directory`)
    elseif Sys.iswindows()
        exe7z = joinpath(_HOME, "7z.exe")
        run(pipeline(`$exe7z x $file -y -so`, `$exe7z x -si -y -ttar -o$directory`))
    end
end


if Sys.iswindows()
    build_id = windows_build_id
    unpacked_file = joinpath("Library", "bin", "chemfiles.dll")
    if is_64_bits()
        platform = "win-64"
    else
        @assert Int == Int32
        platform = "win-32"
    end
elseif Sys.islinux()
    build_id = linux_build_id
    unpacked_file = joinpath("lib", "libchemfiles.so.$version")
    if !is_64_bits()
        @error "There is no prebuilt chemfiles library for 32bit Linux"
    end
    platform = "linux-64"
elseif Sys.isapple()
    build_id = macos_build_id
    unpacked_file = joinpath("lib", "libchemfiles.$version.dylib")
    if !is_64_bits()
        @error "There is no prebuilt chemfiles library for 32bit macOS"
    end
    platform = "osx-64"
else
    error("Could not find a prebuilt chemfiles library for the current platform")
end

URL = "https://anaconda.org/conda-forge/chemfiles-lib/$version/download/$platform/chemfiles-lib-$version-$build_id.tar.bz2"
LOCAL_ARCHIVE = joinpath(@__DIR__, basename(URL))

@info "Downloading pre-build library ..."
download(URL, LOCAL_ARCHIVE)
@info "Unpacking library ..."
unpack(LOCAL_ARCHIVE, joinpath(@__DIR__, "usr"))

LIBPATH = joinpath(@__DIR__, "usr", unpacked_file)

write(joinpath(@__DIR__, "deps.jl"), """
# This is an auto-generated file; do not edit

using Libdl

# Macro to load a library
macro checked_lib(libname, path)
    Libdl.dlopen_e(path) == C_NULL && @error "Unable to load \\n\\n\$libname (\$path)\\n\\nPlease re-run Pkg.build(package), and restart Julia."
    quote const \$(esc(libname)) = \$path end
end

# Load dependencies
@checked_lib libchemfiles "$(escape_string(LIBPATH))"
""")

@info "Done"
