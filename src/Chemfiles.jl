# Chemfiles.jl, a modern library for chemistry file reading and writing
# Copyright (C) Guillaume Fraux and contributors -- BSD license

module Chemfiles
    module lib
        const ROOT = dirname(@__FILE__)
        const depsfile = normpath(joinpath(ROOT, "..", "deps", "deps.jl"))
        if isfile(depsfile)
            include(depsfile)
        else
            error("Chemfiles is not installed (the '$depsfile' file is missing).\nPlease run Pkg.build(\"Chemfiles\")")
        end
        include("generated/types.jl")
        include("generated/cdef.jl")
    end

    include("misc.jl")
    include("utils.jl")

    export Trajectory, Topology, Atom, UnitCell, Frame, Selection, Residue

    function version()
        unsafe_string(lib.chfl_version())
    end

    """
    A ``Property`` is a generic container for various forms of metadata
    stored for other structures.
    """
    struct Property
        __handle :: CxxPointer{lib.CHFL_PROPERTY}
    end

    """
    An ``Atom`` is a particle in the current ``Frame``.

    An atom stores the following atomic properties:
      - atom name
      - atom type
      - atom mass
      - atom charge

    The atom name is usually an unique identifier ("H1", "C_a") while the atom
    type will be shared among all particles of the same type: "H", "Ow", "CH3".
    """
    struct Atom
        __handle :: CxxPointer{lib.CHFL_ATOM}
    end

    """
    A ``Residue`` is a group of atoms belonging to the same logical unit. They
    can be small molecules, amino-acids in a protein, monomers in polymers,
    *etc.*
    """
    struct Residue
        __handle :: CxxPointer{lib.CHFL_RESIDUE}
    end

    """
    A ``Topology`` describes the organisation of the particles in the system:
    what their names are, how they are bonded together, *etc.* A ``Topology``
    is a list of ``Atoms`` in the system, together with the list of bonds
    between the atoms.
    """
    struct Topology
        __handle :: CxxPointer{lib.CHFL_TOPOLOGY}
    end

    """
    A ``UnitCell`` describes the bounding box of a system. It is represented by
    three base vectors of lengths ``a``, ``b`` and ``c``; and the angles
    between these vectors are ``alpha``, ``beta`` and ``gamma``.
    """
    struct UnitCell
        __handle :: CxxPointer{lib.CHFL_CELL}
    end

    """
    A ``Frame`` holds data for one step of a simulation. As not all formats
    provide all the types of information, some fields may be initialized to a
    default value. A ``Frame`` may contain the following data:

    - Positions for all the atoms in the system;
    - Velocities for all the atoms in the system;
    - The ``Topology`` of the system;
    - The ``UnitCell`` of the system.
    """
    struct Frame
        __handle :: CxxPointer{lib.CHFL_FRAME}
    end

    """
    A ``Selection`` is used to select a group of atoms. Examples of selections are
    "name H" and "(x < 45 and name O) or name C". See the `full documentation
    <http://chemfiles.org/chemfiles/latest/selections.html>`_ for more
    information about the selection language.
    """
    struct Selection
        __handle :: CxxPointer{lib.CHFL_SELECTION}
    end

    """
    A ``Trajectory`` represents a simulation file on the hard drive. It can read
    or write one or many ``Frame``s to this file. The file format can be
    automatically determined from the extention, or manually specified.
    Writing to a ``Trajectory`` is buffered, which means that one needs to
    ``close()`` the trajectory and flush the buffer before being able to read the
    file again.
    """
    struct Trajectory
        __handle :: CxxPointer{lib.CHFL_TRAJECTORY}
    end

    include("Property.jl")
    include("Atom.jl")
    include("Residue.jl")
    include("Topology.jl")
    include("UnitCell.jl")
    include("Frame.jl")
    include("Selection.jl")
    include("Trajectory.jl")

    function __init__()
        if !startswith(version(), "0.9")
            error(
                """Chemfiles.jl requires the 0.9 version of libchemfiles,
                but $(version()) is installed. You can try to run
                Pkg.build(\"Chemfiles\") to update libchemfiles."""
            )
        end
        set_warning_callback(__default_warning_callback)
    end
end
