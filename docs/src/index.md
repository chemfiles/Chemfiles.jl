# Julia interface to chemfiles

This is the documentation for the [Julia](http://julialang.org/) interface to
the [chemfiles](https://chemfiles.org/) library.

The Julia interface to chemfiles wraps around the C interface providing a Julian
API. All the functionalities are in the `Chemfiles` module, which can be
imported by the `using Chemfiles` expression. The `Chemfiles` module is built
around the main types of chemfiles: [`Trajectory`](@ref), [`Frame`](@ref),
[`UnitCell`](@ref), [`Topology`](@ref), [`Residue`](@ref),
[`Chemfiles.Atom`](@ref), and [`Selection`](@ref).

Note that chemfiles integrates with the
[AtomsBase](https://github.com/JuliaMolSim/AtomsBase.jl) ecosystem via
appropriate conversion routines. See [AtomsBase integration](@ref) for more
details.

!!! warning

    All indexing in chemfiles is 0-based! That means that the first atom in a
    frame have the index 0, not 1. This is because no translation is made from
    the underlying C library.

    This may change in future release to use 1-based indexing, which is more
    familiar to Julia developers.

## Installation

You will need to use a recent version of Julia (`Julia >= 1.0`), and then you
can install the `Chemfiles` package by running the following at Julia prompt:

```julia
pkg> add Chemfiles

# You may also want to run the test suite with
pkg> test Chemfiles
```

## User documentation

This section contains example of how to use `Chemfiles.jl`, and the complete
interface reference for all the types and functions in chemfiles.

```@contents
Pages = [
    "reference/trajectory.md",
    "reference/frame.md",
    "reference/atom.md",
    "reference/cell.md",
    "reference/topology.md",
    "reference/residue.md",
    "reference/selection.md",
    "reference/misc.md",
    "reference/atomsbase.md"
]
```
