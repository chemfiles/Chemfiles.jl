@testset "Residue type" begin
    residue = Residue("ALA", 4)
    @test name(residue) == "ALA"
    @test id(residue) == 4

    residue = Residue("GUA")
    @test name(residue) == "GUA"
    @test id(residue) == typemax(UInt64)

    @test size(residue) == 0
    add_atom!(residue, 0);
    add_atom!(residue, 56);
    add_atom!(residue, 30);
    @test size(residue) == 3

    add_atom!(residue, 56)
    size(residue) == 3

    @test contains(residue, 56) == true

    # TODO: Test chfl_from_topology
    # top = Topology()
    # push!(top, Atom("H"))
    # push!(top, Atom("O"))
    # push!(top, Atom("Zn"))
    # push!(top, Atom("H"))
    # residue = Residue(top, 3)
end
