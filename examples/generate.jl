# This file is an example for the chemfiles library
# Any copyright is dedicated to the Public Domain.
# http://creativecommons.org/publicdomain/zero/1.0/
#!/usr/bin/env julia
using Chemfiles

topology = Topology()
add_atom!(topology, Atom("H"))
add_atom!(topology, Atom("O"))
add_atom!(topology, Atom("H"))

add_bond!(topology, 0, 1)
add_bond!(topology, 2, 1)

frame = Frame()
resize!(frame, 3)
set_topology!(frame, topology)

pos = frame.positions()
pos[1, :] = [1.0, 0.0, 0.0]
pos[2, :] = [0.0, 0.0, 0.0]
pos[3, :] = [0.0, 1.0, 0.0]

add_atom!(frame, Atom("O"), [5.0, 0.0, 0.0])
add_atom!(frame, Atom("C"), [6.0, 0.0, 0.0])
add_atom!(frame, Atom("O"), [7.0, 0.0, 0.0])
add_bond!(frame, 3, 4)
add_bond!(frame, 4, 5)

set_cell!(frame, UnitCell(10, 10, 10))

trajectory = Trajectory("water-co2.pdb", 'w')
write(trajectory, frame)
# When running on the REPL, remember to close the trajectory or else it won't
# end writing.
close(trajectory) 
