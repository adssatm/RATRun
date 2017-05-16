Set oShell 	= WScript.CreateObject ("WScript.Shell")
Set oFSO 	= CreateObject("Scripting.FileSystemObject")

sPathNodeAppium1 = "C:\\Program Files\\Appium\\node_modules" 
sPathNodeAppium2 = "C:\\Program Files (x86)\\Appium\\node_modules"
sPathNodeAppium3 = "C:\\Appium\\node_modules"  

If Not oShell.AppActivate("node appium") then
	If oFSO.FolderExists(sPathNodeAppium1) Then
		oShell.run "cmd /K CD /D C:\\Program Files\\Appium\\node_modules & node appium -p " & WScript.Arguments(0) & " -bp 2251 -U " & WScript.Arguments(2)
		oShell.run "cmd /K CD /D C:\\Program Files\\Appium\\node_modules & node appium -p " & WScript.Arguments(1) & " -bp 2252 -U " & WScript.Arguments(3)
	ElseIf oFSO.FolderExists(sPathNodeAppium2) Then
		oShell.run "cmd /K CD /D C:\\Program Files (x86)\\Appium\\node_modules & node appium -p " & WScript.Arguments(0) & " -bp 2251 -U " & WScript.Arguments(2)
		oShell.run "cmd /K CD /D C:\\Program Files (x86)\\Appium\\node_modules & node appium -p " & WScript.Arguments(1) & " -bp 2252 -U " & WScript.Arguments(3)
	ElseIf oFSO.FolderExists(sPathNodeAppium3) Then
		oShell.run "cmd /K CD /D C:\\Appium\\node_modules & node appium -p " & WScript.Arguments(0) & " -bp 2251 -U " & WScript.Arguments(2)
		oShell.run "cmd /K CD /D C:\\Appium\\node_modules & node appium -p " & WScript.Arguments(1) & " -bp 2252 -U " & WScript.Arguments(3)
	Else
		Msgbox "Please, Not have appium program on machine!", vbInformation
	End If
End If
Set oFSO 	= Nothing
Set oShell 	= Nothing

