# Chemfiles.jl, a modern library for chemistry file reading and writing
# Copyright (C) Guillaume Fraux and contributors -- BSD license

export bonds_count, angles_count, dihedrals_count, impropers_count
export bonds, angles, dihedrals, impropers
export add_bond!, remove_bond!, clear_bonds!, bond_order, bond_orders
export add_residue!, residues, are_linked, count_residues

__ptr(topology::Topology) = __ptr(topology.__handle)
__const_ptr(topology::Topology) = __const_ptr(topology.__handle)

"""
Possible bond orders in Chemfiles:
    - `Chemfiles.UnknownBond`: when the bond order is not specified
    - `Chemfiles.SingleBond`: for single bonds
    - `Chemfiles.DoubleBond`: for double bonds
    - `Chemfiles.TripleBond`: for triple bonds
    - `Chemfiles.QuadrupleBond`: for quadruple bonds (present in some metals)
    - `Chemfiles.QuintupletBond`: for qintuplet bonds (present in some metals)
    - `Chemfiles.AmideBond`: for amide bonds
    - `Chemfiles.AromaticBond`: for aromatic bonds
"""
@enum BondOrder begin
    UnknownBond = lib.CHFL_BOND_UNKNOWN
    SingleBond = lib.CHFL_BOND_SINGLE
    DoubleBond = lib.CHFL_BOND_DOUBLE
    TripleBond = lib.CHFL_BOND_TRIPLE
    QuadrupleBond = lib.CHFL_BOND_QUADRUPLE
    QuintupletBond = lib.CHFL_BOND_QUINTUPLET
    AmideBond = lib.CHFL_BOND_AMIDE
    AromaticBond = lib.CHFL_BOND_AROMATIC
end

"""
Create an empty `Topology`.
"""
function Topology()
    ptr = @__check_ptr(lib.chfl_topology())
    return Topology(CxxPointer(ptr, is_const=false))
end

"""
Get a copy of the `Topology` of the given `frame`.
"""
function Topology(frame::Frame)
    ptr = @__check_ptr(lib.chfl_topology_from_frame(__const_ptr(frame)))
    topology = Topology(CxxPointer(ptr, is_const=true))
    copy = deepcopy(topology)
    finalize(topology)
    return copy
end

"""
Get the `Topology` size, i.e. the current number of atoms.
"""
function Base.size(topology::Topology)
    count = Ref{UInt64}(0)
    __check(lib.chfl_topology_atoms_count(
        __const_ptr(topology), count
    ))
    return Int(count[])
end

"""
Add an `atom` at the end of a `topology`.
"""
function add_atom!(topology::Topology, atom::Atom)
    __check(lib.chfl_topology_add_atom(__ptr(topology), __const_ptr(atom)))
    return nothing
end

"""
Remove the atom at the given `index` from a `topology`.
"""
function remove_atom!(topology::Topology, index::Integer)
    __check(lib.chfl_topology_remove(__ptr(topology), UInt64(index)))
    return nothing
end

"""
Get the number of bonds in the `topology`.
"""
function bonds_count(topology::Topology)
    count = Ref{UInt64}(0)
    __check(lib.chfl_topology_bonds_count(__const_ptr(topology), count))
    return Int(count[])
end

"""
Get the number of angles in the `topology`.
"""
function angles_count(topology::Topology)
    count = Ref{UInt64}(0)
    __check(lib.chfl_topology_angles_count(__const_ptr(topology), count))
    return Int(count[])
end

"""
Get the number of dihedral angles in the `topology`.
"""
function dihedrals_count(topology::Topology)
    count = Ref{UInt64}(0)
    __check(lib.chfl_topology_dihedrals_count(__const_ptr(topology), count))
    return Int(count[])
end

"""
Get the number of improper angles in the `topology`.
"""
function impropers_count(topology::Topology)
    count = Ref{UInt64}(0)
    __check(lib.chfl_topology_impropers_count(__const_ptr(topology), count))
    return Int(count[])
end

"""
Get the bonds in the `topology`, in a `2 x bonds_count(topology)` array.
"""
function bonds(topology::Topology)
    count = UInt64(bonds_count(topology))
    result = Array{UInt64}(undef, 2, count)
    __check(lib.chfl_topology_bonds(__const_ptr(topology), pointer(result), count))
    return result
end

"""
Get the angles in the `topology`, in a `3 x angles_count(topology)` array.
"""
function angles(topology::Topology)
    count = UInt64(angles_count(topology))
    result = Array{UInt64}(undef, 3, count)
    __check(lib.chfl_topology_angles(__const_ptr(topology), pointer(result), count))
    return result
end

"""
Get the dihedral angles in the `topology`, in a `4 x dihedrals_count(topology)`
array.
"""
function dihedrals(topology::Topology)
    count = UInt64(dihedrals_count(topology))
    result = Array{UInt64}(undef, 4, count)
    __check(lib.chfl_topology_dihedrals(__const_ptr(topology), pointer(result), count))
    return result
end

"""
Get the improper angles in the `topology`, in a `4 x impropers_count(topology)`
array.
"""
function impropers(topology::Topology)
    count = UInt64(impropers_count(topology))
    result = Array{UInt64}(undef, 4, count)
    __check(lib.chfl_topology_impropers(__const_ptr(topology), pointer(result), count))
    return result
end

"""
Add a bond between the atoms `i` and `j` in the `topology`, optionaly
setting the bond `order`.
"""
function add_bond!(topology::Topology, i::Integer, j::Integer, order=nothing)
    if order === nothing
        __check(lib.chfl_topology_add_bond(__ptr(topology), UInt64(i), UInt64(j)))
    else
        # Check that the order is a valid BondOrder
        order = BondOrder(Integer(order))
        __check(lib.chfl_topology_bond_with_order(
            __ptr(topology), UInt64(i), UInt64(j), lib.chfl_bond_order(order)
        ))
    end
    return nothing
end

"""
Remove any existing bond between the atoms `i` and `j` in the `topology`.
"""
function remove_bond!(topology::Topology, i::Integer, j::Integer)
    __check(lib.chfl_topology_remove_bond(
        __ptr(topology), UInt64(i), UInt64(j)
    ))
    return nothing
end

"""
Remove all bonds, angles and dihedral angles from this `Topology`.
"""
function clear_bonds!(topology::Topology)
    __check(lib.chfl_topology_clear_bonds(__ptr(topology)))
    return nothing
end

"""
Get the `BondOrder` for the bond between atoms `i` and `j` in the
`topology`.
"""
function bond_order(topology::Topology, i::Integer, j::Integer)
    order = Ref{lib.chfl_bond_order}(lib.CHFL_BOND_UNKNOWN)
    __check(lib.chfl_topology_bond_order(
        __const_ptr(topology), UInt64(i), UInt64(j), order
    ))
    return BondOrder(order[])
end

"""
Get the `BondOrder` for all the bonds in the `topology`.
"""
function bond_orders(topology::Topology)
    count = UInt64(bonds_count(topology))
    result = Array{lib.chfl_bond_order}(undef, count)
    __check(lib.chfl_topology_bond_orders(
        __const_ptr(topology), pointer(result), count
    ))
    return map(BondOrder, result)
end

"""
Add a copy of `residue` to this `topology`.

The residue id must not already be in the topology, and the residue must
contain only atoms that are not already in another residue.
"""
function add_residue!(topology::Topology, residue::Residue)
    __check(lib.chfl_topology_add_residue(
        __ptr(topology), __const_ptr(residue)
    ))
    return nothing
end

"""
Get the number of residues in the `topology`.
"""
function count_residues(topology::Topology)
    count = Ref{UInt64}(0)
    __check(lib.chfl_topology_residues_count(
        __const_ptr(topology), count
    ))
    return Int(count[])
end

"""
Check if the two residues `first` and `second` from the `topology` are
linked together, *i.e.* if there is a bond between one atom in the first
residue and one atom in the second one.
"""
function are_linked(topology::Topology, first::Residue, second::Residue)
    result = Ref{UInt8}(0)
    __check(lib.chfl_topology_residues_linked(
        __const_ptr(topology), __const_ptr(first), __const_ptr(second), result
    ))
    return convert(Bool, result[])
end

"""
Resize the `topology` to hold `natoms` atoms. If the new number of atoms is
bigger than the current number, new atoms will be created with an empty name
and type.

If it is lower than the current number of atoms, the last atoms will be removed,
together with the associated bonds, angles and dihedrals.
"""
function Base.resize!(topology::Topology, size::Integer)
    __check(lib.chfl_topology_resize(
        __ptr(topology), UInt64(size)
    ))
end

"""
Make a deep copy of a `topology`.
"""
function Base.deepcopy(topology::Topology)
    ptr = lib.chfl_topology_copy(__const_ptr(topology))
    return Topology(CxxPointer(ptr, is_const=false))
end

# Indexing support
Base.getindex(topology::Topology, index::Integer) = Atom(topology, index)
