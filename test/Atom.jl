@testset "Atom" begin
    atom = Atom("He")

    @test mass(atom) ≈ 4.002602 atol=1e-6
    @test charge(atom) == 0
    @test name(atom) == "He"
    @test type(atom) == "He"

    set_mass!(atom, 678)
    @test mass(atom) == 678
    set_charge!(atom, -1.5)
    @test charge(atom) == -1.5
    set_name!(atom, "Zn")
    @test name(atom) == "Zn"

    @test fullname(atom) == "Helium"
    set_type!(atom, "Zn")
    @test type(atom) == "Zn"
    @test fullname(atom) == "Zinc"

    @test vdw_radius(atom) ≈ 2.1 atol=1e-1
    @test covalent_radius(atom) ≈ 1.31 atol=1e-2
    @test atomic_number(atom) == 30

    copy = deepcopy(atom)
    @test name(copy) == "Zn"

    set_name!(copy, "I")
    @test name(copy) == "I"
    @test name(atom) == "Zn"
end
