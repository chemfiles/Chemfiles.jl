# Chemfiles.jl, a modern library for chemistry file reading and writing
# Copyright (C) Guillaume Fraux and contributors -- BSD license
export evaluate, selection_string

"""
Create a ``Selection`` from a selection string.
"""
function Selection(selection::AbstractString)
    handle = lib.chfl_selection(pointer(selection))
    return Selection(handle)
end

"""
Get the selection string used to create a given ``selection``.
"""
function selection_string(selection::Selection)
    return _call_with_growing_buffer(
        (buffer, size) -> _check(lib.chfl_selection_string(selection.handle, buffer, size))
    )
end

"""
Get the size of a ``selection``, *i.e.* the number of atoms we are selecting
together.
"""
function Base.size(selection::Selection)
    result = Ref{UInt64}(0)
    _check(
        lib.chfl_selection_size(selection.handle, result)
    )
    return result[]
end

"""
Evaluate a ``selection`` on a given ``frame``. This function return a list of
indexes or tuples of indexes of atoms in the frame matching the selection.
"""
function evaluate(selection::Selection, frame::Frame)
    matching = Ref{UInt64}(0)
    _check(
        lib.chfl_selection_evaluate(selection.handle, frame.handle, matching)
    )
    matching = matching[]
    matches = Array{lib.chfl_match}(undef, matching)
    _check(
        lib.chfl_selection_matches(selection.handle, pointer(matches), matching)
    )
    result = []
    selection_size = size(selection)
    for match in matches
        @assert match.size == selection_size
        if selection_size == 1
            push!(result, match.atoms_1)
        elseif selection_size == 2
            push!(result, (match.atoms_1, match.atoms_2))
        elseif selection_size == 3
            push!(result, (match.atoms_1, match.atoms_2, match.atoms_3))
        elseif selection_size == 4
            push!(result, (match.atoms_1, match.atoms_2, match.atoms_3, match.atoms_4))
        end
    end
    return result
end

"""
Free the allocated memory for the ``Selection`` object.
"""
function _free(selection::Selection)
    lib.chfl_selection_free(selection.handle)
end

"""
Make a deep copy of a ``selection``.
"""
function Base.deepcopy(selection::Selection)
    handle = lib.chfl_selection_copy(selection.handle)
    return Selection(handle)
end
