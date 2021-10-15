; ----------------------------------------------------------------------------------------------------------------------------------
Gui, Margin, 20, 20
Gui, Add, Text, , Watch Folder:
Gui, Add, Edit, xm y+3 w730 vvWatchedFolder ggFolderToWatch, Select a folder ...
Gui, Add, Progress, y+5 w730 h20 cBlue vvMyProgress, 100
; Gui, Add, Button, x+m yp w50 hp +Default vSelect gSelectFolder, ...
Gui, Add, Text, xm y+5, Watch Changes:
Gui, Add, Checkbox, xm y+3 vSubTree, In Sub-Tree
Gui, Add, Checkbox, x+5 yp vFiles Checked, Files
Gui, Add, Checkbox, x+5 yp vFolders Checked, Folders
Gui, Add, Checkbox, x+5 yp vAttr, Attributes
Gui, Add, Checkbox, x+5 yp vSize, Size
Gui, Add, Checkbox, x+5 yp vWrite, Last Write
Gui, Add, Checkbox, x+5 yp vAccess, Last Access
Gui, Add, Checkbox, x+5 yp vCreation, Creation
Gui, Add, Checkbox, x+5 yp vSecurity, Security
Gui, Add, ListView, xm w800 r15 vLV, TickCount|Folder|Action|Name|IsDir|OldName|%A_Space%
Gui, Add, Button, xm w100 gStartStop vAction +Disabled, Start
Gui, Add, Button, x+m yp wp gPauseResume vPause +Disabled, Pause
Gui, Add, Button, x+m yp wp gCLear, Clear
Gui, Show, , Watch Folder
GuiControl, Focus, Select

FolderFromScript:="C:\Users\Public\AHK\notes\testsCMD dIR"
if (checkFolderToWatch(FolderFromScript)) {
   GuiControl, Text, vWatchedFolder, % FolderFromScript
}

Return
checkFolderToWatch(folderToWatch) {
   global
   If InStr(FileExist(folderToWatch), "D") {
      WatchedFolder:=folderToWatch
      GuiControl, Enable, Action
      GuiControl, +cBlue, vMyProgress
      return true
   } else {
      GuiControl, Disable, Action
      GuiControl, +cRed, vMyProgress
      return false
   }
}
; ----------------------------------------------------------------------------------------------------------------------------------
GuiClose:
ExitApp
; ----------------------------------------------------------------------------------------------------------------------------------
Clear:
   LV_Delete()
Return
; ----------------------------------------------------------------------------------------------------------------------------------
PauseResume:
   GuiControlGet, Caption, , Pause
   If (Caption = "Pause") {
      WatchFolder.Pause()
      GuiControl, Disable, Action
      GuiControl, , Pause, Resume
   }
   ELse {
      WatchFolder.UnPause()
      GuiControl, Enable, Action
      GuiControl, , Pause, Pause
   }
Return
; ----------------------------------------------------------------------------------------------------------------------------------
StartStop:
   Gui, +OwnDialogs
   Gui, Submit, NoHide
   If !InStr(FileExist(WatchedFolder), "D") {
      MsgBox, 0, Error, "%WatchedFolder%" isn't a valid folder name!
      Return
   }
   GuiControlGet, Caption, , Action
   If (Caption = "Start") {
      GuiControl, +ReadOnly +cGray, vWatchedFolder
      Watch := 0
      Watch |= Files ? 1 : 0
      Watch |= Folders ? 2 : 0
      Watch |= Attr ? 4 : 0
      Watch |= Size ? 8 : 0
      Watch |= Write ? 16 : 0
      Watch |= Access ? 32 : 0
      Watch |= Creation ? 64 : 0
      Watch |= Security ? 256 : 0
      If (Watch = 0) {
         GuiControl, , Files, 1
         GuiControl, , Folders, 1
         Watch := 3
      }
      If !WatchFolder.Add(WatchedFolder, "MyUserFunc", SubTree, Watch) {
         MsgBox, 0, Error, Call of WatchFolder() failed!
         Return
      }
      GuiControl, , Action, Stop
      GuiControl, Disable, Select
      GuiControl, Enable, Pause
   }
   Else {
      GuiControl, -ReadOnly +cDefault, vWatchedFolder
      WatchFolder.Remove(WatchedFolder)
      GuiControl, , Action, Start
      GuiControl, Enable, Select
      GuiControl, Disable, Pause
   }
Return
; ----------------------------------------------------------------------------------------------------------------------------------
gFolderToWatch:
; SelectFolder:
   GuiControlGet, EditText,, vWatchedFolder
   checkFolderToWatch(EditText)
Return
; ----------------------------------------------------------------------------------------------------------------------------------
MyUserFunc(Folder, Changes) {
   Static Actions := ["1 (added)", "2 (removed)", "3 (modified)", "4 (renamed)"]
   TickCount := A_TickCount
   GuiControl, -ReDraw, LV
   For Each, Change In Changes
      LV_Modify(LV_Add("", TickCount, Folder, Actions[Change.Action], Change.Name, Change.IsDir, Change.OldName, ""), "Vis")
   Loop, % LV_GetCount("Columns")
      LV_ModifyCol(A_Index, "AutoHdr")
   GuiControl, +Redraw, LV
}
return
;Freezes forever
f3::ExitApp

#Include WatchFolder2.ahk