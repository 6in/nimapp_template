
import private/main_impl
import docopt

proc main*(args:Table[string,Value]) : int =
  result = 0
  let name = $args["<name>"]
  echo say_hello_to(name)
