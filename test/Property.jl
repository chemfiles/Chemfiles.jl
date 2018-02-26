@testset "Property type" begin
    atom = Atom("")
    set_property!(atom, "test", false)
    @test property(atom, "test") == false

    frame = Frame()
    set_property!(frame, "test", 1234.567)
    @test property(frame, "test") == 1234.567

    set_property!(atom,"test2", "TESTINGTESTING")
    @test property(atom, "test2") == "TESTINGTESTING"

    set_property!(frame, "test2", [1.0,2.0,3.0])
    @test property(frame, "test2") == [1.0,2.0,3.0]

end
