
import os
import nre, options, strutils
import strformat

let
  cmdArgs = os.commandLineParams()
  pkgName = cmdArgs[0]

let f = open(fmt"../{pkgName}.nimble", FileMode.fmRead)
let lines = f.readAll().split("\n")
for line in lines:
  let mOpt = line.match(re"(version)\s*=\s+""(\d+\.\d+\.\d+)""")
  if mOpt.isSome:
    let m = mOpt.get
    echo m.captures[1]
    break
f.close
