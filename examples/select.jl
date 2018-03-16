# This file is an example for the chemfiles library
# Any copyright is dedicated to the Public Domain.
# http://creativecommons.org/publicdomain/zero/1.0/
#!/usr/bin/env julia
using Chemfiles

trajectory = Trajectory("input.arc")
output = Trajectory("output.pdb", 'w')

selection = Selection("name Zn or name N")

for frame in trajectory
    to_remove = evaluate(selection, frame)
    for i in reverse(sort(to_remove))
        remove!(frame, i)
    end
    write!(output, frame)
end
