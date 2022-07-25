import std/unittest
import std/streams

import clsl
import clsl/private/binarydumping
import clsl/private/extraction

import ../compiler/commands


echo "tests/shaders/triangle.frag.spv"
# binaryDump readFile("tests/shaders/triangle.frag.spv")
extract openFileStream("tests/shaders/triangle.frag.spv")



# echo "tests/shaders/triangle.vert.spv"
# binaryDump readFile("tests/shaders/triangle.vert.spv")

# echo "tests/shaders/helloworld.frag.spv"
# binaryDump readFile("tests/shaders/helloworld.frag.spv")