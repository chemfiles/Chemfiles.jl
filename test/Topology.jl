
facts("Topology type") do
    top = Topology()

    @fact natoms(top) => 0

    # Creating some H2O2
    push!(top, Atom("H"))
    push!(top, Atom("O"))
    push!(top, Atom("O"))
    push!(top, Atom("H"))
    @fact natoms(top) => 4

    @fact nbonds(top) => 0
    @fact nangles(top) => 0
    @fact ndihedrals(top) => 0

    add_bond!(top, 0, 1)
    add_bond!(top, 1, 2)
    add_bond!(top, 2, 3)

    @fact nbonds(top) => 3
    @fact nangles(top) => 2
    @fact ndihedrals(top) => 1

    @fact isbond(top, 0, 1) => true
    @fact isbond(top, 0, 3) => false
    @fact isangle(top, 0, 1, 2) => true
    @fact isangle(top, 0, 1, 3) => false
    @fact isdihedral(top, 0, 1, 2, 3) => true
    @fact isdihedral(top, 0, 1, 3, 2) => false

    top_bonds = reshape(Csize_t[2, 3,   1, 2,   0, 1], (2, 3))

    @fact bonds(top) => top_bonds
    @fact angles(top) => reshape(Csize_t[0, 1, 2,   1, 2, 3,], (3, 2))
    @fact dihedrals(top) => reshape(Csize_t[0, 1, 2, 3], (4,1))

    remove_bond!(top, 2, 3)
    @fact nbonds(top) => 2
    @fact nangles(top) => 1
    @fact ndihedrals(top) => 0

    remove!(top, 3)
    @fact natoms(top) => 3
end
