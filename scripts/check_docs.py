#!/usr/bin/env python
"""
Check that alls functions are documented.
"""
import os
import sys

from typed_functions import all_functions

ERROR = False
ROOT = os.path.dirname(os.path.dirname(os.path.abspath((__file__))))

def error(message):
    print(message)
    global ERROR
    ERROR = True


def usage_in_doc():
    usages = []
    for (root, _, pathes) in os.walk(os.path.join(ROOT, "doc", "reference")):
        for path in pathes:
            with open(os.path.join(root, path), encoding="latin-1") as fd:
                kind = ""
                func = ""
                for line in fd:
                    if line.startswith(".."):
                        func = line.split()[-1]
                        if line.split(":")[1] == "autofunction" :
                            usages.append(func)
    return usages


if __name__ == '__main__':
    functions = all_functions()
    # We also document the 'chfl_warning_callback' interface as a function
    functions.append("chfl_warning_callback")
    docs = usage_in_doc()

    for function in functions:
        if function not in docs:
            error("missing documentation for {}".format(function))
    for function in docs:
        if function not in functions:
            error("documentation for non-existing {}".format(function))

    if ERROR:
        sys.exit(1)
