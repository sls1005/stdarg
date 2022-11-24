import stdarg
from stdarg/io import vasprintf

{.emit: """
  /*INCLUDESECTION*/
  #define _GNU_SOURCE
""".}

proc free(p: pointer) {.header: "<stdlib.h>", importc.}

proc myfmt(f: cstring) {.varargs.} =
  var
    s: cstring
    v {.noInit.}: VAList
  v.init(f)
  if vasprintf(s.addr, f, v) == -1:
    echo "Error"
  else:
    echo s
    free(pointer(s))

myfmt("%d %.1f %s", 1.cint, 2.cfloat, "3 4")
