Set oShell 	= WScript.CreateObject ("WScript.Shell")
oShell.run "cmd /C Taskkill /F /IM node.exe"
oShell.run "cmd /C Taskkill /F /IM cmd.exe"
Set oShell 	= Nothing