
facts("Atom type") do
    a = Atom("He")

    @fact mass(a) => roughly(4.002602)
    @fact charge(a) => 0
    @fact name(a) => "He"

    setmass!(a, 678)
    @fact mass(a) => 678
    setcharge!(a, -1.5)
    @fact charge(a) => -1.5
    setname!(a, "Zn")
    @fact name(a) => "Zn"

    @fact fullname(a) => "Zinc"
    @fact vdw_radius(a) => roughly(2.1)
    @fact covalent_radius(a) => roughly(1.31)
    @fact atomic_number(a) => 30
end
