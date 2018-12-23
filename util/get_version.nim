
import os
import nre, options, strutils

let f = open("../nimapp_template.nimble", FileMode.fmRead)
let lines = f.readAll().split("\n")
for line in lines:
  let mOpt = line.match(re"(version)\s*=\s+""(\d+\.\d+\.\d+)""")
  if mOpt.isSome:
    let m = mOpt.get
    echo m.captures[1]
    break