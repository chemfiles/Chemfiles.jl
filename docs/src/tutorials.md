# Tutorials

This section presents some hand-on tutorials to the chemfiles Julia package. All
the code here is under the [CC-0 Universal
Licence](https://creativecommons.org/publicdomain/zero/1.0/) which means that
you are free to do whatever you want with it (*i.e.* it is Public Domain code)

## Read a single frame

In this tutorials we will read a frame from a trajectory, and print the indexes
of all the atom in the half-space `x < 5`.

We start by `using` the `Chemfiles` package to bring in scope the needed
functions:

```@literalinclude ../examples/indexes.jl 4-5
```

Then we open a Trajectory and read the first frame:

```@literalinclude ../examples/indexes.jl 7-8
```

We can now create a list to store the indices of the atoms with `x < 5`, and get
the positions of the atoms in the frame with the [`positions`](@ref) function

```@literalinclude ../examples/indexes.jl 10-11
```

Iterating through the atoms in the frame, we get the ones matching our
condition. [`size(::Frame)`](@ref) gives the number of atoms in the frame, which
is also the size of the `positions` array. This positions array shape is  `(3,
size(frame))`.

```@literalinclude ../examples/indexes.jl 13-17
```

And finally we can print our results

```@literalinclude ../examples/indexes.jl 19-22
```

```@raw html
<details><summary><a>Click here to see the whole program</a></summary>
```

```@raw latex
The whole code looks like this
```

```@literalinclude ../examples/indexes.jl 4-
```

```@raw html
</details>
```

For more information about reading frame in a trajectory, see the following
functions:

- [`read_step`](@ref) to directly read a given step.
- [`set_cell!(::Trajectory)`](@ref) and [`set_topology!(::Trajectory)`](@ref)
  to specify an unit cell or a topology for all frames in a trajectory.

## Generating a structure

Now that we know how to read frames from a trajectory, let's try to create a new
structure and write it to a file. As previsouly, we start by using the Chemfiles
package

```@literalinclude ../examples/generate.jl 4-5
```

Everything starts in a [`Topology`](@ref). This is the class that defines the
atoms and the connectivity in a system. Here, we add three [`Chemfiles.Atom`](@ref) and
two bonds to create a water molecule.

```@literalinclude ../examples/generate.jl 7-13
```

We can then create a [`Frame`](@ref) corresponding to this topology. We resize
the frame to ensure that the frame and the topology contains the same number of
atoms.

```@literalinclude ../examples/generate.jl 15-17
```

We can then set the atomic positions:

```@literalinclude ../examples/generate.jl 19-22
```

Another possibility is to directly add atoms to the frame. Here we define a
second molecule representing carbon dioxyde. [`add_atom!`](@ref) takes three
arguments: the frame, the atom, and the position of the atom.

```@literalinclude ../examples/generate.jl 24-28
```

Finally, we can set the [`UnitCell`](@ref) associated with this frame.

```@literalinclude ../examples/generate.jl 30-30
```

Now that our frame is constructed, it is time to write it to a file. For that,
we open a trajectory in write (`'w'`) mode, and write to it, using the same
syntax as a standard Julia `open(...) do ... end` block

```@literalinclude ../examples/generate.jl 32-34
```

```@raw html
<details><summary><a>Click here to see the whole program</a></summary>
```

```@raw latex
Wrapping everything up, the whole code looks like this:
```

```@literalinclude ../examples/generate.jl 4-
```

```@raw html
</details>
```

## Using selections

Now that we know how to read and write frame from trajectories, how about we do
a bit a filtering? In this tutorial, we will read all the frames from a file,
and use selections to filter which atoms we will write back to another file.
This example will also show how chemfiles can be used to convert from a file
format to another one.

We start by opening the two trajectories we will need

```@literalinclude ../examples/select.jl 7-8
```

And we create a [`Selection`](@ref) object to filter the atoms we want to
remove.

```@literalinclude ../examples/select.jl 10-10
```

Then we can iterate over all the frames in the trajectory, and use the selection
to get the list of atoms to remove. The result of [`evaluate`](@ref)
is a list containing the atoms matching the selection.

```@literalinclude ../examples/select.jl 12-13
```

In order to remove the atoms from the frame, we need to sort the `to_remove`
list in descending order: removing the atom at index `i` will shift the index of
all the atoms after `i`. So we start from the end and work toward the start of
the frame.

```@literalinclude ../examples/select.jl 14-16
```

Finally, we can write the cleaned frame to the output file, and start the next
iteration.

```@literalinclude ../examples/select.jl 17-18
```

Since we opened the files directly instead of using a `do ... end` block, we hae
to close them to flush all buffers and release file descriptors.

```@literalinclude ../examples/select.jl 20-23
```

```@raw html
<details><summary><a>Click here to see the whole program</a></summary>
```

```@raw latex
The whole program look like this:
```

```@literalinclude ../examples/select.jl 4-
```

```@raw html
</details>
```
