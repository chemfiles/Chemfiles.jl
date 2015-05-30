using Clang

CHRP_HEADER = "/usr/local/include/chemharp.h"
OUTPUT = joinpath(dirname(@__FILE__), "..", "src", "generated")

command = wrap_c.init(
    headers = [CHRP_HEADER],
    # index = None,
    common_file="types.jl",
    output_file="cdef.jl",
    output_dir = OUTPUT,
    # clang_args = ASCIIString[],
    # clang_includes = ASCIIString[],
    # clang_diagnostics = true,
    header_wrapped = (header, cursorname) -> (contains(cursorname,"chemharp") ||
                                              contains(cursorname,"config.hpp")),
    header_library = x -> "libchemharp",
    # header_outputfile = None,
    cursor_wrapped = (cursorname,cursor) -> !isempty(cursorname),
    # options = InternalOptions(),
    # rewriter = x->x,
)

run(command)
