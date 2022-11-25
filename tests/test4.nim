import stdarg/wchar

{.emit: "wchar_t x = L'\\x2693';".}

let
  x {.importc.}: CWideChar
var
  w1 = CWideChar.high
  w2 = CWideChar.high

echo x
echo cast[ptr int64](w1.addr)[]
echo cast[ptr int64](w2.addr)[]
echo [cast[char](x)]
