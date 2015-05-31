
facts("UnitCell type") do
    cell = UnitCell(2, 3, 4)

    @pending lengths(cell) => Float64[2, 3, 4]
    @pending angles(cell) => Float64[90, 90, 90]

    set_lengths!(cell, 10, 20, 30)
    @pending lengths(cell) => Float64[10, 20, 30]

    # Can not set angles for ORTHOROMBIC cell
    @fact_throws set_angles!(cell, 80, 89, 100)

    mat = reshape(Float64[10, 0, 0,
                          0, 20, 0,
                          0, 0, 30], (3, 3))
    @fact cell_matrix(cell) => roughly(mat, 1e-10)

    @fact cell_type(cell) => Chemharp.ORTHOROMBIC

    set_cell_type!(cell, Chemharp.TRICLINIC)
    @fact cell_type(cell) => Chemharp.TRICLINIC

    set_angles!(cell, 80, 89, 100)
    @pending angles(cell) => Float64[80, 89, 100]

    @fact periodicity(cell) => [true, true, true]
    set_periodicity!(cell, false, true, false)
    @fact periodicity(cell) => [false, true, false]
end
