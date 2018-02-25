@testset "UnitCell type" begin
    cell = UnitCell(5, 3, 1, 110, 120, 80)

    @test lengths(cell) == [5.0, 3.0, 1.0]
    @test angles(cell) == [110.0, 120.0, 80.0]

    cell = UnitCell(2, 3, 4)

    @test lengths(cell) == [2.0, 3.0, 4.0]
    @test angles(cell) == [90.0, 90.0, 90.0]

    @test volume(cell) == 2.0 * 3.0 * 4.0

    set_lengths!(cell, 10, 20, 30)
    @test lengths(cell) == [10.0, 20.0, 30.0]

    # Can not set angles for ORTHORHOMBIC cell
    @test_throws ChemfilesError set_angles!(cell, 80, 89, 100)

    expected = reshape(Float64[10, 0, 0,
                               0, 20, 0,
                               0, 0, 30], (3, 3))
    @test cell_matrix(cell) ≈ expected atol=1e-10

    @test shape(cell) == Chemfiles.ORTHORHOMBIC

    set_shape!(cell, Chemfiles.TRICLINIC)
    @test shape(cell) == Chemfiles.TRICLINIC

    set_angles!(cell, 80, 89, 100)
    @test angles(cell) == [80.0, 89.0, 100.0]

    copy = deepcopy(cell)
    @test lengths(copy) == [10.0, 20.0, 30.0]

    set_lengths!(copy, 10, 10, 10)
    @test lengths(copy) == [10.0, 10.0, 10.0]
    @test lengths(cell) == [10.0, 20.0, 30.0]
end
