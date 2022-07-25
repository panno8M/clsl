import std/strutils
import std/sequtils
import std/math

proc perseAsciiOrSpace(ch: char): string =
  if ch.ord in 32..126: return " " & $ch
  case ch:
  of '\t': "\\t"
  of '\n': "\\n"
  of '\r': "\\r"
  else: "__"

proc perseByte(ch: char): string =
  cast[byte](ch).toHex(2)

proc separate[T](s: seq[T]; num: Positive): seq[seq[T]] =
  for i in 0..<int ceil s.len/num:
    result.add s[num*i..min(s.high, pred num*i.succ)]

proc binaryDump*(str: string) =
  const columns = 16
  var strs = str.toSeq
    .map(perseAsciiOrSpace)
    .separate(columns)
    .mapIt(it.join())
    .mapIt(if it.len != columns*2: it & ".".repeat(columns*2-it.len) else: it)
  var bytes = str.toSeq
    .map(perseByte)
    .separate(columns)
    .mapIt(it.join(" "))
    .mapIt(if it.len != columns*3-1: it & ".".repeat(columns*3-1-it.len) else: it)

  echo "  |00 01 02 03 04 05 06 07 08 09 0A 0B 0C 0D 0E 0F| 0 1 2 3 4 5 6 7 8 9 A B C D E F"
  echo "--+-----------------------------------------------+--------------------------------"
  for i in 0..<strs.len:
    echo i.toHex(2), "|", bytes[i], "|", strs[i]