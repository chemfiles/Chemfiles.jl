#!/bin/bash -xe

cd $TRAVIS_BUILD_DIR

# Install doc dependencies
julia --check-bounds=yes --inline=no -e 'using Pkg; Pkg.add("Documenter");'

# Get previous documentation
git clone https://github.com/chemfiles/Chemfiles.jl --branch gh-pages gh-pages
rm -rf gh-pages/.git

# Build documentation
julia docs/make.jl

if [[ "$TRAVIS_TAG" != "" ]]; then
    mv docs/build/ gh-pages/$TRAVIS_TAG
else
    rm -rf gh-pages/latest
    mv docs/build/ gh-pages/latest
fi
