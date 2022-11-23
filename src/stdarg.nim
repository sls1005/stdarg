{.push header: "<stdarg.h>".}

type VAList* {.importc: "va_list", nodecl.} = object

# C macros
proc va_start*(v: VAList, last: auto) {.importc.}
proc va_end*(v: VAList) {.importc.}
proc va_copy*(dst, src: VAList) {.importc.}

when defined(cpp):
  proc va_arg[T](v: VAList, typeName: typedesc[T]): T {.importcpp: "va_arg(#, '0)".}
else:
  #proc va_arg[T](v: VAList, typeName: typedesc[T]): T {.error.}
  discard

{.pop.}

template init*(self: VAList, lastParam: typed): untyped =
  # This takes the last parameter of a procedure as an argument.
  va_start(self, lastParam)
  defer: va_end(self)

template next*[T](self: VAList, dest: var T): untyped =
  when defined(cpp):
    dest = va_arg[T](self, T)
  else:
    {.emit: [dest, "= va_arg(", self, ", ", T, ");"].}
