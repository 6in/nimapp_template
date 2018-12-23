import docopt
import nimapp_templatepkg/main
import version

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
  let args = docopt(doc, version = "nimapp_template " & current_version)
  echo "args=>",args
  result = main(args)

# 引数チェック
when isMainModule:
  quit(start())
