import vulkan
import vkm

proc shaderformat*[T](x: T): Format {.inline.} =
  when false: Format.undefined
  # TODO:
  # r4g4UnormPack8
  # r4g4b4a4UnormPack16
  # b4g4r4a4UnormPack16
  # r5g6b5UnormPack16
  # b5g6r5UnormPack16
  # r5g5b5a1UnormPack16
  # b5g5r5a1UnormPack16
  # a1r5g5b5UnormPack16

  elif T is   unorm8: r8Unorm
  elif T is    norm8: r8Snorm
  elif T is uscaled8: r8Uscaled
  elif T is  scaled8: r8Sscaled
  elif T is    uint8: r8Uint
  elif T is     int8: r8Sint
  # TODO: r8Srgb

  elif T is array[2,   unorm8]: r8g8Unorm
  elif T is array[2,    norm8]: r8g8Snorm
  elif T is array[2, uscaled8]: r8g8Uscaled
  elif T is array[2,  scaled8]: r8g8Sscaled
  elif T is array[2,    uint8]: r8g8Uint
  elif T is array[2,     int8]: r8g8Sint
  # TODO: r8g8Srgb

  elif T is array[3,   unorm8]: r8g8b8Unorm
  elif T is array[3,    norm8]: r8g8b8Snorm
  elif T is array[3, uscaled8]: r8g8b8Uscaled
  elif T is array[3,  scaled8]: r8g8b8Sscaled
  elif T is array[3,    uint8]: r8g8b8Uint
  elif T is array[3,     int8]: r8g8b8Sint
  # TODO: r8g8b8Srgb

  # TODO:
  # b8g8r8Unorm
  # b8g8r8Snorm
  # b8g8r8Uscaled
  # b8g8r8Sscaled
  # b8g8r8Uint
  # b8g8r8Sint
  # b8g8r8Srgb

  elif T is array[4,   unorm8]: r8g8b8a8Unorm
  elif T is array[4,    norm8]: r8g8b8a8Snorm
  elif T is array[4, uscaled8]: r8g8b8a8Uscaled
  elif T is array[4,  scaled8]: r8g8b8a8Sscaled
  elif T is array[4,    uint8]: r8g8b8a8Uint
  elif T is array[4,     int8]: r8g8b8a8Sint
  # TODO: r8g8b8a8Srgb

  # TODO:
  # b8g8r8a8Unorm
  # b8g8r8a8Snorm
  # b8g8r8a8Uscaled
  # b8g8r8a8Sscaled
  # b8g8r8a8Uint
  # b8g8r8a8Sint
  # b8g8r8a8Srgb

  # TODO:
  # a8b8g8r8UnormPack32
  # a8b8g8r8SnormPack32
  # a8b8g8r8UscaledPack32
  # a8b8g8r8SscaledPack32
  # a8b8g8r8UintPack32
  # a8b8g8r8SintPack32
  # a8b8g8r8SrgbPack32
  # a2r10g10b10UnormPack32
  # a2r10g10b10SnormPack32
  # a2r10g10b10UscaledPack32
  # a2r10g10b10SscaledPack32
  # a2r10g10b10UintPack32
  # a2r10g10b10SintPack32
  # a2b10g10r10UnormPack32
  # a2b10g10r10SnormPack32
  # a2b10g10r10UscaledPack32
  # a2b10g10r10SscaledPack32
  # a2b10g10r10UintPack32
  # a2b10g10r10SintPack32

  elif T is   unorm16: Format.r16Unorm
  elif T is    norm16: Format.r16Snorm
  elif T is uscaled16: Format.r16Uscaled
  elif T is  scaled16: Format.r16Sscaled
  elif T is    uint16: Format.r16Uint
  elif T is     int16: Format.r16Sint
  # TODO: r16Sfloat

  elif T is array[2,   unorm16]: Format.r16g16Unorm
  elif T is array[2,    norm16]: Format.r16g16Snorm
  elif T is array[2, uscaled16]: Format.r16g16Uscaled
  elif T is array[2,  scaled16]: Format.r16g16Sscaled
  elif T is array[2,    uint16]: Format.r16g16Uint
  elif T is array[2,     int16]: Format.r16g16Sint
  # TODO: r16g16Sfloat

  elif T is array[3,   unorm16]: Format.r16g16b16Unorm
  elif T is array[3,    norm16]: Format.r16g16b16Snorm
  elif T is array[3, uscaled16]: Format.r16g16b16Uscaled
  elif T is array[3,  scaled16]: Format.r16g16b16Sscaled
  elif T is array[3,    uint16]: Format.r16g16b16Uint
  elif T is array[3,     int16]: Format.r16g16b16Sint
  # TODO: r16g16b16Sfloat

  elif T is array[4,   unorm16]: Format.r16g16b16Unorm
  elif T is array[4,    norm16]: Format.r16g16b16Snorm
  elif T is array[4, uscaled16]: Format.r16g16b16Uscaled
  elif T is array[4,  scaled16]: Format.r16g16b16Sscaled
  elif T is array[4,    uint16]: Format.r16g16b16Uint
  elif T is array[4,     int16]: Format.r16g16b16Sint
  # TODO: r16g16b16a16Sfloat

  elif T is uint32  | array[1,  uint32]: Format.r32Uint
  elif T is int32   | array[1,   int32]: Format.r32Sint
  elif T is float32 | array[1, float32]: Format.r32Sfloat

  elif T is array[2,  uint32]: Format.r32g32Uint
  elif T is array[2,   int32]: Format.r32g32Sint
  elif T is array[2, float32]: Format.r32g32Sfloat

  elif T is array[3,  uint32]: Format.r32g32b32Uint
  elif T is array[3,   int32]: Format.r32g32b32Sint
  elif T is array[3, float32]: Format.r32g32b32Sfloat

  elif T is array[4,  uint32]: Format.r32g32b32a32Uint
  elif T is array[4,   int32]: Format.r32g32b32a32Sint
  elif T is array[4, float32]: Format.r32g32b32a32Sfloat

  elif T is uint64  | array[1,  uint64]: Format.r64Uint
  elif T is int64   | array[1,   int64]: Format.r64Sint
  elif T is float64 | array[1, float64]: Format.r64Sfloat

  elif T is array[2,  uint64]: Format.r64g64Uint
  elif T is array[2,   int64]: Format.r64g64Sint
  elif T is array[2, float64]: Format.r64g64Sfloat

  elif T is array[3,  uint64]: Format.r64g64b64Uint
  elif T is array[3,   int64]: Format.r64g64b64Sint
  elif T is array[3, float64]: Format.r64g64b64Sfloat

  elif T is array[4, float64]: Format.r64g64b64a64Sfloat
  elif T is array[4,  uint64]: Format.r64g64b64a64Uint
  elif T is array[4,   int64]: Format.r64g64b64a64Sint

  else:
    {.warning: "No matching format exists. Undefined is selected".}
    Format.undefined