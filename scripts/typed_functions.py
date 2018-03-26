"""
Getting all the public functions/constants exported from the Julia API.
"""
import os

ROOT = os.path.dirname(os.path.dirname(os.path.abspath((__file__))))

def all_functions():
    functions = []
    for (root, _, pathes) in os.walk(os.path.join(ROOT, "src")):
        for path in pathes:
            with open(os.path.join(root, path), encoding="latin-1") as fd:
                for line in fd:
                    line = line.lstrip()
                    if line.startswith("function"):
                        name = line.split()[1].split("(")[0]
                        if name.startswith("Base."):
                            functions.append(name[5:])
                        else:
                            functions.append(name)

        return functions
