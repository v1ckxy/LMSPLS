@echo off
cd /D "%~dp0"
set "CurrentPath=%CD%"

if exist "%CurrentPath%\desktop.ini" (
	attrib -H -S -R "%CurrentPath%\desktop.ini"
)

(
echo [.ShellClassInfo]
echo IconResource=folder.ico,0
) > "desktop.ini"

if exist "%CurrentPath%\folder.ico" (
	attrib +R "%CurrentPath%"
	attrib +H +S "%CurrentPath%\desktop.ini"
	attrib +H +S "%CurrentPath%\folder.ico"
) else (
	echo File folder.ico not found
	pause
	exit
)