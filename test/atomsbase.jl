@testset "AtomsBase" begin

    trajectory = Trajectory(joinpath(DATAPATH, "Mn3Si.cif"))
    frame = read(trajectory)

    @test positions(frame)[:, 1]*u"Å" == Chemfiles.position(frame)[1]
    @test positions(frame)[:, 1]*u"Å" == Chemfiles.position(frame, 1)
    @test_broken velocities(frame)[:, 1]*u"Å/ps" == Chemfiles.velocity(frame)[1]
    @test_broken velocities(frame)[:, 1]*u"Å/ps" == Chemfiles.velocity(frame, 1)
    @test Chemfiles.atomic_number(frame, 0) == Chemfiles.atomic_number(frame)[1]
    @test Chemfiles.atomic_mass(frame, 0) == Chemfiles.atomic_mass(frame)[1]
    @test Chemfiles.atomic_symbol(frame, 0) == Chemfiles.atomic_symbol(frame)[1]
    @test Chemfiles.bounding_box(frame)[1] == [3.9998697199999995, 0.0, 0.0]*u"Å"
    @test Chemfiles.boundary_conditions(frame) == [Chemfiles.Periodic(), Chemfiles.Periodic(), Chemfiles.Periodic()]
    @test Chemfiles.periodicity(frame) == [true, true, true]
end