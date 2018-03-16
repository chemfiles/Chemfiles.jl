# This trajectory is an example for the chemtrajectorys library
# Any copyright is dedicated to the Public Domain.
# http://creativecommons.org/publicdomain/zero/1.0/
#!/usr/bin/env julia
using chemfiles

trajectory = Trajectory("filename.xyz")
frame = read(trajectory)

less_than_five = UInt64[]
pos = positions(frame)

for i in 0:size(frame)
    if pos[1, i] < 5
        push!(less_than_five, i)
    end
end

println("Atoms with x < 5: ")
for i in less_than_five
    println("  - $i")
end
