# Chemharp

[![Build Status](https://travis-ci.org/Luthaf/Chemharp.jl.svg?branch=master)](https://travis-ci.org/Luthaf/Chemharp.jl)
[![Coverage Status](https://coveralls.io/repos/Luthaf/Chemharp.jl/badge.svg?branch=master)](https://coveralls.io/r/Luthaf/Chemharp.jl?branch=master)

This package is aJulia binding for the [Chemharp](https://github.com/Luthaf/Chemharp)
chemistry IO library. It allow you, as a programmer, to read and write chemistry
trajectory files easily, with the same simple interface for all the supported formats.
For more information, please read the [introduction to Chemharp](http://chemharp.readthedocs.org/en/latest/overview.html).

For a list of supported formats, please see the
[documentation](http://chemharp.readthedocs.org/en/latest/formats.html).

## Installation

Only the version 0.4 of julia is supported. The 0.3 version could be supported, but would necessitate some work.

To install, run the following command:
```julia
julia> Pkg.clone("http://github.com/Luthaf/Chemharp.jl")
```

In order to use the Chemharp Julia binding, you will need to compile the C++ Chemharp library
from source. This requires a recent C++ compiler, [cmake](http://cmake.org) and a recent
version of the [boost](http://boost.org/) library. Then, running:
```julia
julia> Pkg.build("Chemharp")
```
at Julia prompt will download an install the C++ library. I plan to add pre-built binaries when
the library will be stable.

## Testing

You can test the Julia interface with:
```julia
julia> Pkg.test("Chemharp")
```

All the tests should pass. If they don't, please open [an issue!](https://github.com/Luthaf/Chemharp.jl/issues/new)

## Documentation

Please see the
[Julia interface](chemharp.readthedocs.org/en/latest/bindings/julia-api.html) section of
the documentation of Chemharp.
