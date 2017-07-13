@testset "Atom Type" begin
    atom = Atom("He")

    @test_approx_eq_eps mass(atom) 4.002602 1e-6
    @test charge(atom) == 0
    @test name(atom) == "He"
    @test atom_type(atom) == "He"

    set_mass!(atom, 678)
    @test mass(atom) == 678
    set_charge!(atom, -1.5)
    @test charge(atom) == -1.5
    set_name!(atom, "Zn")
    @test name(atom) == "Zn"

    @test fullname(atom) == "Helium"
    set_atom_type!(atom, "Zn")
    @test atom_type(atom) == "Zn"
    @test fullname(atom) == "Zinc"

    @test_approx_eq_eps vdw_radius(atom) 2.1 1e-1
    @test_approx_eq_eps covalent_radius(atom) 1.31 1e-2
    @test atomic_number(atom) == 30

    copy = deepcopy(atom)
    @test name(copy) == "Zn"

    set_name!(copy, "I")
    @test name(copy) == "I"
    @test name(atom) == "Zn"
end
