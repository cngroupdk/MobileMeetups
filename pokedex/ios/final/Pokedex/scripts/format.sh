#!/usr/bin/env bash

ROOT=`dirname $0`/..
cd $ROOT

mint run swift-format --in-place --recursive -- \
    ./Pokedex \
    && echo "All done" \
    || (echo "Failed"; exit 1)
