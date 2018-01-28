import parseopt2

import nimapp_templatepkg/main

proc printUsage() = 
  echo """Usage:
write usage here. 
"""
  quit(0)

# 引数チェック
when isMainModule:
  for kind , key , val in getopt():
    case kind
    of cmdArgument:
      discard
    of cmdLongOption,cmdShortOption:
      case key
      of "help":
        printUsage()
    else:
      printUsage()
      discard

  echo main.say_hello_to("nim")

