from ../stdarg import VAList

type WideCharImpl = (
  when defined(windows):
    uint16
  else:
    uint32
)

when defined(cpp):
  type CWideChar* {.importcpp: "wchar_t", nodecl.} = WideCharImpl
else:
  type CWideChar* {.importc: "wchar_t", header: "<wchar.h>".} = WideCharImpl

const
  cwchar = (
    when defined(cpp):
      "<cwchar>"
    else:
      "<wchar.h>"
  )
  function = (
    when defined(cpp):
      "std::$1"
    else:
      "$1"
  )

{.push header: cwchar, importc: function, cdecl.}

proc vwscanf*(fmt: ptr CWideChar; v: VAList): cint

proc vwprintf*(fmt: ptr CWideChar; v: VAList): cint

proc vswscanf*(s, fmt: ptr CWideChar; v: VAList): cint

proc vswprintf*(s: ptr CWideChar; n: csize_t; fmt: ptr CWideChar; v: VAList): cint

proc vfwscanf*(f: File; fmt: ptr CWideChar; v: VAList): cint

proc vfwprintf*(f: File; fmt: ptr CWideChar; v: VAList): cint

{.pop.}
