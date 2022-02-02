#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
#SingleInstance, force
ListLines Off
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
SetBatchLines, -1
#KeyHistory 0

; #include <WatchFolder2>
#include WatchFolder2.ahk

assert(WatchFolder._Normalize_Path(""), false)
assert(WatchFolder._Normalize_Path("C:\"), "C:\")
assert(WatchFolder._Normalize_Path("C:"), "C:\")
assert(WatchFolder._Normalize_Path(":"), false)
assert(WatchFolder._Normalize_Path("joifjwoiejgweg"), false)
assert(WatchFolder._Normalize_Path("C:\doesnotexist"), false)

assert(WatchFolder._Normalize_Path(A_ScriptName), A_ScriptDir "\" A_ScriptName)

assert(value1, value2) {
    if (!(value1==value2)) {
        Clipboard:=value1 "`n" value2
        MsgBox % value1 "`n" value2
    }
}

Exitapp


f3::Exitapp