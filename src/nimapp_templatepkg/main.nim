
import private/main_impl
import docopt
import os
import ../../util/debug

# スレッド処理
proc threadFunc(param: tuple[a, b: int]) {.thread.} =
  for x in param.a..param.b:
    debug x
    sleep(1000)

proc main*(args: Table[string, Value]): int =
  result = 0
  let name = $args["<name>"]
  echo say_hello_to(name)

  # スレッドサンプル
  var thr: array[0..1, Thread[tuple[a, b: int]]]
  debug "start threads"
  thr[0].createThread(threadFunc, (1, 5))
  thr[1].createThread(threadFunc, (6, 10))
  debug "wait threads"
  # sleep(1000)
  joinThreads(thr)




