# Chemfiles.jl

[![Build Status -- Linux](https://travis-ci.org/chemfiles/Chemfiles.jl.svg?branch=master)](https://travis-ci.org/chemfiles/Chemfiles.jl)
[![Build status -- Windows](https://ci.appveyor.com/api/projects/status/vyn7bbg7xi8q8093/branch/master?svg=true)](https://ci.appveyor.com/project/Luthaf/chemfiles-jl/branch/master)

This package contains the Julia binding for the
[chemfiles](https://github.com/chemfiles/chemfiles) chemistry IO library. It allow you, as
a programmer, to read and write chemistry trajectory files easily, with the same simple
interface for all the supported formats. For more information, please read the
[introduction to chemfiles](http://chemfiles.readthedocs.org/en/latest/overview.html).

For a list of supported formats, please see the
[documentation](http://chemfiles.readthedocs.org/en/latest/formats.html).

## Documentation

Please see the
[Julia interface](chemfiles.readthedocs.org/projects/chemfiles-julia) section of
the documentation of chemfiles.


## Installation

Only the version 0.4 of julia is supported. The 0.3 version could be supported, but would
necessitate some work.

To install, run the following commands:
```julia
julia> Pkg.clone("http://github.com/chemfiles/Chemfiles.jl")

julia> Pkg.build("Chemfiles")
```

You can also test the Julia interface with:
```julia
julia> Pkg.test("Chemfiles")
```

All the tests should pass. If they don't, please open [an issue!](https://github.com/chemfiles/Chemfiles.jl/issues/new)

## Usage example

Here is a simple usage example for `Chemfiles.jl`. Please see the `examples` folder for
more examples.

```julia
using Chemfiles

trajectory = Trajectory("filename.xyz")
frame = read(trajectory)

println("There are $(natoms(frame)) atoms in the frame")
positions = positions(frame)

# Do awesome things with the positions here !
```

## Bug reports, feature requests

Please report any bug you find and any feature you may want as a [github issue](https://github.com/chemfiles/Chemfiles.jl/issues/new).
