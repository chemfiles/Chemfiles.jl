# Copyright (c) Guillaume Fraux 2015
#
# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at http://mozilla.org/MPL/2.0/.

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
    import .lib: NONE, ERROR, WARNING, INFO, DEBUG, LogLevel
    import .lib: ORTHOROMBIC, TRICLINIC, INFINITE, CellType

    include("errors.jl")

    export Trajectory, Topology, Atom, UnitCell, Frame

    type Trajectory
        handle :: Ptr{lib.CHRP_TRAJECTORY}
        function Trajectory(ptr::Ptr{lib.CHRP_TRAJECTORY})
            check(ptr)
            this = new(ptr)
            finalizer(this, free)
            return this
        end
    end

    type Topology
        handle :: Ptr{lib.CHRP_TOPOLOGY}
        function Topology(ptr::Ptr{lib.CHRP_TOPOLOGY})
            check(ptr)
            this = new(ptr)
            finalizer(this, free)
            return this
        end
    end

    type Atom
        handle :: Ptr{lib.CHRP_ATOM}
        function Atom(ptr::Ptr{lib.CHRP_ATOM})
            check(ptr)
            this = new(ptr)
            finalizer(this, free)
            return this
        end
    end

    type UnitCell
        handle :: Ptr{lib.CHRP_CELL}
        function UnitCell(ptr::Ptr{lib.CHRP_CELL})
            check(ptr)
            this = new(ptr)
            finalizer(this, free)
            return this
        end
    end

    type Frame
        handle :: Ptr{lib.CHRP_FRAME}
        function Frame(ptr::Ptr{lib.CHRP_FRAME})
            check(ptr)
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
