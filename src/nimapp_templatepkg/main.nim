
import private/main_impl

proc c_sprintf(buf, frmt: cstring): cint {.header: "<stdio.h>", importc: "sprintf", varargs.}

proc say_hello_to* (name: string) : string = 
  let msg = main_impl.say_hello_to(name)

  var buf {.noinit.}: array[0..2500, char]
  let length = c_sprintf(buf,"{{%s}}",msg)
  result = newString(length)
  for i in 0..(length-1):
    result[i] = buf[i]
