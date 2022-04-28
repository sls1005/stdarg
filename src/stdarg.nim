{.push header: "<stdarg.h>".}

type VAList* {.importc: "va_list", nodecl.} = object

{.push importc, nodecl, inline.}

# C macros
proc va_start*(ap: VAList, last: auto)
proc va_end*(ap: VAList)
proc va_copy*(dest, src: VAList)

{.pop.}

when defined(cpp):
  proc va_arg[T](ap: VAList, typ: typedesc[T]): T {.importcpp: "va_arg(#, '0)".}
else:
  #proc va_arg[T](ap: VAList, typ: typedesc[T]): T {.error.}
  discard

{.pop.}

template init*(self: VAList, lastParam: typed): untyped =
  #This takes the last parameter of a procedure
  va_start(self, lastParam)
  defer: va_end(self)

template next*[T](self: VAList, dest: var T): untyped =
  when defined(cpp):
    dest = va_arg[T](self, T)
  else:
    {.emit: [dest, "= va_arg(", self, ", ", T, ");"].}
