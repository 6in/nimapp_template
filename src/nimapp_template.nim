import parseopt2

import nimapp_templatepkg/main
import docopt

let doc = """
nimapp_template.

Usage:
  nimapp_template <name>
  nimapp_template (-h | --help)
  nimapp_template --version

Options:
  -h --help     Show this screen.
  --version     Show version.
"""

# 引数チェック
when isMainModule:
  let args = docopt(doc, version = "nimapp_template 0.1.0")
  echo "args=>",args
  let retCode = main(args)
  quit(retCode)
