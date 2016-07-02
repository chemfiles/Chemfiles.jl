# Copyright (c) Guillaume Fraux 2015
#
# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at http://mozilla.org/MPL/2.0/.
export evaluate

function Selection(selection::AbstractString)
    handle = lib.chfl_selection(pointer(selection))
    return Selection(handle)
end

function Base.size(selection::Selection)
    res = Ref{Csize_t}(0)
    check(
        lib.chfl_selection_size(selection.handle, res)
    )
    return res[]
end

function evaluate(selection::Selection, frame::Frame)
    matching = Ref{Csize_t}(0)
    check(
        lib.chfl_selection_evalutate(selection.handle, frame.handle, matching)
    )
    matching = matching[]
    matches = Array(lib.chfl_match_t, matching)
    check(
        lib.chfl_selection_matches(selection.handle, pointer(matches), matching)
    )
    res = []
    selection_size = size(selection)
    for match in matches
        assert(match.size == selection_size)
        if selection_size == 1
            push!(res, match.atoms_1)
        elseif selection_size == 2
            push!(res, (match.atoms_1, match.atoms_2))
        elseif selection_size == 3
            push!(res, (match.atoms_1, match.atoms_2, match.atoms_3))
        elseif selection_size == 4
            push!(res, (match.atoms_1, match.atoms_2, match.atoms_3, match.atoms_4))
        end
    end
    return res
end

function free(selection::Selection)
    lib.chfl_selection_free(selection.handle)
end
