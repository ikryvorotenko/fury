#!/bin/bash
set -e
set -x

source $TESTROOTDIR/tests_lib

fury layer init
fury project add -n webpage
fury module add -n hello-world
fury source add -d wrong_src
fury undo
fury source add -d src
fury source list
fury repo add -u https://github.com/propensive/base.git -n base
fury import add -i base:2.12.6
fury module update -c scala/compiler
fury
fury build save --dir ./

OUTPUT=$(java -cp "$SCALA:webpage-hello-world.jar" "HelloWorld")
EXPECTED="Hello, world!"

if [ "$OUTPUT" !=  "$EXPECTED" ]; then
    echo "ERROR: '$OUTPUT' != '$EXPECTED'"
    exit 1
fi
