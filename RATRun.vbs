Dim oShell,oFSO,sExistFolder,sProjectPath,sProject,sProjectRun
Set oShell 	= WScript.CreateObject ("WScript.Shell")
Set oFSO 	= CreateObject("Scripting.FileSystemObject")

sProject = InputBox("Enter your project name!","RAT Run Information")
If sProject <> "" Then
	sProjectRun = oShell.CurrentDirectory & "\Library\RATRobot\RATRun_" & sProject
	If oFSO.FolderExists(sProjectRun) Then 
		sExistFolder = oShell.CurrentDirectory & "\Result\TempLogResult"
		sProjectPath = Replace(oShell.CurrentDirectory & "\Library\RATRobot\RATRun_" & sProject ," ","*")

		If Not oFSO.FolderExists(sExistFolder) Then
		  oFSO.CreateFolder sExistFolder
		End If

		oShell.run "cmd /K CD  Result\TempLogResult\ & robot " & sProjectPath & "\RATRun.robot"
	Else
		Msgbox "This project name [" & sProject & "] is not exist!", vbInformation, "RAT Run Information"
	End If
Else
	Msgbox "Please insert your project name!", vbInformation, "RAT Run Information"
End If

Set oShell 	= Nothing
Set oFSO 	= Nothing