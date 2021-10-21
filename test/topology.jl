@testset "Topology" begin
    topology = Topology()
    @test size(topology) == 0

    # Creating some H2O2
    add_atom!(topology, Atom("H"))
    add_atom!(topology, Atom("O"))
    add_atom!(topology, Atom("O"))
    add_atom!(topology, Atom("H"))
    @test size(topology) == 4

    @test name(Atom(topology, 0)) == "H"
    @test name(Atom(topology, 1)) == "O"
    @test name(Atom(topology, 2)) == "O"
    @test name(Atom(topology, 3)) == "H"

    @test bonds_count(topology) == 0
    @test angles_count(topology) == 0
    @test dihedrals_count(topology) == 0

    add_bond!(topology, 0, 1)
    add_bond!(topology, 1, 2)
    add_bond!(topology, 2, 3, Chemfiles.AromaticBond)

    @test bonds_count(topology) == 3
    @test angles_count(topology) == 2
    @test dihedrals_count(topology) == 1

    @test bond_order(topology, 1, 2) == Chemfiles.UnknownBond
    @test bond_order(topology, 2, 3) == Chemfiles.AromaticBond

    @test bond_orders(topology) == [Chemfiles.UnknownBond, Chemfiles.UnknownBond, Chemfiles.AromaticBond]

    top_bonds = reshape(UInt64[0, 1,   1, 2,   2, 3], (2, 3))

    @test bonds(topology) == top_bonds
    @test angles(topology) == reshape(UInt64[0, 1, 2,   1, 2, 3,], (3, 2))
    @test dihedrals(topology) == reshape(UInt64[0, 1, 2, 3], (4,1))

    remove_bond!(topology, 2, 3)
    @test bonds_count(topology) == 2
    @test angles_count(topology) == 1
    @test dihedrals_count(topology) == 0

    clear_bonds!(topology)
    @test bonds_count(topology) == 0

    remove_atom!(topology, 3)
    @test size(topology) == 3

    resize!(topology, 42)
    @test size(topology) == 42

    copy = deepcopy(topology)
    @test size(copy) == 42

    resize!(copy, 25)
    @test size(copy) == 25
    @test size(topology) == 42

    @testset "Residues" begin
        topology = Topology()
        for i = 1:10
            add_atom!(topology, Atom("X"))
        end

        for atoms in [[2,3,6], [0,1,9], [4,5,8]]
            residue = Residue("X")
            for i in atoms
                add_atom!(residue, i)
            end
            add_residue!(topology, residue)
        end

        @test count_residues(topology) == 3

        first = residue_for_atom(topology, 2)
        second = residue_for_atom(topology, 0)

        @test residue_for_atom(topology, 7) === nothing

        @test first !== nothing
        @test second !== nothing
        remove_chemfiles_warning() do
            @test_throws ChemfilesError Residue(topology, 4)
        end

        @test are_linked(topology, first, second) == false

        add_bond!(topology, 6, 9)
        @test are_linked(topology, first, second) == true
    end

    @testset "Impropers" begin
        topology = Topology()
        add_atom!(topology, Atom("N"))
        add_atom!(topology, Atom("H"))
        add_atom!(topology, Atom("H"))
        add_atom!(topology, Atom("H"))

        add_bond!(topology, 0, 1)
        add_bond!(topology, 0, 2)
        add_bond!(topology, 0, 3)

        @test impropers_count(topology) == 1
        @test impropers(topology) == reshape(UInt64[1, 0, 2, 3], (4,1))
    end

    @testset "Topology indexing" begin
        topology = Topology()
        add_atom!(topology, Atom("N"))
        add_atom!(topology, Atom("H"))

        @test name(topology[0]) == "N"
        @test name(topology[1]) == "H"
    end
end
