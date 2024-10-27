cd /D "%~dp0"
set "CurrentPath=%CD%"

if exist "%CurrentPath%\desktop.ini" (
	if exist "%CurrentPath%\LMSFolder.ico" (
		attrib +R "%CurrentPath%"
		attrib +H +S +R "%CurrentPath%\desktop.ini"
		attrib +H +S +R "%CurrentPath%\LMSFolder.ico"
		del /P "%CurrentPath%\setFolderIcon.cmd"
    )
)