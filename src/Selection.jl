# Chemfiles.jl, a modern library for chemistry file reading and writing
# Copyright (C) Guillaume Fraux and contributors -- BSD license

export evaluate, selection_string

__ptr(selection::Selection) = __ptr(selection.__handle)
__const_ptr(selection::Selection) = __const_ptr(selection.__handle)

"""
Create a ``Selection`` from a selection string.
"""
function Selection(selection::AbstractString)
    ptr = @__check_ptr(lib.chfl_selection(pointer(selection)))
    return Selection(CxxPointer(ptr, is_const=false))
end

"""
Get the selection string used to create a given ``selection``.
"""
function selection_string(selection::Selection)
    return __call_with_growing_buffer(
        (buffer, size) -> __check(lib.chfl_selection_string(
            __const_ptr(selection), buffer, size
        ))
    )
end

"""
Get the size of a ``selection``, *i.e.* the number of atoms we are selecting
together.
"""
function Base.size(selection::Selection)
    result = Ref{UInt64}(0)
    __check(lib.chfl_selection_size(__const_ptr(selection), result))
    return result[]
end

"""
Evaluate a ``selection`` on a given ``frame``. This function return a list of
indexes or tuples of indexes of atoms in the frame matching the selection.
"""
function evaluate(selection::Selection, frame::Frame)
    # Get the number of matching atoms
    count = Ref{UInt64}(0)
    __check(lib.chfl_selection_evaluate(__ptr(selection), __const_ptr(frame), count))
    count = count[]
    # Allocate memory and get matching atoms
    matches = Array{lib.chfl_match}(undef, count)
    __check(lib.chfl_selection_matches(__ptr(selection), pointer(matches), count))
    # Return a clearer array of tuples
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
Make a deep copy of a ``selection``.
"""
function Base.deepcopy(selection::Selection)
    ptr = lib.chfl_selection_copy(__const_ptr(selection))
    return Selection(CxxPointer(ptr, is_const=false))
end
