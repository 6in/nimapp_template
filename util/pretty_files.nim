import os
import strutils
import osproc

proc pretty_proc(startDir: string) =
  for f in walkDirRec(startDir, yieldFilter = {pcFile}):
    if f.endsWith(".nim"):
      let process = startProcess("nimpretty", startDir, @["--backup:on", f],
          nil, options = {poUsePath, poStdErrToStdOut})
      echo f
      discard process.waitForExit()

when isMainModule:
  let
    cmdArgs = os.commandLineParams()
    target_dir =
      if cmdArgs.len == 1:
        os.expandFilename(cmdArgs[0])
      else:
        os.expandFileName(".")

  echo target_dir
  pretty_proc(target_dir)
else:
  echo "not mainmodule"
