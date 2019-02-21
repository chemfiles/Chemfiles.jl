#!/usr/bin/env python
"""
Check that alls functions are documented.
"""
import os
import sys

ERROR = False
ROOT = os.path.dirname(os.path.dirname(os.path.abspath((__file__))))


def error(message):
    print(message)
    global ERROR
    ERROR = True


def all_functions():
    functions = []
    for (root, _, pathes) in os.walk(os.path.join(ROOT, "src")):
        for path in pathes:
            if path in ["Property.jl", "utils.jl"]:
                continue
            with open(os.path.join(root, path)) as fd:
                for line in fd:
                    line = line.lstrip()
                    if line.startswith("function"):
                        name = line.split()[1].split("(")[0]
                        if name.startswith("Base."):
                            functions.append(name[5:])
                        elif name.startswith("_"):
                            continue
                        else:
                            functions.append(name)

        return functions


def usage_in_doc():
    usages = []
    for (root, _, pathes) in os.walk(os.path.join(ROOT, "doc", "reference")):
        for path in pathes:
            with open(os.path.join(root, path)) as fd:
                kind = ""
                func = ""
                for line in fd:
                    if line.startswith(".."):
                        func = line.split()[-1]
                        if line.split(":")[1] == "autofunction":
                            usages.append(func)
    return usages


if __name__ == '__main__':
    functions = all_functions()
    docs = usage_in_doc()

    for function in functions:
        if function not in docs:
            error("missing documentation for {}".format(function))
    for function in docs:
        if function not in functions:
            error("documentation for non-existing {}".format(function))
    if ERROR:
        sys.exit(1)
