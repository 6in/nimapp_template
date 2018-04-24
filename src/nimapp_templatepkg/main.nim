
import private/main_impl
import docopt
import os

# スレッド処理
proc threadFunc(param: tuple[a,b:int]) {.thread.} = 
  for x in param.a..param.b :
    echo "wait:" & $x
    sleep(1000)

proc main*(args:Table[string,Value]) : int =
  result = 0
  let name = $args["<name>"]
  echo say_hello_to(name)

  # スレッドサンプル
  var thr: array[0..1, Thread[tuple[a,b:int]]]
  createThread(thr[0],threadFunc,(1,10))
  joinThreads( thr )



