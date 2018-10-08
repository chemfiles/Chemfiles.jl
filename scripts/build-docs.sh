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
rm -rf _build/html/_static/bootswatch-* _build/html/_static/bootstrap-2.3.2

cd ../gh-pages

# Copy the right directory
if [[ "$TRAVIS_TAG" != "" ]]; then
    mv ../doc/_build/html/ $TRAVIS_TAG
else
    rm -rf latest
    mv ../doc/_build/html/ latest
fi
