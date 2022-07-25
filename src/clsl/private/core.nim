import ./enums

type ID*[OP: static[Eop]] = object
  value*: int32
type StringLiteral* = object
  value*: string

proc `$`*(id: ID): string =
  if id.value != 0:
    "%" & $id.value & "(" & $id.OP & ")"
  else:
    "Nil(" & $id.OP & ")"
proc `$`*(lit: StringLiteral): string = "\"" & $cast[cstring](unsafeaddr lit.value[0]) & "\""
proc words*(lit: StringLiteral): int = int lit.value.len / 4



type ClslShader* = object