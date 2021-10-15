; #Warn, All
; gui, add, text,, foobar
; gui, show, w400 h200

WatchFolder.Add("C:\Users\Public\AHK\notes\tests", "Watch1", 0, 3)
WatchFolder.Add("C:\Users\Public\AHK\notes", "Watch1", 0, 3)
WatchFolder.Add("C:\Users\Public\AHK\notes\tests", "Watch1", 0, 3)
WatchFolder.Add("C:\Users\Public\AHK\notes", "Watch1", 0, 3)

Watch1(Folder, Changes)
{

}

return
;Freezes forever
f3::ExitApp

#Include WatchFolder2.ahk