@testset "Atom Type" begin
    a = Atom("He")

    @test_approx_eq_eps mass(a) 4.002602 1e-6
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

    @test_approx_eq_eps vdw_radius(a) 2.1 1e-1
    @test_approx_eq_eps covalent_radius(a) 1.31 1e-2
    @test atomic_number(a) == 30
end
