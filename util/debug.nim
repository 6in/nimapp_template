import macros
import strformat
import strutils

macro debug*(n: varargs[untyped]): untyped =
  var buff = fmt"""
when defined(debug):
  block:
    var useTty = false
    let tty = 
      try:
        let term = open("/dev/tty", fmWrite)
        useTty = true          
        term
      except IOError:
        stdout
    defer:
      if useTty:
        tty.close
    tty.writeLine ("[debug] ---------------------------")
"""
  # get max variable length
  var maxLen = 0
  for x in n:
    if x.kind == nnkIdent:
      let l = ($x).len
      if l > maxLen:
        maxLen = l

  # dump variable
  for x in n:
    # echo x.kind
    if x.kind == nnkStrLit:
      buff = buff & fmt"""
    tty.writeLine ("[debug] - - - - - - - - - - - - - -")
    tty.writeLine ("[debug] " & {repr(x)})
    tty.writeLine ("[debug] - - - - - - - - - - - - - -")
"""
    if x.kind == nnkIdent:
      let name = " ".repeat(maxLen - ($x).len) & $x
      buff = buff & fmt"""
    tty.writeLine ("[debug] {name} => " & ${repr(x)})
"""
  buff = buff & """
    tty.writeLine ("[debug] ---------------------------")
"""
  # echo buff
  parseStmt(buff)

macro if_debug*(head: untyped, body: untyped): untyped =
  let bodies = repr(body).replace("\x0a", "\x0a  ")
  let stmt = fmt"""
when defined(debug): 
  echo "[debug] [" & {repr(head)} & "] [start]"{bodies}
  echo "[debug] [" & {repr(head)} & "] [end]"
"""
  # echo stmt
  result = parseStmt(stmt)

when isMainModule:
  proc sample(x: int, y: string): int =
    result = x + 1

  echo "start"
  let a = 123
  let b = "ヒャッハー"
  let c = sample(a, b)
  debug(
    "parameters", a, b,
    "result", c)

  # debug block
  if_debug("step 1"):
    for x in 1..3:
      debug("loop", x)

  if_debug("step 2"):
    debug "this is debug"

  if_debug("step 3"):
    debug "this is debug"
