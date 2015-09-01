# Chemharp

[![Build Status -- Linux](https://travis-ci.org/Luthaf/Chemharp.jl.svg?branch=master)](https://travis-ci.org/Luthaf/Chemharp.jl)
[![Build status -- Windows](https://ci.appveyor.com/api/projects/status/vyn7bbg7xi8q8093/branch/master?svg=true)](https://ci.appveyor.com/project/Luthaf/chemharp-jl/branch/master)
[![Coverage Status](https://coveralls.io/repos/Luthaf/Chemharp.jl/badge.svg?branch=master)](https://coveralls.io/r/Luthaf/Chemharp.jl?branch=master)

This package is aJulia binding for the [Chemharp](https://github.com/Luthaf/Chemharp)
chemistry IO library. It allow you, as a programmer, to read and write chemistry
trajectory files easily, with the same simple interface for all the supported formats.
For more information, please read the [introduction to Chemharp](http://chemharp.readthedocs.org/en/latest/overview.html).

For a list of supported formats, please see the
[documentation](http://chemharp.readthedocs.org/en/latest/formats.html).

## Documentation

Please see the
[Julia interface](chemharp.readthedocs.org/en/latest/bindings/julia-api.html) section of
the documentation of Chemharp.


## Installation

Only the version 0.4 of julia is supported. The 0.3 version could be supported, but would
necessitate some work.

To install, run the following commands:
```julia
julia> Pkg.clone("http://github.com/Luthaf/Chemharp.jl")

julia> Pkg.build("Chemharp")
```

You can also test the Julia interface with:
```julia
julia> Pkg.test("Chemharp")
```

All the tests should pass. If they don't, please open [an issue!](https://github.com/Luthaf/Chemharp.jl/issues/new)
