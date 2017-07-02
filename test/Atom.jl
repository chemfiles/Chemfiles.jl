@testset "Atom Type" begin
    a = Atom("He")

    @test mass(a) ≈ 4.002602
    @test charge(a) == 0
    @test name(a) == "He"
    @test atom_type(a) == "He"

    set_mass!(a, 678)
    @test mass(a) == 678
    set_charge!(a, -1.5)
    @test charge(a) == -1.5
    set_name!(a, "Zn")
    @test name(a) == "Zn"

    @test fullname(a) == "Helium"
    set_atom_type!(a, "Zn")
    @test atom_type(a) == "Zn"
    @test fullname(a) == "Zinc"

    @test vdw_radius(a) ≈ 2.1
    @test covalent_radius(a) ≈ 1.31
    @test atomic_number(a) == 30
end
