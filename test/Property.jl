@testset "Property type" begin
    atom = Atom("")
    set_property!(atom, "test", false)
    @test property(atom, "test") == false

    frame = Frame()
    set_property!(frame, "test", 1234.567)
    @test property(frame, "test") == 1234.567

    set_property!(atom, "test2", "TESTINGTESTING")
    @test property(atom, "test2") == "TESTINGTESTING"

    set_property!(frame, "test2", [1.0,2.0,3.0])
    @test property(frame, "test2") == [1.0,2.0,3.0]

    lipsum = "Enim possimus non tenetur laborum. Quo ut
    reiciendis in at suscipit in nulla quas. Eos minus animi quis quo enim
    facilis dolores quo.

    Iusto incidunt molestiae distinctio cum officia cupiditate tempore qui. Sunt
    error voluptatibus reprehenderit rerum aut a. Earum illum asperiores est
    accusamus illo sit.

    Magni incidunt enim nam. Nisi adipisci harum corrupti reprehenderit nihil.
    Voluptatem aut non labore et sint nesciunt qui. Perspiciatis atque laborum
    aut."
    set_property!(atom, "very long", lipsum)
    @test property(atom, "very long") == lipsum
end
