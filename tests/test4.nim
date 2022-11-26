from stdarg/wchar import CWideChar

proc printf(f: cstring): cint {.importc, varargs, header: "<stdio.h>".}

proc main =
  var x: CWideChar
  x = CWideChar('A')
  if printf("%lc\n", x) < 0:
    raise newException(ValueError, "")

main()
