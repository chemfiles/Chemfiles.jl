"""
Getting all the public functions/constants exported from the Julia API.
"""
import os

ROOT = os.path.dirname(os.path.dirname(os.path.abspath((__file__))))

def all_functions():
    functions = []
    with open(os.path.join(ROOT, "src", "generated", "cdef.jl")) as fd:
        for line in fd:
            line = line.strip()
            if line.startswith("# Function"):
                name = line.split("'")[1]
                functions.append(name)
    return functions
