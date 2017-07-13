# File convert.jl, example for the chemfiles library
# Any copyright is dedicated to the Public Domain.
# http://creativecommons.org/publicdomain/zero/1.0/

#!/usr/bin/env julia
using Chemfiles

# Read a frame from a given file
frame = read(Trajectory("filename.xyz"))

# Create a selection for all atoms with "Zn" name
selection = Selection("name Zn")
# Get the list of matching atoms from the frame
zincs = evaluate(selection, frame)

println("We have $(size(zincs)) zinc in the frame")
for index in zincs
    println("$index is a zinc")
end

# Create a selection for multiple atoms
selection = Selection("angles: name(#1) H and name(#2) O and name(#3) H")
# Get the list of matching atoms in the frame
waters = evaluate(selection, frame)

println("We have $(size(waters)) water molecules")
for i, j, k in waters
    println("$i - $j - $k is a water molecule")
end
