#!/usr/bin/env python
"""
Check that all the functions defined in the C API are
effectively used in the chemfiles binding.
"""
import os
import sys
import re

IGNORED = ["chfl_trajectory_open"]
ERROR = False
ROOT = os.path.join(os.path.dirname(os.path.abspath(__file__)), "..")


def error(message):
    print(message)
    global ERROR
    ERROR = True


def functions_list():
    functions = []
    with open(os.path.join(ROOT, "src", "generated", "cdef.jl")) as fd:
        for line in fd:
            line = line.strip()
            if line.startswith("# Function"):
                name = line.split("'")[1]
                functions.append(name)
    return functions


def read_all_binding_functions():
    binding_functions = set()
    for (dirpath, _, paths) in os.walk(os.path.join(ROOT, "src")):
        for path in paths:
            if path != "cdef.jl" and path.endswith(".jl"):
                with open(os.path.join(ROOT, dirpath, path)) as fd:
                    file_functions = re.findall(r"(chfl_[a-z A-Z 0-9 _]*)\(", fd.read())
                    binding_functions.update(file_functions)
    return binding_functions


def check_functions(functions, binding_functions):
    for function in functions:
        if function not in binding_functions and function not in IGNORED:
            error("Missing: " + function)


if __name__ == '__main__':
    functions = functions_list()
    binding_functions = read_all_binding_functions()
    check_functions(functions, binding_functions)

    if ERROR:
        sys.exit(1)
