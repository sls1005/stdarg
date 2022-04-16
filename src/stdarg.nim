{.push header: "<stdarg.h>".}

type VAList* {.importc: "va_list", nodecl.} = object

{.push importc, nodecl, inline.}

# C macros
proc va_start*(ap: VAList, last: auto)
proc va_end*(ap: VAList)
proc va_copy*(dest, src: VAList)
#proc va_arg*[T](ap: va_list, typ: typedesc[T]): T {.error.}

{.pop.}
{.pop.}

template init*(self: var VAList, lastParam: typed): untyped =
  #This takes the last parameter of a procedure
  va_start(self, lastParam)
  defer: va_end(self)

template next*[T](self: var VAList, dest: var T): untyped =
  {.emit: [dest, "= va_arg(", self, ", ", T, ");"].}
