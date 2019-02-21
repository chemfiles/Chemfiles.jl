@testset "Property type" begin
    atom = Atom("")
    set_property!(atom, "test", false)
    @test property(atom, "test") == false
    set_property!(atom, "bar", 3.4)
    @test properties_count(atom) == 2
    @test Set(list_properties(atom)) == Set(["bar", "test"])

    residue = Residue("")
    set_property!(residue, "test", false)
    @test property(residue, "test") == false
    @test properties_count(residue) == 1
    @test list_properties(residue) == ["test"]

    frame = Frame()
    set_property!(frame, "test", 1234.567)
    @test property(frame, "test") == 1234.567

    set_property!(frame, "test2", "TESTINGTESTING")
    @test property(frame, "test2") == "TESTINGTESTING"

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
    set_property!(frame, "very long", lipsum)
    @test property(frame, "very long") == lipsum
    @test properties_count(frame) == 3
    @test Set(list_properties(frame)) == Set(["very long", "test2", "test"])
end
