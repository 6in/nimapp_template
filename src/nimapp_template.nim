import docopt
import nimapp_templatepkg/main

let doc = """
nimapp_template.

Usage:
  nimapp_template [--sample=<sample>] <name>
  nimapp_template (-h | --help)
  nimapp_template (-v | --version)

Options:
  --sample=<sample>  sample option[default: abcdefg].
  -h --help          Show this screen.
  -v --version       Show version.
"""

proc start() : int =
  const ver = staticExec(
    "nim c -r --hints:off --verbosity:0 -o:../bin/test ../util/get_version.nim")    
  let args = docopt(doc, version = "nimapp_template " & ver)
  echo "args=>",args
  result = main(args)

# 引数チェック
when isMainModule:
  quit(start())
