import std/macros

import vulkan

when false:
  var descriptorSetLayoutBindings = (
    # UniformBuffer (set=0)
    uniformBuffer: @[
      # layout(set=0, binding=0) uniform SceneMatrices
      DescriptorSetLayoutBinding{
        binding: 0,
        descriptorType: DescriptorType.uniformBuffer,
        descriptorCount: 1,
        stageFlags: ShaderStageFlags{vertex},
      },
      # layout(set=0, binding=1) uniform ModelMatrices
      DescriptorSetLayoutBinding{
        binding: 1,
        descriptorType: DescriptorType.uniformBuffer,
        descriptorCount: 1,
        stageFlags: ShaderStageFlags{vertex, fragment},
      },
      # layout(set=0, binding=2) uniform Material
      DescriptorSetLayoutBinding{
        binding: 2,
        descriptorType: DescriptorType.uniformBuffer,
        descriptorCount: 1,
        stageFlags: ShaderStageFlags{fragment},
      },
      # layout(set=0, binding=3) uniform Camera
      DescriptorSetLayoutBinding{
        binding: 3,
        descriptorType: DescriptorType.uniformBuffer,
        descriptorCount: 1,
        stageFlags: ShaderStageFlags{fragment},
      },
    ],
    # Texture (set=1)
    texture: @[
      # layout(set=1, binding=0) uniform texture2D LightMap
      DescriptorSetLayoutBinding{
        binding: 0,
        descriptorType: DescriptorType.sampledImage,
        descriptorCount: 1,
        stageFlags: ShaderStageFlags{vertex, fragment},
      },
      # layout(set=1, binding=1) uniform texture2D ColorTexture
      DescriptorSetLayoutBinding{
        binding: 1,
        descriptorType: DescriptorType.sampledImage,
        descriptorCount: 1,
        stageFlags: ShaderStageFlags{fragment},
      },
    ],
    # SamplerState (set=2)
    samplerState: @[
      # layout(set=2, binding=0) uniform sampler LightMapSampler
      DescriptorSetLayoutBinding{
        binding: 0,
        descriptorType: DescriptorType.sampler,
        descriptorCount: 1,
        stageFlags: ShaderStageFlags{vertex, fragment},
      },
      # layout(set=2, binding=1) uniform sampler ColorTextureSampler
      DescriptorSetLayoutBinding{
        binding: 1,
        descriptorType: DescriptorType.sampler,
        descriptorCount: 1,
        stageFlags: ShaderStageFlags{fragment},
      },
    ],
    # CombindSampler (set=3)
    combindSampler: @[
      # layout(set=3, binding=0) uniform sampler2D BoneMap
      DescriptorSetLayoutBinding{
        binding: 0,
        descriptorType: DescriptorType.combinedImageSampler,
        descriptorCount: 1,
        stageFlags: ShaderStageFlags{vertex},
      },
    ],
  )

  var descriptorSetLayoutCIs = @[
    # UniformBuffer (set=0)
    DescriptorSetLayoutCreateInfo{
      bindingCount: 4,
      pBindings: addr descriptorSetLayoutBindings.uniformBuffer[0],
    },
    # Texture (set=1)
    DescriptorSetLayoutCreateInfo{
      bindingCount: 2,
      pBindings: addr descriptorSetLayoutBindings.texture[0],
    },
    # SamplerState (set=2)
    DescriptorSetLayoutCreateInfo{
      bindingCount: 2,
      pBindings: addr descriptorSetLayoutBindings.samplerState[0],
    },
    # CombindSampler (set=3)
    DescriptorSetLayoutCreateInfo{
      bindingCount: 1,
      pBindings: addr descriptorSetLayoutBindings.combindSampler[0],
    },
  ]

  var device: Device
  var descriptorSetLayout: array[4, DescriptorSetLayout] # Target!

  for descset in descriptorSetLayout.mItems:
    discard device.createDescriptorSetLayout(addr descriptorSetLayoutCIs[0], nil, addr descset)

type ShaderDescriptor* = object

macro descriptorLayout(body): untyped =
  hint body.treeRepr

var shaderDesc = shaderDescriptor:
  layout(set= 0, binding= 0) uniform ScheneMatrices
  layout(set= 0, binding= 1) uniform ModelMatrices
  layout(set= 1, binding= 0) uniform texture2D LightMap
  layout(set= 2, binding= 0) uniform ScheneMatrices
  layout(set= 3, binding= 0) uniform ScheneMatrices

descriptorLayout:
  {.set: 0.}
  {.stageFlags: vertex.}
  sceneMatrices: uniformBuffer[1]
  modelmatrices: uniformBuffer
  material: uniformBuffer
  camera: uniformBuffer