import docopt
import nimapp_templatepkg/main

let doc = """
nimapp_template.

Usage:
  nimapp_template [--sample=<sample>] <name>
  nimapp_template (-h | --help)
  nimapp_template --version

Options:
  --sample=<sample>  sample option[default: abcdefg].
  -h --help          Show this screen.
  --version          Show version.
"""

proc start() : int =
  let args = docopt(doc, version = "nimapp_template 0.1.0")
  echo "args=>",args
  result = main(args)

# 引数チェック
when isMainModule:
  quit(start())
