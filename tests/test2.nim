import unittest, macros

import nimapp_templatepkg/main

# sample from https://github.com/nim-lang/Nim/blob/master/examples/tunit.nim

suite "my suite2": 
  setup:
    echo "before test"

  teardown:
    echo "after test"

  test "call method1":
    echo "call method1"
    check:
      main.say_hello_to("nim") == "{{hello [[nim]]}}"
      main.say_hello_to("c") == "{{hello [[c]]}}"
      
  test "call method2":
    echo "call method2"
    check:
      main.say_hello_to("nim") == "{{hello [[nim]]}}"
      main.say_hello_to("c") == "{{hello [[c]]}}"
    
    