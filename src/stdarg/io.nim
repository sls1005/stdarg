from ../stdarg import VAList
from ./wchar import CWideChar

const
  cstdio = (
    when defined(cpp):
      "<cstdio>"
    else:
      "<stdio.h>"
  )
  function = (
    when defined(cpp):
      "std::$1"
    else:
      "$1"
  )

{.push header: cstdio, importc: function, cdecl.}

proc vscanf*(fmt: cstring; v: VAList): cint

proc vprintf*(fmt: cstring; v: VAList): cint

proc vsscanf*(s, fmt: cstring; v: VAList): cint

proc vsprintf*(s: cstring, fmt: cstring; v: VAList): cint

proc vsnprintf*(s: cstring; n: csize_t; fmt: cstring; v: VAList): cint

proc vfscanf*(f: File; fmt: cstring; v: VAList): cint

proc vfprintf*(f: File; fmt: cstring; v: VAList): cint

{.pop.}

{.push header: "<stdio.h>", importc, cdecl.}

proc vasprintf*(sp: ptr[cstring]; fmt: cstring; v: VAList): cint
  ## The result must be freed with the C function `free` (not `dealloc`), or there could be a memory leak.
  ## **Note:** This is *non-standard*.
  ##
  ## **Example:**
  ##  
  ## .. code-block::
  ##   {.emit: """
  ##     /*INCLUDESECTION*/
  ##     #define _GNU_SOURCE
  ##   """.}
  ##   import stdarg
  ##   from stdarg/io import vasprintf
  ##   proc free(p: pointer) {.header: "<stdlib.h>", importc.}
  ##   proc p(f: cstring) {.varargs.} =
  ##     var
  ##       v: VAList
  ##       s: cstring
  ##     v.init(f)
  ##     if vasprintf(s.addr, f, v) == -1:
  ##       echo "Error"
  ##     else:
  ##       echo s
  ##       free(pointer(s))

proc vaswprintf*(sp: ptr[ptr[CWideChar]]; fmt: ptr[CWideChar]; v: VAList): cint
  ## The result must be freed.
  ## **Note:** This is *non-standard*. It's usually unusable.
{.pop.}
