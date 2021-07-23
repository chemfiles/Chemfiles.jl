# Chemfiles.jl, a modern library for chemistry file reading and writing
# Copyright (C) Guillaume Fraux and contributors -- BSD license

export ChemfilesError

struct ChemfilesError <: Exception
    message::AbstractString
end

Base.show(io::IO, e::ChemfilesError) = show(io, "Chemfiles error: $(e.message)")

"""
Get the last error message from the chemfiles runtime.
"""
function last_error()
    unsafe_string(lib.chfl_last_error())
end

"""
Clear any error messages stored by the chemfiles runtime.
"""
function clear_errors()
    __check(lib.chfl_clear_errors())
end


# Default to the standard logging infrastructure
function __default_warning_callback(message::String)
    @warn "$message"
end


# Store the warning callback in a global to prevent garbage collection
WARNING_CALLBACK = nothing

function _warning_callback_adaptator(message)
    try
        WARNING_CALLBACK(unsafe_string(message))
    catch error
        @warn "caught $error in warning callback"
    end
end

"""
Set the global warning `callback` to be used for each warning event.

The `callback` function must take a `String` and return nothing.
"""
function set_warning_callback(callback::Function)
    global WARNING_CALLBACK
    WARNING_CALLBACK = callback
    ptr = @cfunction(_warning_callback_adaptator, Cvoid, (Ptr{UInt8},))
    __check(lib.chfl_set_warning_callback(ptr))
end

"""
Read configuration data from the file at `path`.

By default, chemfiles reads configuration from any file name `.chemfilesrc`
in the current directory or any parent directory. This function can be used
to add data from another configuration file.

This function will fail if there is no file at `path`, or if the file is
incorectly formatted. Data from the new configuration file will overwrite
any existing data.
"""
function add_configuration(path::String)
    __check(lib.chfl_add_configuration(pointer(path)))
end

"""
Metadata associated with one of the format Chemfiles can read/write

$(TYPEDFIELDS)
"""
struct FormatMetadata
    """Name of the format"""
    name::String
    """Extension associated with the format, or `nothing` if there is no extension
    associated."""
    extension::Union{String,Nothing}
    """Extended user-facing description of the format"""
    description::String
    """URL pointing to the format definition/reference"""
    reference::String

    """Is reading files in this format implemented?"""
    read::Bool
    """Is writing files in this format implemented?"""
    write::Bool
    """Does this format support in-memory IO?"""
    memory::Bool

    """Does this format support storing atomic positions?"""
    positions::Bool
    """Does this format support storing atomic velocities?"""
    velocities::Bool
    """Does this format support storing unit cell information?"""
    unit_cell::Bool
    """Does this format support storing atom names or types?"""
    atoms::Bool
    """Does this format support storing bonds between atoms?"""
    bonds::Bool
    """Does this format support storing residues?"""
    residues::Bool
end

function Base.show(io::IO, metadata::FormatMetadata)
    print(io, "FormatMetadata(")
    print(io, "name=\"$(metadata.name)\", ")

    if metadata.extension === nothing
        print(io, "extension=nothing, ")
    else
        print(io, "extension=\"$(metadata.extension)\", ")
    end
    print(io, "description=\"$(metadata.description)\", ")
    print(io, "reference=\"$(metadata.reference)\", ")

    print(io, "read=$(metadata.read), "),
    print(io, "write=$(metadata.write), "),
    print(io, "memory=$(metadata.memory), "),
    print(io, "positions=$(metadata.positions), "),
    print(io, "velocities=$(metadata.velocities), "),
    print(io, "unit_cell=$(metadata.unit_cell), "),
    print(io, "atoms=$(metadata.atoms), "),
    print(io, "bonds=$(metadata.bonds), "),
    print(io, "residues=$(metadata.residues)"),

    print(io, ")")
end

function FormatMetadata(metadata::lib.chfl_format_metadata)
    name = unsafe_string(metadata.name)
    if metadata.extension == C_NULL
        extension = nothing
    else
        extension = unsafe_string(metadata.extension)
    end
    description = unsafe_string(metadata.description)
    reference = unsafe_string(metadata.reference)

    return FormatMetadata(
        name,
        extension,
        description,
        reference,
        convert(Bool, metadata.read[]),
        convert(Bool, metadata.write[]),
        convert(Bool, metadata.memory[]),
        convert(Bool, metadata.positions[]),
        convert(Bool, metadata.velocities[]),
        convert(Bool, metadata.unit_cell[]),
        convert(Bool, metadata.atoms[]),
        convert(Bool, metadata.bonds[]),
        convert(Bool, metadata.residues[]),
    )
end

"""
Get the full list of formats supported by Chemfiles, and associated metadata
"""
function format_list()
    metadata = Ref{Ptr{lib.chfl_format_metadata}}()
    count = Ref{UInt64}(0)
    lib.chfl_formats_list(metadata, count)

    all = FormatMetadata[]
    for i in 1:count[]
        push!(all, FormatMetadata(unsafe_load(metadata[], i)))
    end
    lib.chfl_free(Ptr{Cvoid}(metadata[]))
    return all
end

"""
Get the format that chemfiles would use to read a file at the given `path`.

The format is mostly guessed from the path extension, chemfiles only tries to
read the file to distinguish between CIF and mmCIF files. Opening the file using
the returned format string might still fail. For example, it will fail if the
file is not actually formatted according to the guessed format; or the
format/compression combination is not supported (e.g. `XTC / GZ` will not work
since the XTC reader does not support compressed files).

The returned format is represented in a way compatible with the various
`Trajectory` constructors, i.e. `"<format name> [/ <compression>]"`, where
compression is optional.
"""
function guess_format(path::String)
    buffer = repeat("\0", 64)
    lib.chfl_guess_format(pointer(path), pointer(buffer), UInt64(length(buffer)))
    return __strip_null(buffer)
end
