# Chemfiles.jl

[![Build Status -- Linux](https://travis-ci.org/chemfiles/Chemfiles.jl.svg?branch=master)](https://travis-ci.org/chemfiles/Chemfiles.jl)
[![Build status -- Windows](https://ci.appveyor.com/api/projects/status/2v1ert2bktpwpiqo?svg=true)](https://ci.appveyor.com/project/Luthaf/chemfiles-jl)
[![Code coverage](https://codecov.io/github/chemfiles/Chemfiles.jl/coverage.svg?branch=master)](https://codecov.io/github/chemfiles/Chemfiles.jl?branch=master)
[![Documentation](https://img.shields.io/badge/docs-latest-brightgreen.svg)](http://chemfiles.github.io/Chemfiles.jl/)

This package contains the Julia binding for the
[chemfiles](https://github.com/chemfiles/chemfiles) chemistry IO library. It
allow you, as a programmer, to read and write chemistry trajectory files easily,
with the same simple interface for all the supported formats. For more
information, please read the [introduction to
chemfiles](http://chemfiles.github.io/chemfiles/latest/overview.html).

## [Documentation](http://chemfiles.github.io/Chemfiles.jl/)

## Installation

Julia 0.4 and 0.5-dev are supported. The 0.3 version is not.

To install, run the following commands:
```julia
julia> Pkg.add("Chemfiles")
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

Please report any bug you find and any feature you may want as a [github
issue](https://github.com/chemfiles/Chemfiles.jl/issues/new).
