import std/macros

import vulkan
import vkm

type
  ShaderObject* = object

type
  Uniform*[T] = T

template shader(stage: ShaderStageFlagBits) {.pragma.}

macro compile(Proc: proc; stage: ShaderStageFlagBits): ShaderObject =
  quote do:
    ShaderObject()
  # for param in body[3]:
  #   hint treeRepr param

when isMainModule:
  var device: Device
  proc vertshader(mvp: Uniform[Mat[4,4,float]]; position, array: Vec[3,float]): tuple[color: array[3,float]] =
    # gl_Position = ubo.mvp * vec4(inPosition, 1)
    # fragColor = inColor
    discard
  var s = vertshader.compile(ShaderStageFlagBits.vertex)

  discard """
  ShaderStageFlagBitsShaderStageFlagBitsShaderStageFlagBits...#version 450

  layout(binding = 0) uniform UniformBufferObject {
      mat4 mvp;
  } ubo;

  layout(location = 0) in vec3 inPosition;
  layout(location = 1) in vec3 inColor;
  layout(location = 0) out vec3 fragColor;

  void main() {
    gl_Position = ubo.mvp * vec4(inPosition, 1);
    fragColor = inColor;
  }
  """