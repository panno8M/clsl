import ./enums
import ./core

type DataType {.size: 2.} = enum
  `int8`
  `int16`
  `int32`
  `int64`
  `float16`
  `float32`
  `float64`

type I_ExecutionMode_Operands* {.union.} = object
  mode*: EexecutionMode
  Invocations*: tuple[
    mode: EexecutionMode;
    numberOfInvocations: uint32 ]
  LocalSize*: tuple[
    mode: EexecutionMode;
    xSize, ySize, zSize: uint32 ]
  LocalSizeHint*: tuple[
    mode: EexecutionMode;
    xSize, ySize, zSize: uint32 ]
  OutputVertices*: tuple[
    mode: EexecutionMode;
    vertexCount: uint32 ]
  VecTypeHint*: tuple[
    mode: EexecutionMode;
    numberOfComponents: uint16; dataType: DataType ]
  SubgroupSize*: tuple[
    mode: EexecutionMode;
    subgroupSize: uint32 ]
  SubgroupsPerWorkgroup*: tuple[
    mode: EexecutionMode;
    subgroupsPerWorkgroup: uint32 ]
  SubgroupsPerWorkgroupId*: tuple[
    mode: EexecutionMode;
    subgroupsPerWorkgroup: ID[Eop.TypeInt] ]
  LocalSizeId*: tuple[
    mode: EexecutionMode;
    xSize,
    ySize,
    zSize: ID[Eop.TypeInt] ]
  LocalSizeHintId*: tuple[
    mode: EexecutionMode;
    xSizeHint,
    ySizeHint, zSizeHint: ID[Eop.TypeInt] ]
  DenormPreserve*: tuple[
    mode: EexecutionMode;
    targetWidth: uint32 ]
  DenormFlushToZero*: tuple[
    mode: EexecutionMode;
    targetWidth: uint32 ]
  SignedZeroInfNanPreserve*: tuple[
    mode: EexecutionMode;
    targetWidth: uint32 ]
  RoundingModeRTE*: tuple[
    mode: EexecutionMode;
    targetWidth: uint32 ]
  RoundingModeRTZ*: tuple[
    mode: EexecutionMode;
    targetWidth: uint32 ]

template wordsof*(executionMode: EexecutionMode): Positive =
  case executionMode
  of  EexecutionMode.LocalSize,
      EexecutionMode.LocalSizeHint,
      EexecutionMode.LocalSizeId,
      EexecutionMode.LocalSizeHintId,
      EexecutionMode.MaxWorkgroupSizeINTEL:
    4
  of  EexecutionMode.Invocations,
      EexecutionMode.OutputVertices,
      EexecutionMode.VecTypeHint,
      EexecutionMode.SubgroupSize,
      EexecutionMode.SubgroupsPerWorkgroup,
      EexecutionMode.SubgroupsPerWorkgroupId,
      EexecutionMode.DenormPreserve,
      EexecutionMode.DenormFlushToZero,
      EexecutionMode.SignedZeroInfNanPreserve,
      EexecutionMode.RoundingModeRTE,
      EexecutionMode.RoundingModeRTZ,
      EexecutionMode.OutputPrimitivesNV,
      EexecutionMode.SharedLocalMemorySizeINTEL,
      EexecutionMode.RoundingModeRTPINTEL,
      EexecutionMode.RoundingModeRTNINTEL,
      EexecutionMode.FloatingPointModeALTINTEL,
      EexecutionMode.FloatingPointModeIEEEINTEL,
      EexecutionMode.MaxWorkDimINTEL,
      EexecutionMode.NumSIMDWorkitemsINTEL,
      EexecutionMode.SchedulerTargetFmaxMhzINTEL:
    2
  else:
    1

proc `$`*(x: IExecutionModeOperands): string =
  case x.mode
  of EexecutionMode.Invocations: return $x.Invocations
  of EexecutionMode.LocalSize: return $x.LocalSize
  of EexecutionMode.LocalSizeHint: return $x.LocalSizeHint
  of EexecutionMode.OutputVertices: return $x.OutputVertices
  of EexecutionMode.VecTypeHint: return $x.VecTypeHint
  of EexecutionMode.SubgroupSize: return $x.SubgroupSize
  of EexecutionMode.SubgroupsPerWorkgroup: return $x.SubgroupsPerWorkgroup
  of EexecutionMode.SubgroupsPerWorkgroupId: return $x.SubgroupsPerWorkgroupId
  of EexecutionMode.LocalSizeId: return $x.LocalSizeId
  of EexecutionMode.LocalSizeHintId: return $x.LocalSizeHintId
  of EexecutionMode.DenormPreserve: return $x.DenormPreserve
  of EexecutionMode.DenormFlushToZero: return $x.DenormFlushToZero
  of EexecutionMode.SignedZeroInfNanPreserve: return $x.SignedZeroInfNanPreserve
  of EexecutionMode.RoundingModeRTE: return $x.RoundingModeRTE
  of EexecutionMode.RoundingModeRTZ: return $x.RoundingModeRTZ
  else: return $x.mode

type
  I_Capability* = object
    opecode*: Eop
    wordCount*: int16
    capability*: Ecapability
  I_EntryPoint* = object
    opecode*: Eop
    wordCount*: int16
    executionModel*: EexecutionModel
    idEntryPoint*: ID[Eop.Function]
    name*: StringLiteral
    idInterfaces*: seq[ID[Eop.Variable]]
  # I_ExecutionMode* = object
  #   opecode*: Eop
  #   wordCount*: int16
  #   idEntryPoint*: ID[Eop.EntryPoint]
  #   modeOperands*: IExecutionModeOperands
  I_ExtInstImport* = object
    opecode*: Eop
    wordCount*: int16
    idResult*: ID[Eop.ExtInstImport]
    name*: StringLiteral
  I_MemoryModel* = object
    opecode*: Eop
    wordCount*: int16
    addressingModel*: EaddressingModel
    memoryModel*: EmemoryModel
  I_Name* = object
    opecode*: Eop
    wordCount*: int16
    idTarget*: ID[Eop.Any]
    name*: StringLiteral
  I_Source* = object
    opecode*: Eop
    wordCount*: int16
    sourceLanguage*: EsourceLanguage
    version*: uint32
    idFile*: ID[Eop.String]

type Instruction* {.union.} = object
  opecode*: E_Op
  wordcount*: int16

  Capability*: ICapability
  EntryPoint*: IEntryPoint
  # ExecutionMode*: IExecutionMode
  ExtInstImport*: IExtInstImport
  MemoryModel*: IMemoryModel
  Name*: IName
  Source*: ISource

proc `$`*(ir: Instruction): string =
  case ir.opecode
  of Eop.Capability:
    $ir.Capability
  of Eop.EntryPoint:
    $ir.EntryPoint
  # of Eop.ExecutionMode:
  #   $ir.ExecutionMode
  of Eop.ExtInstImport:
    $ir.ExtInstImport
  of Eop.MemoryModel:
    $ir.MemoryModel
  of Eop.Name:
    $ir.Name
  of Eop.Source:
    $ir.Source
  else:
    "Unknown Instruction: " & $ir.opecode & " " & $ir.wordcount