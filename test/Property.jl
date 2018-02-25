@testset "Property type" begin
    prop = Property(false)
    @test kind(prop).value == Chemfiles.PROPERTY_BOOL.value
    @test get_bool(prop) == false
    @test_throws ChemfilesError get_double(prop)
    @test_throws ChemfilesError get_string(prop)
    @test_throws ChemfilesError get_vector3d(prop)

    atom = Atom("")
    set_property!(atom, "test", prop)
    @test get_bool(get_property(atom, "test")) == false

    prop = Property(1234.567)
    @test kind(prop).value == Chemfiles.PROPERTY_DOUBLE.value
    @test get_double(prop) == 1234.567
    @test_throws ChemfilesError get_bool(prop)
    @test_throws ChemfilesError get_string(prop)
    @test_throws ChemfilesError get_vector3d(prop)

    frame = Frame()
    set_property!(frame, "test", prop)
    @test get_double(get_property(frame, "test")) == 1234.567

    prop = Property("TESTINGTESTING")
    @test kind(prop).value == Chemfiles.PROPERTY_STRING.value
    @test get_string(prop) == "TESTINGTESTING"
    @test_throws ChemfilesError get_double(prop)
    @test_throws ChemfilesError get_bool(prop)
    @test_throws ChemfilesError get_vector3d(prop)

    prop = Property([1.0,2.0,3.0])
    @test kind(prop).value == Chemfiles.PROPERTY_VECTOR3D.value
    @test get_vector3d(prop) == [1.0,2.0,3.0]
    @test_throws ChemfilesError get_double(prop)
    @test_throws ChemfilesError get_string(prop)
    @test_throws ChemfilesError get_bool(prop)

end
