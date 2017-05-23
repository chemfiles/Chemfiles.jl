
facts("Atom type") do
    a = Atom("He")

    @fact mass(a) --> roughly(4.002602, 1e-6)
    @fact charge(a) --> 0
    @fact name(a) --> "He"
    @fact atom_type(a) --> "He"

    set_mass!(a, 678)
    @fact mass(a) --> 678
    set_charge!(a, -1.5)
    @fact charge(a) --> -1.5
    set_name!(a, "Zn")
    @fact name(a) --> "Zn"

    @fact fullname(a) --> "Helium"
    set_atom_type!(a, "Zn")
    @fact atom_type(a) --> "Zn"
    @fact fullname(a) --> "Zinc"

    @fact vdw_radius(a) --> roughly(2.1, 1e-1)
    @fact covalent_radius(a) --> roughly(1.31, 1e-2)
    @fact atomic_number(a) --> 30
end
