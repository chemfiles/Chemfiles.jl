#!/bin/bash -xe

# Install doc dependencies
cd $TRAVIS_BUILD_DIR
pip install --upgrade --user -r doc/requirements.txt

# Get previous documentation
git clone https://github.com/chemfiles/Chemfiles.jl --branch gh-pages gh-pages
rm -rf gh-pages/.git

# Build documentation
cd doc
make html
rm -rf _build/html/.doctrees/ _build/html/.buildinfo
rm -rf _build/html/_static/bootswatch-2.3.2/ _build/html/_static/bootstrap-2.3.2/
shopt -s extglob
cd _build/html/_static/bootswatch-* && rm -rf !(flatly) && cd -
cd ..

if [[ "$TRAVIS_TAG" != "" ]]; then
    mv doc/_build/html/ gh-pages/$TRAVIS_TAG
else
    rm -rf gh-pages/latest
    mv doc/_build/html/ gh-pages/latest
fi
