function testing_frame()
    frame = Frame()
    resize!(frame, 4)

    top = Topology()
    push!(top, Atom("H"))
    push!(top, Atom("O"))
    push!(top, Atom("O"))
    push!(top, Atom("H"))

    add_bond!(top, 0, 1)
    add_bond!(top, 1, 2)
    add_bond!(top, 2, 3)

    set_topology!(frame, top)
    return frame
end


facts("Selection type") do
    frame = testing_frame()
    selection = Selection("name O")
    @fact size(selection) --> 1

    matches = evaluate(selection, frame)
    @fact size(matches, 1) --> 2
    @fact matches[1] --> 1
    @fact matches[2] --> 2

    selection = Selection("bonds: all")
    @fact size(selection) --> 2

    matches = evaluate(selection, frame)
    @fact size(matches, 1) --> 3
    @fact (0, 1) in matches --> true
    @fact (1, 2) in matches --> true
    @fact (2, 3) in matches --> true

    selection = Selection("angles: all")
    @fact size(selection) --> 3

    matches = evaluate(selection, frame)
    @fact size(matches, 1) --> 2
    @fact (0, 1, 2) in matches --> true
    @fact (1, 2, 3) in matches --> true

    selection = Selection("dihedrals: all")
    @fact size(selection) --> 4

    matches = evaluate(selection, frame)
    @fact size(matches, 1) --> 1
    @fact (0, 1, 2, 3) in matches --> true
end
