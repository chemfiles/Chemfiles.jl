@testset "Topology type" begin
    top = Topology()

    @test natoms(top) == 0
    @test size(top) == 0

    # Creating some H2O2
    push!(top, Atom("H"))
    push!(top, Atom("O"))
    push!(top, Atom("O"))
    push!(top, Atom("H"))
    @test natoms(top) == 4

    @test nbonds(top) == 0
    @test nangles(top) == 0
    @test ndihedrals(top) == 0

    add_bond!(top, 0, 1)
    add_bond!(top, 1, 2)
    add_bond!(top, 2, 3)

    @test nbonds(top) == 3
    @test nangles(top) == 2
    @test ndihedrals(top) == 1

    @test isbond(top, 0, 1) == true
    @test isbond(top, 0, 3) == false
    @test isangle(top, 0, 1, 2) == true
    @test isangle(top, 0, 1, 3) == false
    @test isdihedral(top, 0, 1, 2, 3) == true
    @test isdihedral(top, 0, 1, 3, 2) == false

    top_bonds = reshape(UInt64[0, 1,   1, 2,   2, 3], (2, 3))

    @test bonds(top) == top_bonds
    @test angles(top) == reshape(UInt64[0, 1, 2,   1, 2, 3,], (3, 2))
    @test dihedrals(top) == reshape(UInt64[0, 1, 2, 3], (4,1))

    remove_bond!(top, 2, 3)
    @test nbonds(top) == 2
    @test nangles(top) == 1
    @test ndihedrals(top) == 0

    remove!(top, 3)
    @test natoms(top) == 3
end
