# Use Chemfiles_jll & the artifact system on julia >= 1.3
if VERSION >= v"1.3.0"
    Sys.exit()
end

include("build_Chemfiles.v0.10.0.jl")
