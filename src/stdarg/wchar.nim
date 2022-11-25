from ../stdarg import VAList

when defined(cpp):
  type CWideChar* {.importcpp: "wchar_t", nodecl.} = object
else:
  type CWideChar* {.importc: "wchar_t", header: "<wchar.h>".} = object
  ## Do not try to cast a `CWideChar` into an `int`.

const
  cwchar = (
    when defined(cpp):
      "<cwchar>"
    else:
      "<wchar.h>"
  )
  cstdlib = (
    when defined(cpp):
      "<cstdlib>"
    else:
      "<stdlib.h>"
  )
  function = (
    when defined(cpp):
      "std::$1"
    else:
      "$1"
  )

{.push hint[Name]: off.}
let
  MB_CUR_MAX {.importc, header: cstdlib.}: csize_t
  WCHAR_MAX {.importc, header: cwchar.}: CWideChar
  WCHAR_MIN {.importc, header: cwchar.}: CWideChar
{.pop.}

proc wctomb(s: cstring, w: CWideChar): cint {.header: cstdlib, importc: function, cdecl.}

{.push header: cwchar, importc: function, cdecl.}

proc vwscanf*(fmt: ptr CWideChar; v: VAList): cint

proc vwprintf*(fmt: ptr CWideChar; v: VAList): cint

proc vswscanf*(s, fmt: ptr CWideChar; v: VAList): cint

proc vswprintf*(s: ptr CWideChar; n: csize_t; fmt: ptr CWideChar; v: VAList): cint

proc vfwscanf*(f: File; fmt: ptr CWideChar; v: VAList): cint

proc vfwprintf*(f: File; fmt: ptr CWideChar; v: VAList): cint

{.pop.}

proc `$`*(w: CWideChar): string {.raises: [ValueError].} =
  result = newString(MB_CUR_MAX + 1)
  let n = wctomb(result.cstring, w)
  if likely(n > -1):
    result.setLen(n)
  else:
    raise newException(ValueError, "")

proc high*(t: typedesc[CWideChar]): CWideChar {.raises: [], noInit, inline.} = WCHAR_MAX

proc low*(t: typedesc[CWideChar]): CWideChar {.raises: [], noInit, inline.} = WCHAR_MIN
