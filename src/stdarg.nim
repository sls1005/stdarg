when defined(cpp):
  type VAList* {.importcpp: "std::va_list", cppNonPod, header: "<cstdarg>".} = object
else:
  type VAList* {.importc: "va_list", header: "<stdarg.h>".} = object

const cstdarg = (
  when defined(cpp):
    "<cstdarg>"
  else:
    "<stdarg.h>"
)

{.push header: cstdarg, importc.}
# C macros
proc va_start*(v: VAList, last: auto) {.importc.}
proc va_end*(v: VAList) {.importc.}
proc va_copy*(dst, src: VAList) {.importc.}
{.pop.}

when defined(cpp):
  proc va_arg[T](v: VAList, typeName: typedesc[T]): T {.importcpp: "va_arg(#, '0)", header: "<cstdarg>".}
else:
  #proc va_arg[T](v: VAList, typeName: typedesc[T]): T {.importc, header: "<stdarg.h>", error.}
  discard

template init*(self: VAList, lastParam: typed): untyped =
  # This takes the last parameter of a procedure as an argument.
  va_start(self, lastParam)
  defer: va_end(self)

template next*[T](self: VAList, dest: var T): untyped =
  when defined(cpp):
    dest = va_arg[T](self, T)
  else:
    {.emit: [dest, "= va_arg(", self, ", ", T, ");"].}
