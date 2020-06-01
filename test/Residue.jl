@testset "Residue" begin
    residue = Residue("ALA", 4)
    @test name(residue) == "ALA"
    @test id(residue) == 4

    residue = Residue("GUA")
    @test name(residue) == "GUA"

    remove_chemfiles_warning() do
        @test_throws ChemfilesError id(residue)
    end

    @test size(residue) == 0
    add_atom!(residue, 0);
    add_atom!(residue, 56);
    add_atom!(residue, 30);
    @test size(residue) == 3

    add_atom!(residue, 56)
    size(residue) == 3

    @test Chemfiles.contains(residue, 56) == true

    topology = Topology()
    @test count_residues(topology) == 0

    remove_chemfiles_warning() do
        @test_throws ChemfilesError Residue(topology, 3)
    end

    add_residue!(topology, residue)
    residue = Residue(topology, 0)
    @test size(residue) == 3

    copy = deepcopy(residue)
    @test size(copy) == 3

    add_atom!(copy, 42)
    @test size(copy) == 4
    @test size(residue) == 3
end
