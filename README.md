# Nim stdarg

This is a Nim wrapper for `<stdarg.h>`. One can use it to make a procedure taking variable number of parameters, that is about to be exported to C/C++. This is only useful when interacting with C/C++. The built-in `varargs[T]` should be used in other cases.

### Example
```nim
import stdarg

proc sum(x: int): int {.varargs.} =
  var
    args {.noInit.}: VAList
    a: int
  args.init(x)
  result = x
  while true:
    args.next(a)
    if a == 0:
      break
    result += a

echo sum(1, 2, 3, 0)
```

To make a procedure that takes variable number of parameters, mark it as `{.varargs.}` and declare a variable of type `VAList`. After that, call `init` with the last parameter name to initialize it. Use `next` to store the next argument into a variable.

Note that `{.varargs.}` is a built-in pragma. It tells the compiler that the procedure can take more arguments.
