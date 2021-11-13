using BinaryProvider # requires BinaryProvider 0.3.0 or later

# Parse some basic command-line arguments
const verbose = "--verbose" in ARGS
const prefix = Prefix(get([a for a in ARGS if a != "--verbose"], 1, joinpath(@__DIR__, "usr")))
products = [
    LibraryProduct(prefix, ["libchemfiles"], :libchemfiles),
]

# Download binaries from hosted location
bin_prefix = "https://github.com/JuliaBinaryWrappers/Chemfiles_jll.jl/releases/download/Chemfiles-v0.10.2+0"

# Listing of files generated by BinaryBuilder:
download_info = Dict(
    Linux(:aarch64, libc=:glibc, compiler_abi=CompilerABI(:gcc_any, :cxx03)) => ("$bin_prefix/Chemfiles.v0.10.2.aarch64-linux-gnu-cxx03.tar.gz", "8c3bf277846e8d2c6278388ea6ed754d0b3699669d4ed1ce267bed8d8f2ffc2e"),
    Linux(:aarch64, libc=:glibc, compiler_abi=CompilerABI(:gcc_any, :cxx11)) => ("$bin_prefix/Chemfiles.v0.10.2.aarch64-linux-gnu-cxx11.tar.gz", "cda398a69e0b2f77126833dce519b61eec4c379a203801fcc06506b287372fab"),
    Linux(:aarch64, libc=:musl, compiler_abi=CompilerABI(:gcc_any, :cxx03)) => ("$bin_prefix/Chemfiles.v0.10.2.aarch64-linux-musl-cxx03.tar.gz", "b5daf195d1b17bcc47a961240af433c48e61288b1d708a6df3142187ae89a795"),
    Linux(:aarch64, libc=:musl, compiler_abi=CompilerABI(:gcc_any, :cxx11)) => ("$bin_prefix/Chemfiles.v0.10.2.aarch64-linux-musl-cxx11.tar.gz", "f0dfe558cc109c8c7df682630c46e72241c3369678a477722bf06ed064ddd4f3"),
    Linux(:armv7l, libc=:glibc, call_abi=:eabihf, compiler_abi=CompilerABI(:gcc_any, :cxx03)) => ("$bin_prefix/Chemfiles.v0.10.2.armv7l-linux-gnueabihf-cxx03.tar.gz", "5b8e3246d0d90b7ee3fc3370ef3c10e448842955812f16a55ed798e16f497c24"),
    Linux(:armv7l, libc=:glibc, call_abi=:eabihf, compiler_abi=CompilerABI(:gcc_any, :cxx11)) => ("$bin_prefix/Chemfiles.v0.10.2.armv7l-linux-gnueabihf-cxx11.tar.gz", "59dc17ffd3f5bac1a7c719baab9db39949c5ced802ea646daa7679052a68d598"),
    Linux(:armv7l, libc=:musl, call_abi=:eabihf, compiler_abi=CompilerABI(:gcc_any, :cxx03)) => ("$bin_prefix/Chemfiles.v0.10.2.armv7l-linux-musleabihf-cxx03.tar.gz", "cd601578fe322d7f1e073a7d5cf399ac9b738e188478e5d0962ccb541df535dd"),
    Linux(:armv7l, libc=:musl, call_abi=:eabihf, compiler_abi=CompilerABI(:gcc_any, :cxx11)) => ("$bin_prefix/Chemfiles.v0.10.2.armv7l-linux-musleabihf-cxx11.tar.gz", "aa0346081873b1e51c605596c4bba415fe59324a87d9cd6f40de57768404e2e3"),
    Linux(:i686, libc=:glibc, compiler_abi=CompilerABI(:gcc_any, :cxx03)) => ("$bin_prefix/Chemfiles.v0.10.2.i686-linux-gnu-cxx03.tar.gz", "e571164d9b9f29bd18d319ccdd30f52f9b82a913d6a4432d4bbd126e84da2f79"),
    Linux(:i686, libc=:glibc, compiler_abi=CompilerABI(:gcc_any, :cxx11)) => ("$bin_prefix/Chemfiles.v0.10.2.i686-linux-gnu-cxx11.tar.gz", "cd276c499c83f73f396e49371974a9feb5681c8247bfa9b23f1bf4b3a0fde066"),
    Linux(:i686, libc=:musl, compiler_abi=CompilerABI(:gcc_any, :cxx03)) => ("$bin_prefix/Chemfiles.v0.10.2.i686-linux-musl-cxx03.tar.gz", "1adc817ab41f204d68f7366589d7c5b43943e47489a5c02d4339a95b9396da22"),
    Linux(:i686, libc=:musl, compiler_abi=CompilerABI(:gcc_any, :cxx11)) => ("$bin_prefix/Chemfiles.v0.10.2.i686-linux-musl-cxx11.tar.gz", "5cf1609b12ed33d6aa440e3bec248214cc8d0e0fe73acf3e5572f8fb1fcc1382"),
    Windows(:i686, compiler_abi=CompilerABI(:gcc_any, :cxx03)) => ("$bin_prefix/Chemfiles.v0.10.2.i686-w64-mingw32-cxx03.tar.gz", "c037b41ec4feb247c14aed582f58225dac7702419c6370777bb15d28ced99434"),
    Windows(:i686, compiler_abi=CompilerABI(:gcc_any, :cxx11)) => ("$bin_prefix/Chemfiles.v0.10.2.i686-w64-mingw32-cxx11.tar.gz", "dddeffbed57bb14ff5ada1ce9d17dc2e3be1bc84aa9562e49bd2bbead7892e07"),
    Linux(:powerpc64le, libc=:glibc, compiler_abi=CompilerABI(:gcc_any, :cxx03)) => ("$bin_prefix/Chemfiles.v0.10.2.powerpc64le-linux-gnu-cxx03.tar.gz", "9119d88ab98582949eda926c77ef52294a2066cd93b7b9407584c5ca6e2c46b7"),
    Linux(:powerpc64le, libc=:glibc, compiler_abi=CompilerABI(:gcc_any, :cxx11)) => ("$bin_prefix/Chemfiles.v0.10.2.powerpc64le-linux-gnu-cxx11.tar.gz", "a58fcfc747aa3ae56841283a385d619356aaa599ecaf71ce93aadb165e720d6c"),
    MacOS(:x86_64) => ("$bin_prefix/Chemfiles.v0.10.2.x86_64-apple-darwin.tar.gz", "5cfbcde3c3979f65333ad4c0b894fe9a3922e7aed13e8c10c2fafa3165dff7da"),
    Linux(:x86_64, libc=:glibc, compiler_abi=CompilerABI(:gcc_any, :cxx03)) => ("$bin_prefix/Chemfiles.v0.10.2.x86_64-linux-gnu-cxx03.tar.gz", "449f6ea2e64e753faca57ef11b1b7a73af357a396eacf51072b36e7a1d8aebd3"),
    Linux(:x86_64, libc=:glibc, compiler_abi=CompilerABI(:gcc_any, :cxx11)) => ("$bin_prefix/Chemfiles.v0.10.2.x86_64-linux-gnu-cxx11.tar.gz", "cfa42814faad11e26b10c18bdc74f6538b03cfcab1b59188525fc57f013e2820"),
    Linux(:x86_64, libc=:musl, compiler_abi=CompilerABI(:gcc_any, :cxx03)) => ("$bin_prefix/Chemfiles.v0.10.2.x86_64-linux-musl-cxx03.tar.gz", "a9d33deea6a101bf39d1b63dccddeec7ccc062c0da6372946cb17f0a2fc2424f"),
    Linux(:x86_64, libc=:musl, compiler_abi=CompilerABI(:gcc_any, :cxx11)) => ("$bin_prefix/Chemfiles.v0.10.2.x86_64-linux-musl-cxx11.tar.gz", "77a333de0f4b2a230f1d9944be5c62069a9dc0657e46b2aad0b2e58fee7d72c2"),
    FreeBSD(:x86_64) => ("$bin_prefix/Chemfiles.v0.10.2.x86_64-unknown-freebsd.tar.gz", "7540ef7c208d2f883ef90fdcf3c69fc3854e2766cad162602594bb769c0aab9c"),
    Windows(:x86_64, compiler_abi=CompilerABI(:gcc_any, :cxx03)) => ("$bin_prefix/Chemfiles.v0.10.2.x86_64-w64-mingw32-cxx03.tar.gz", "5dc4779eae1351552018cc38462d49e4bc85a8baf8bf1bd8eade6fdab72fb858"),
    Windows(:x86_64, compiler_abi=CompilerABI(:gcc_any, :cxx11)) => ("$bin_prefix/Chemfiles.v0.10.2.x86_64-w64-mingw32-cxx11.tar.gz", "5542b93bc22bac6f2fec222b7f926ce50d9bfe6eb3019903d335208b08fc56ca"),
)

# Install unsatisfied or updated dependencies:
unsatisfied = any(!satisfied(p; verbose=verbose) for p in products)
dl_info = choose_download(download_info, platform_key_abi())
if dl_info === nothing && unsatisfied
    # If we don't have a compatible .tar.gz to download, complain.
    # Alternatively, you could attempt to install from a separate provider,
    # build from source or something even more ambitious here.
    error("Your platform (\"$(Sys.MACHINE)\", parsed as \"$(triplet(platform_key_abi()))\") is not supported by this package!")
end

# If we have a download, and we are unsatisfied (or the version we're
# trying to install is not itself installed) then load it up!
if unsatisfied || !isinstalled(dl_info...; prefix=prefix)
    # Download and install binaries
    install(dl_info...; prefix=prefix, force=true, verbose=verbose)
end

# Write out a deps.jl file that will contain mappings for our products
write_deps_file(joinpath(@__DIR__, "deps.jl"), products, verbose=verbose)
