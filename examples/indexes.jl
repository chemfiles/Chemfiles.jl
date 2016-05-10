# File indexes.jl, example for the chemfiles library
# Any copyright is dedicated to the Public Domain.
# http://creativecommons.org/publicdomain/zero/1.0/

#!/usr/bin/env julia
using Chemfiles

traj = Trajectory("filename.xyz")
frame = read(traj)
pos = positions(frame)

indexes = Int[]

for i=1:natoms(frame)
    if pos[1, i] < 5
        push!(indexes, i)
    end
end

println("Atoms with x < 5: ")
for i in indexes
    println("  - $i")
end
