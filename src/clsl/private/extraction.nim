import std/streams
import std/strutils
import std/sugar
import std/algorithm

import ./core
import ./enums
import ./instructions

type IDecorationOperands {.union.} = object
  decoration: E_Decoration
  SpecId: tuple[
    decoration: E_Decoration;
    specificationConstantID: uint32;]
  ArrayStride: tuple[
    decoration: E_Decoration;
    arrayStride: uint32;]
  MatrixStride: tuple[
    decoration: E_Decoration;
    matrixStride: uint32;]
  BuiltIn: tuple[
    decoration: E_Decoration;
    builtIn: E_BuiltIn;]
  UniformId: tuple[
    decoration: E_Decoration;
    execution: ID[Eop.Nop];]
  Stream: tuple[
    decoration: E_Decoration;
    streamNumber: uint32;]

const SpirvMagicNumber = 0x07230203
type SpirvVersion = distinct int32
template major(sv: SpirvVersion): int =
  int(sv) shr 16 and 0b11
template minor(sv: SpirvVersion): int =
  int(sv) shr 8 and 0b11

template wordOffset(p: pointer; offset: Natural): pointer =
  cast[pointer](cast[ptr uint64](unsafeAddr p)[].succ(offset*4))
var swapEndian: bool
proc readWord*(stream: Stream; res: pointer): lent Stream {.inline, discardable.} =
  var word: array[4,byte]
  stream.read(word)
  if swapEndian: word.reverse
  copyMem res, addr word, 4
  return stream
proc peekWord*(stream: Stream; res: pointer): lent Stream {.inline, discardable.} =
  var word: array[4,byte]
  stream.peek(word)
  if swapEndian: word.reverse
  copyMem res, addr word, 4
  return stream

proc readWords*(stream: Stream; res: pointer; words: Positive): lent Stream {.inline, discardable.} =
  var address = res
  for i in 0..<words:
    stream.readWord(address)
    address = address.wordOffset(1)
  stream

# proc read*[T](stream: Stream; val: var T): lent Stream {.inline, discardable.} =
#   streams.read(stream, val); stream

proc readStrLit*(stream: Stream; res: var StringLiteral): lent Stream {.inline, discardable.} =
  result = stream
  res.value.setlen 4
  var head = 0
  while true:
    stream.readWord(addr res.value[head])
    for i in countdown(3, 0):
      if res.value[head+i] == '\0':
        return
    res.value.setlen res.value.len+4
    head.inc 4

proc read*[T](stream: Stream; res: var seq[ID[T]]; wordcount: Positive): lent Stream {.inline, discardable.} =
  res.setlen wordcount
  stream.readWords(addr res[0], wordcount)

proc read*(stream: Stream; res: var IExecutionModeOperands): lent Stream {.inline, discardable.} =
  result = stream
  stream.peek res.mode
  stream.readWords(addr res, wordsof res.mode)

proc read*(stream: Stream; ir: var Instruction): lent Stream {.inline, discardable.} =
    stream.peekWord(addr ir)
    case ir.opecode:
    of Eop.Capability:
      stream.readWords(addr ir, 2)
    of Eop.EntryPoint:
      stream
        .readWords(addr ir, 3)
        # .readStrLit(ir.EntryPoint.name)
        # .read(ir.EntryPoint.idInterfaces, ir.wordCount - (3+ir.EntryPoint.name.words))
    # of Eop.ExecutionMode:
    #   stream
    #     .readWords(addr ir, 2)
    #     .read(ir.ExecutionMode.modeOperands)
    # of Eop.ExtInstImport:
    #   stream
    #     .readWords(addr ir, 2)
    #     .readStrLit(ir.ExtInstImport.name)
    # of Eop.MemoryModel:
    #   stream.readWords(addr ir, 3)
    # of Eop.Name:
    #   stream
    #     .readWords(addr ir, 2)
    #     .readStrLit(ir.Name.name)
    # of Eop.Source:
    #   # TODO: compare wordcounts and read optional args
    #   stream.readWords(addr ir.Source, 3)
    else:
      discard
    return stream

proc extract*(binary: Stream) =
  var spvHeader: tuple[
    magicNumber: int32,
    version: SpirvVersion,
    generatorMagicNumber: int32,
    idBound: int32,
    padding: array[4,byte]]

  block Header:
    binary.peek(spvHeader.magicNumber)
    # TODO: deduce endianness
    if spvHeader.magicNumber == SpirvMagicNumber:
      echo "TRUE"
    else:
      echo "SWAP"
      swapEndian = true
    binary
      .readWords(addr spvHeader, 5)
      # .readWord(addr spvHeader.version)
      # .readWord(addr spvHeader.generatorMagicNumber)
      # .readWord(addr spvHeader.idBound)
      # .readWord(addr spvHeader.padding)

  echo "Version: ", spvHeader.version.major, ".", spvHeader.version.minor
  dump spvHeader.generatorMagicNumber.toHex(8)
  dump spvHeader.idBound

  try:
    while true:
      var instruction: Instruction
      binary.read instruction
      echo instruction
  except RangeDefect:
    quit QuitSuccess