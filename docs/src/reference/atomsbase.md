# AtomsBase integration

`Chemfiles` is integrated with the [AtomsBase](https://github.com/JuliaMolSim/AtomsBase.jl)
by means of appropriate `convert` methods as well as respective constructors,
which are listed below. Note that these conversion routines copy data unlike the
majority of functionality in Chemfiles.

If your main interest is in reading structural data from disk, have a look at
[AtomsIO](https://github.com/mfherbst/AtomsIO.jl). This package provides a uniform
interface for reading structural data and exposing them in an `AtomsBase`-compatible
way. Under the hood the package employs a number of parser packages (including Chemfiles)
to support reading / writing a wide range of file formats.

```@autodocs
Modules = [Chemfiles, Base, AtomsBase]
Pages   = ["atomsbase.jl"]
```
