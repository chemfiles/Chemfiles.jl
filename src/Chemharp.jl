module Chemharp

    module lib
        module deps
            using BinDeps
            @BinDeps.load_dependencies
        end
        # Extract the library path
        const libchemharp = deps.libchemharp[1][2]

        include("generated/types.jl")
        include("generated/cdef.jl")
    end
    import .lib: NONE, ERROR, WARNING, INFO, DEBUG
    import .lib: ORTHOROMBIC, TRICLINIC, INFINITE

    include("errors.jl")

    export Trajectory, Topology, Atom, UnitCell, Frame

    type Trajectory
        handle :: Ptr{lib.CHRP_TRAJECTORY}
        function Frame(ptr::Ptr{lib.CHRP_TRAJECTORY})
            this = new(ptr)
            finalizer(this, free)
            return this
        end
    end

    type Topology
        handle :: Ptr{lib.CHRP_TOPOLOGY}
        function Frame(ptr::Ptr{lib.CHRP_TOPOLOGY})
            this = new(ptr)
            finalizer(this, free)
            return this
        end
    end

    type Atom
        handle :: Ptr{lib.CHRP_ATOM}
        function Atom(ptr::Ptr{lib.CHRP_ATOM})
            this = new(ptr)
            finalizer(this, free)
            return this
        end
    end

    type UnitCell
        handle :: Ptr{lib.CHRP_CELL}
        function Frame(ptr::Ptr{lib.CHRP_CELL})
            this = new(ptr)
            finalizer(this, free)
            return this
        end
    end

    type Frame
        handle :: Ptr{lib.CHRP_FRAME}
        function Frame(ptr::Ptr{lib.CHRP_FRAME})
            this = new(ptr)
            finalizer(this, free)
            return this
        end
    end

    include("Atom.jl")
    include("Frame.jl")
    include("Topology.jl")
    include("Trajectory.jl")
    include("UnitCell.jl")
end
