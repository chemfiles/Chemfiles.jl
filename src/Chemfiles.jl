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

    include("utils.jl")

    export Trajectory, Topology, Atom, UnitCell, Frame, Selection, Residue

    function version()
        unsafe_string(lib.chfl_version())
    end

    if !startswith(version(), "0.8")
        error(
            """Chemfiles.jl requires the 0.8 version of libchemfiles, but $(version()) is installed.
            You can try to run Pkg.build(\"Chemfiles\") to update libchemfiles."""
        )
    end

    """
    A ``Trajectory`` represents a simulation file on the hard drive. It can read
    or write one or many ``Frame``s to this file. The file format can be
    automatically determined from the extention, or manually specified.
    Writing to a ``Trajectory`` is buffered, which means that one needs to
    ``close()`` the trajectory and flush the buffer before being able to read the
    file again.
    """
    mutable struct Trajectory
        handle :: Ptr{lib.CHFL_TRAJECTORY}
        function Trajectory(ptr::Ptr{lib.CHFL_TRAJECTORY})
            _check(ptr)
            this = new(ptr)
            finalizer(_free, this)
            return this
        end
    end

    """
    A ``Topology`` describes the organisation of the particles in the system:
    what their names are, how they are bonded together, *etc.* A ``Topology``
    is a list of ``Atom``s in the system, together with the list of bonds between
    the atoms.
    """
    mutable struct Topology
        handle :: Ptr{lib.CHFL_TOPOLOGY}
        function Topology(ptr::Ptr{lib.CHFL_TOPOLOGY})
            _check(ptr)
            this = new(ptr)
            finalizer(_free, this)
            return this
        end
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
    mutable struct Atom
        handle :: Ptr{lib.CHFL_ATOM}
        function Atom(ptr::Ptr{lib.CHFL_ATOM})
            _check(ptr)
            this = new(ptr)
            finalizer(_free, this)
            return this
        end
    end

    """
    A ``UnitCell`` describes the bounding box of a system. It is represented by
    three base vectors of lengths ``a``, ``b`` and ``c``; and the angles
    between these vectors are ``alpha``, ``beta`` and ``gamma``.
    """
    mutable struct UnitCell
        handle :: Ptr{lib.CHFL_CELL}
        function UnitCell(ptr::Ptr{lib.CHFL_CELL})
            _check(ptr)
            this = new(ptr)
            finalizer(_free, this)
            return this
        end
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
    mutable struct Frame
        handle :: Ptr{lib.CHFL_FRAME}
        function Frame(ptr::Ptr{lib.CHFL_FRAME})
            _check(ptr)
            this = new(ptr)
            finalizer(_free, this)
            return this
        end
    end

    """
    A ``Selection`` is used to select a group of atoms. Examples of selections are
    "name H" and "(x < 45 and name O) or name C". See the `full documentation
    <http://chemfiles.org/chemfiles/latest/selections.html>`_ for more
    information about the selection language.
    """
    mutable struct Selection
        handle :: Ptr{lib.CHFL_SELECTION}
        function Selection(ptr::Ptr{lib.CHFL_SELECTION})
            _check(ptr)
            this = new(ptr)
            finalizer(_free, this)
            return this
        end
    end

    """
    A ``Residue`` is a group of atoms belonging to the same logical unit. They
    can be small molecules, amino-acids in a protein, monomers in polymers,
    *etc.*
    """
    mutable struct Residue
        handle :: Ptr{lib.CHFL_RESIDUE}
        function Residue(ptr::Ptr{lib.CHFL_RESIDUE})
            _check(ptr)
            this = new(ptr)
            finalizer(_free, this)
            return this
        end
    end

    """
    A ``Property`` is a generic container for various forms of metadata
    stored for other structures.
    """
    mutable struct Property
        handle :: Ptr{lib.CHFL_PROPERTY}
        function Property(ptr::Ptr{lib.CHFL_PROPERTY})
            _check(ptr)
            this = new(ptr)
            finalizer(_free, this)
            return this
        end
    end

    include("Atom.jl")
    include("Frame.jl")
    include("Topology.jl")
    include("Trajectory.jl")
    include("UnitCell.jl")
    include("Selection.jl")
    include("Residue.jl")
    include("Property.jl")
end
