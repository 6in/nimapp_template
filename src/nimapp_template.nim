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

# 引数チェック
when isMainModule:
  let args = docopt(doc, version = "nimapp_template 0.1.0")
  echo "args=>",args
  let retCode = main(args)
  quit(retCode)
