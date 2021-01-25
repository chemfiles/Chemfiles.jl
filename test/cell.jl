@testset "UnitCell" begin
    cell = UnitCell([5.0, 3.0, 1.0], [110.0, 120.0, 80.0])

    @test lengths(cell) ≈ [5.0, 3.0, 1.0]
    @test angles(cell) ≈ [110.0, 120.0, 80.0]

    cell = UnitCell([2.0, 3.0, 4.0])

    @test lengths(cell) == [2.0, 3.0, 4.0]
    @test angles(cell) == [90.0, 90.0, 90.0]

    @test volume(cell) == 2.0 * 3.0 * 4.0

    set_lengths!(cell, [10.0, 20.0, 30.0])
    @test lengths(cell) == [10.0, 20.0, 30.0]

    remove_chemfiles_warning() do
        @test_throws ChemfilesError set_angles!(cell, [80.0, 89.0, 100.0])
    end

    cell_matrix = [
        10.0 0.0  0.0
        0.0  20.0 0.0
        0.0  0.0  30.0
    ]
    @test matrix(cell) ≈ cell_matrix atol=1e-10

    @test shape(cell) == Chemfiles.Orthorhombic

    set_shape!(cell, Chemfiles.Triclinic)
    @test shape(cell) == Chemfiles.Triclinic

    set_angles!(cell, [80.0, 89.0, 100.0])
    @test angles(cell) == [80.0, 89.0, 100.0]

    copy = deepcopy(cell)
    @test lengths(copy) ≈ [10.0, 20.0, 30.0]

    set_lengths!(copy, [10.0, 10.0, 10.0])
    @test lengths(copy) ≈ [10.0, 10.0, 10.0]
    @test lengths(cell) ≈ [10.0, 20.0, 30.0]

    cell = UnitCell([10.0, 20.0, 30.0])
    @test wrap!(cell, [12.0, 22.0, -5.0]) == [2.0, 2.0, -5.0]

    cell = UnitCell(cell_matrix)
    @test lengths(cell) ≈ [10.0, 20.0, 30.0]
    @test angles(cell) ≈ [90.0, 90.0, 90.0]
end
