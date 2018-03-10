#!/usr/bin/env python
"""
Check that all the functions defined in the C API are effectivelly used
"""
import os
import sys

IGNORED = ["chfl_trajectory_open"]
ROOT = os.path.dirname(os.path.dirname(__file__))
ERROR = False


def functions_list():
    functions = []
    with open(os.path.join(ROOT, "src", "generated", "cdef.jl")) as fd:
        for line in fd:
            line = line.strip()
            if line.startswith("# Function"):
                name = line.split("'")[1]
                functions.append(name)
    return functions


def read_all_source():
    source = ""
    for (dirpath, _, pathes) in os.walk(os.path.join(ROOT, "src")):
        for path in pathes:
            if path != "cdef.jl" and path.endswith(".jl"):
                with open(os.path.join(ROOT, dirpath, path)) as fd:
                    source += fd.read()
    return source


def check_functions(functions, source):
    for function in functions:
        if function not in source and function not in IGNORED:
            print("Missing: " + function)
            global ERROR
            ERROR = True


if __name__ == '__main__':
    functions = functions_list()
    source = read_all_source()
    check_functions(functions, source)
    if ERROR:
        sys.exit(1)
