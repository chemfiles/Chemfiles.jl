@testset "AtomsBase" begin
    trajectory = Trajectory(joinpath(DATAPATH, "water.xyz"))
    frame = read(trajectory)

    @test positions(frame)[:, 1] == Chemfiles.position(frame)[1]
    @test positions(frame)[:, 1] == Chemfiles.position(frame, 1)
    @test_broken velocities(frame)[:, 1] == Chemfiles.velocity(frame)[1]
    @test_broken velocities(frame)[:, 1] == Chemfiles.velocity(frame, 1)
    @test Chemfiles.atomic_number(frame, 0) == Chemfiles.atomic_number(frame)[1]
    @test Chemfiles.atomic_mass(frame, 0) == Chemfiles.atomic_mass(frame)[1]
    @test Chemfiles.atomic_symbol(frame, 0) == Chemfiles.atomic_symbol(frame)[1]
    println(Chemfiles.bounding_box(frame))
    println(Chemfiles.boundary_conditions(frame))
end