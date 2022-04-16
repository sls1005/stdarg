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