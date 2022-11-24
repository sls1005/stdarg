# Nim stdarg

This is a Nim wrapper for the standard C header `<stdarg.h>`. One can use it to make variadic procedures that can be used from C/C++.

Standard C functions that take `va_list` (the list object, not "...") as arguments are also wrapped (those from `<stdio.h>` are in `stdarg/io`, and those from `<wchar.h>` in `stdarg/wchar`).

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

Note that `{.varargs.}` is a built-in pragma. It tells the compiler that the procedure is able to take more arguments.

### Note

+ This package is only useful when interacting with C/C++. The built-in `varargs[T]` should be used in other cases.

+ For each `VAList` initialized with `init()`, `va_end` will be automatically invoked (and thus don't need to be called explicitly). For a `VAList` initialized with another method, `va_end` must be called once in the *same proc* as it initialized. However it don't need to be invoked if the list is never initialized.

### References

+ https://cplusplus.com/reference/cstdarg/
+ https://cplusplus.com/reference/cstdio/
+ https://cplusplus.com/reference/cwchar/
+ https://en.cppreference.com/w/c/experimental/dynamic/asprintf
