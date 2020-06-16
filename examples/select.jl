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
        remove_atom!(frame, i)
    end
    write(output, frame)
end

close(trajectory)
# When running on the REPL, closing the trajectory
# is required to flush buffered output and finish writing
close(output)
