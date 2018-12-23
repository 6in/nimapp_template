
const current_version* = staticExec(
  "nim c -r --hints:off --verbosity:0 -o:../bin/test ../util/get_version.nim")
