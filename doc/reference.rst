.. _julia-api:

Julia interface reference
=========================

The `Julia`_ interface to chemfiles wrap around the C interface providing a
Julian API. All the functionalities are in the ``Chemfiles`` module, which can
be imported by the ``using Chemfiles`` expression. The ``Chemfiles`` module is
built around the main types of chemfiles: `Trajectory`_, `Frame`_, `UnitCell`_,
`Topology`_, `Residue`_, `Atom`_, and `Selection`_.

.. _Julia: http://julialang.org/

.. warning::
   All indexing in chemfiles is 0-based! That means that the first atom in a frame
   have the index 0, not 1. This is because no translation is made from the
   underlying C library.

   This may change in future release to use 1-based indexing, which is more familiar
   to Julia developers.

Error and logging functions
---------------------------

These functions are not exported, and should be called by there fully qualified name:

.. code-block:: julia

    Chemfiles.last_error()
    Chemfiles.set_warning_callback(my_callback)

.. jl:autofunction:: src/errors.jl last_error

.. jl:autofunction:: src/errors.jl clear_errors

.. jl:autofunction:: src/errors.jl set_warning_callback

.. _Trajectory:

``Trajectory`` type and associated functions
--------------------------------------------

.. jl:autotype:: src/Chemfiles.jl Trajectory

.. jl:autofunction:: src/Trajectory.jl Trajectory

.. jl:autofunction:: src/Trajectory.jl read

.. jl:autofunction:: src/Trajectory.jl read!

.. jl:autofunction:: src/Trajectory.jl read_step

.. jl:autofunction:: src/Trajectory.jl read_step!

.. jl:autofunction:: src/Trajectory.jl write

.. jl:autofunction:: src/Trajectory.jl set_topology!

.. jl:autofunction:: src/Trajectory.jl set_cell!

.. jl:autofunction:: src/Trajectory.jl nsteps

.. jl:autofunction:: src/Trajectory.jl close

.. jl:autofunction:: src/Trajectory.jl isopen

.. _Frame:

``Frame`` type and associated functions
---------------------------------------

A `Frame`_ holds data for one step of a simulation. As not all formats provides all
the types of informations, some fields may be initialized to a default value. A
`Frame`_ may contains the following data:

- Positions for all the atoms in the system;
- Velocities for all the atoms in the system;
- The `Topology`_ of the system;
- The `UnitCell`_ of the system.

.. jl:function:: Frame(natoms = 0)

    Create an empty `Frame`_ with initial capacity of ``natoms``. It will be
    automatically resized if needed.

.. jl:function:: size(frame::Frame) -> Integer

    Get the `Frame`_ size, i.e. the current number of atoms

.. jl:function:: resize!(frame::Frame, natoms::Integer)

    Resize the positions and the velocities in `Frame`_, to make space for `natoms`
    atoms. This function may invalidate any pointer to the positions or the
    velocities if the new size is bigger than the old one. In all the cases, previous
    data is conserved. This function conserve the presence or absence of velocities.

.. jl:function:: positions(frame::Frame) -> Array{Float64, 2}

    Get a pointer to the positions in a `Frame`_. The positions are readable and
    writable from this array. If the frame is resized (by writing to it, or calling
    ``resize``), the array is invalidated.

.. jl:function:: velocities(frame::Frame)

    Get a pointer to the velocities in a `Frame`_. The velocities are readable and
    writable from this array. If the frame is resized (by writing to it, or calling
    ``resize``), the array is invalidated.

    If the frame do not have velocity, this will return an error. Use
    ``add_velocities!`` to add velocities to a frame before calling this function.

.. jl:function:: add_velocities!(frame::Frame)

    Add velocities to this `Frame`_. The storage is initialized with the result of
    ``size(frame)`` as number of atoms. If the frame already have velocities, this
    does nothing.

.. jl:function:: add_atom!(frame::Frame, atom::Atom, position::Array{Float64}, velocity::Array{Float64})

    Add an `atom` and the corresponding `position` and `velocity` data to a `frame`.
    `velocity` can be `NULL` if no velocity is associated with the atom.

.. jl:function:: remove_atom!(frame::Frame, index::Integer)

    Remove the `atom` at `index` in the frame.
    This modify all the `atoms` indexes after `index`, and invalidate any pointer
    obtained using `positions`_ or `velocities`_.

.. jl:function:: has_velocities(frame::Frame) -> Bool

    Ask wether this `Frame`_ contains velocity data or not.

.. jl:function:: set_cell!(frame::Frame, cell::UnitCell)

    Set the `UnitCell`_ of a `Frame`_.

.. jl:function:: set_topology!(frame::Frame, topology::Topology)

    Set the `Topology`_ of a `Frame`_.

.. jl:function:: step(frame::Frame) -> Integer

    Get the `Frame`_ step, i.e. the frame number in the trajectory.

.. jl:function:: set_step!(frame::Frame, step)

    Set the `Frame`_ step to ``step``.

.. jl:function:: guess_topology!(frame::Frame)

    Guess the bonds, angles and dihedrals in the system using a distance criteria.

.. _UnitCell:

``UnitCell`` type and associated function
-----------------------------------------

An `UnitCell`_ describe the bounding box of a system. It is represented by three base
vectors of lengthes ``a``, ``b`` and ``c``; and the angles between these vectors are
``alpha``, ``beta`` and ``gamma``.

.. jl:function:: UnitCell(a, b, c, alpha=90, beta=90, gamma=90)

    Create an `UnitCell`_ from the three lenghts and the three angles.

.. jl:function:: UnitCell(frame::Frame)

    Get a copy of the `UnitCell`_ of a frame.

.. jl:function:: lengths(cell::UnitCell) -> (Float64, Float64, Float64)

    Get the three `UnitCell`_ lenghts (a, b and c) in angstroms.

.. jl:function:: set_lengths!(cell::UnitCell, a, b, c)

    Set the `UnitCell`_ lenghts to ``a``, ``b`` and ``c`` in angstroms.

.. jl:function:: angles(cell::UnitCell) -> (Float64, Float64, Float64)

    Get the three `UnitCell`_ angles (alpha, beta and gamma) in degrees.

.. jl:function:: set_angles!(cell::UnitCell, alpha, beta, gamma)

    Set the `UnitCell`_ angles to ``alpha``, ``beta`` and ``gamma`` in degrees.

.. jl:function:: cell_matrix(cell::UnitCell) -> Array{Float64, 2}

    Get the `UnitCell`_ matricial representation, i.e. the representation of the
    three base vectors as::

        | a_x   b_x   c_x |
        |  0    b_y   c_y |
        |  0     0    c_z |

.. jl:function:: type(cell::UnitCell) -> CellType

    Get the `UnitCell`_ type.

.. jl:function:: set_type!(cell::UnitCell, celltype::CellType)

    Set the `UnitCell`_ type to ``celltype``.

The following cell types are defined:

- ``Chemfiles.ORTHORHOMBIC`` : The three angles are 90°
- ``Chemfiles.TRICLINIC`` : The three angles may not be 90°
- ``Chemfiles.INFINITE`` : Cell type when there is no periodic boundary conditions

.. jl:function:: volume(cell::UnitCell) -> Float64

    Get the unit cell volume

.. _Topology:

``Topology`` type and associated function
-----------------------------------------

.. jl:autotype:: src/Chemfiles.jl Topology

.. jl:autofunction:: src/Topology.jl Topology

.. jl:autofunction:: src/Topology.jl size

.. jl:autofunction:: src/Topology.jl add_atom!

.. jl:autofunction:: src/Topology.jl remove!

.. jl:autofunction:: src/Topology.jl isbond

.. jl:autofunction:: src/Topology.jl isangle

.. jl:autofunction:: src/Topology.jl isdihedral

.. jl:autofunction:: src/Topology.jl bonds_count

.. jl:autofunction:: src/Topology.jl angles_count

.. jl:autofunction:: src/Topology.jl dihedrals_count

.. jl:autofunction:: src/Topology.jl bonds

.. jl:autofunction:: src/Topology.jl angles

.. jl:autofunction:: src/Topology.jl dihedrals

.. jl:autofunction:: src/Topology.jl add_bond!

.. jl:autofunction:: src/Topology.jl remove_bond!

.. jl:autofunction:: src/Topology.jl add_residue!

.. jl:autofunction:: src/Topology.jl count_residues

.. jl:autofunction:: src/Topology.jl are_linked

.. jl:autofunction:: src/Topology.jl resize!

.. _Atom:

``Atom`` type and associated function
-------------------------------------

.. jl:autotype:: src/Chemfiles.jl Atom

.. jl:autofunction:: src/Atom.jl Atom

.. jl:autofunction:: src/Atom.jl mass

.. jl:autofunction:: src/Atom.jl set_mass!

.. jl:autofunction:: src/Atom.jl charge

.. jl:autofunction:: src/Atom.jl set_charge!

.. jl:autofunction:: src/Atom.jl name

.. jl:autofunction:: src/Atom.jl set_name!

.. jl:autofunction:: src/Atom.jl fullname

.. jl:autofunction:: src/Atom.jl vdw_radius

.. jl:autofunction:: src/Atom.jl covalent_radius

.. jl:autofunction:: src/Atom.jl atomic_number

.. jl:autofunction:: src/Atom.jl atom_type

.. jl:autofunction:: src/Atom.jl set_atom_type!

.. _Residue:

``Residue`` type and associated function
------------------------------------------

.. jl:autotype:: src/Chemfiles.jl Residue

.. jl:autofunction:: src/Residue.jl Residue

.. jl:autofunction:: src/Residue.jl residue_for_atom

.. jl:autofunction:: src/Residue.jl name

.. jl:autofunction:: src/Residue.jl id

.. jl:autofunction:: src/Residue.jl size

.. jl:autofunction:: src/Residue.jl add_atom!

.. jl:autofunction:: src/Residue.jl contains

.. jl:autofunction:: src/Residue.jl deepcopy

.. _Selection:

``Selection`` type and associated function
------------------------------------------

A `Selection`_ allow to select a group of atoms. Examples of selections are
"name H" and "(x < 45 and name O) or name C". See the `full documentation
<http://chemfiles.readthedocs.io/en/latest/selections.html>`_ for more
information about the selection language.

.. jl:function:: size(selection::Selection) -> Integer

    Get the size of the `Selection`_, *i.e.* the number of atoms we are
    selecting together.

.. jl:function:: evaluate(selection::Selection, frame::Frame) -> Array(Match, 1)

    Evaluate a `Selection`_ on a given `Frame`_. This function return a list of
    indexes or tuples of indexes of atoms in the frame matching the selection.

.. jl:function:: selection_string(selection::Selection)

    Get the selection string used to create a given `selection`.
