@testset "AtomsBase" begin
    trajectory = Trajectory(joinpath(DATAPATH, "water.xyz"))
    frame = read(trajectory)

    @test positions(frame)[:, 1] == Chemfiles.position(frame)[1]
    @test positions(frame)[:, 1] == Chemfiles.position(frame, 1)
    @test_broken velocities(frame)[:, 1] == Chemfiles.velocity(frame)[1]
    @test_broken velocities(frame)[:, 1] == Chemfiles.velocity(frame, 1)
    
    println(Chemfiles.atomic_number.(identity(frame), 1:5))
end