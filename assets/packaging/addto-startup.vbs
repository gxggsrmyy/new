Option Explicit
Dim wsh, fso, link, BtnCode, ScriptDir, FilePaths, i

Set wsh = WScript.CreateObject("WScript.Shell")
Set fso = CreateObject("Scripting.FileSystemObject")

Function CreateShortcut(FilePath)
    Set wsh = WScript.CreateObject("WScript.Shell")
    Set link = wsh.CreateShortcut(wsh.SpecialFolders("Startup") + "\zebra.lnk")
    link.TargetPath = FilePath
    link.Arguments = ""
    link.WindowStyle = 7
    link.Description = "Zebra"
    link.WorkingDirectory = wsh.CurrentDirectory
    link.Save()
End Function

BtnCode = wsh.Popup("是否将 zebra.exe 加入到启动项？(本对话框 6 秒后消失)", 6, "Zebra 对话框", 1+32)
If BtnCode = 1 Then
    ScriptDir = CreateObject("Scripting.FileSystemObject").GetParentFolderName(WScript.ScriptFullName)
    FilePaths = Array(ScriptDir + "\zebra-gui.exe", ScriptDir + "\zebra.exe")
    For i = 0 to ubound(FilePaths)
        If Not fso.FileExists(FilePaths(i)) Then
            wsh.Popup "当前目录下不存在 " + FilePaths(i), 5, "Zebra 对话框", 16
            WScript.Quit
        End If
    Next
    CreateShortcut(FilePaths(0))
    wsh.Popup "成功加入 Zebra 到启动项", 5, "Zebra 对话框", 64
End If
