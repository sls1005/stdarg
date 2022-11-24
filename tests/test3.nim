import stdarg
from stdarg/io import vscanf

let EOF {.header: "<stdio.h>", importc.}: cint

proc scan(f: cstring) {.varargs.} =
  var v {.noInit.}: VAList
  v.init(f)
  if vscanf(f, v) == EOF:
    raise newException(EOFError, "")

proc main =
  var
    a: cint
    b: culong
    c: cdouble
  scan("%d%lu%lf", a.addr, b.addr, c.addr)
  echo a, "\n", b, "\n", c

main()
