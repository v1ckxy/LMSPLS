@echo off && setlocal EnableDelayedExpansion
rem VXN LMStudio Portable Launch Script (LMS PLS)

rem Modify in case you want to change in which GPU(s) you want to load models.
rem 0 (1st GPU), 1 (2nd), 2 (3rd) and so on. Specify multiple GPUs with commas: 1,2,3
rem set CUDA_VISIBLE_DEVICES=1

rem Get current path and set log file on it
cd /D "%~dp0"
set "CurrentPath=%CD%"

rem Set current lmstudio home
echo %CurrentPath%\.lmstudio > "%CurrentPath%\.lmstudio-home-pointer"

rem Set current drive as %HomeDrive%
set "HomeDrive=%~d0"
echo [%DATE% %TIME:,=.%] HomeDrive: %HomeDrive%

rem \
set "HomePath=%cd:~2%"
echo [%DATE% %TIME:,=.%] HomePath: %HomePath%
set "UserProfile=%CurrentPath%"
echo [%DATE% %TIME:,=.%] UserProfile: %UserProfile%

rem \AppData\Local
set "LocalAppData=%CurrentPath%\AppData\Local"
echo [%DATE% %TIME:,=.%] LocalAppData: %LocalAppData%

rem \AppData\Local
set "LocalLowAppData=%CurrentPath%\AppData\LocalLow"
echo [%DATE% %TIME:,=.%] LocalLowAppData: %LocalLowAppData%

rem \AppData\Local\Temp
set "Temp=%LocalAppData%\Temp"
echo [%DATE% %TIME:,=.%] Temp: %Temp%

rem \AppData\Roaming
set "AppData=%CurrentPath%\AppData\Roaming"
echo [%DATE% %TIME:,=.%] AppData: %AppData%

rem Set \AppPath
set "AppPath=%CurrentPath%\App"
echo [%DATE% %TIME:,=.%] AppPath: %AppPath%

rem Create paths if doesn't exist
if not exist "%UserProfile%\Desktop" mkdir "%UserProfile%\Desktop"
if not exist "%UserProfile%\AppData" mkdir "%UserProfile%\AppData"
if not exist "%LocalLowAppData%" mkdir "%LocalLowAppData%"
if not exist "%LocalAppData%" mkdir "%LocalAppData%"
if not exist "%AppData%" mkdir "%AppData%"
if not exist "%AppPath%" mkdir "%AppPath%"
if not exist "%Temp%" mkdir "%Temp%"

rem Check if latest installer is ready for installation, in case needed
set "InstallerPath=%CurrentPath%\Installer"
echo [%DATE% %TIME:,=.%] InstallerPath: %InstallerPath%
if not exist "%InstallerPath%" mkdir "%InstallerPath%"

for /f "delims=" %%A in ('dir /b /a-d /on "%InstallerPath%\LM-Studio-*.exe" 2^>nul') do ( set "InstallerExe=%%A" )

rem Skip functions and go directly to :main
goto :main

:cleanUpRegistry
   rem LM Studio Installer registry clean-up
   set "regKey=HKEY_CURRENT_USER\Software\c6dbe996-22a9-5998-b542-7abe33da3b83"
   echo [%DATE% %TIME:,=.%] Checking if key "%regKey%" exists...
   reg query "%regKey%" >nul
   if %errorlevel% equ 0 (
      reg delete "%regKey%" /f
   ) else (
      echo [%DATE% %TIME:,=.%] Perfect, key doesn't exist.
   )
   set "regKey=HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Uninstall\c6dbe996-22a9-5998-b542-7abe33da3b83"
   echo [%DATE% %TIME:,=.%] Checking if key "%regKey%" exists...
   reg query "%regKey%" >nul
   if %errorlevel% equ 0 (
      reg delete "%regKey%" /f
   ) else (
      echo [%DATE% %TIME:,=.%] Perfect, key doesn't exist.
   )
exit /b 0

:main
rem Application Startup
if not exist "%AppPath%\LM Studio.exe" (
   echo [%DATE% %TIME:,=.%] LM Studio not installed in "%AppPath%"
   echo [%DATE% %TIME:,=.%] Performing installation...
   if "%InstallerExe%" == "" (
      echo [%DATE% %TIME:,=.%] LM Studio installer ^(LM-Studio-*.exe^) was not found.
      echo [%DATE% %TIME:,=.%] Please download LM Studio from https://lmstudio.ai/download and put the installer file inside "%InstallerPath%"
      pause && exit
   ) else (
      echo [%DATE% %TIME:,=.%] Performing initial registry cleanup...
      call :cleanUpRegistry
      echo [%DATE% %TIME:,=.%] Launching installer "%InstallerExe%" from "%InstallerPath%"
      call "%InstallerPath%\%InstallerExe%" /S /D="%AppPath%"
      echo [%DATE% %TIME:,=.%] LM Studio installed, cleaning up registry and launching it...
      call :cleanUpRegistry
      timeout /t 10
   )
) else (
   rem Modify models path in settings.json to the current drive
   set "inputFile=%AppData%\LM Studio\settings.json"
   echo [%DATE% %TIME:,=.%] Settings file: !inputFile!
	if not exist "!inputFile!" (
      echo [%DATE% %TIME:,=.%] File !inputFile! not found, will be generated upon launch and fixed on next run...
      timeout /t 10
   ) else (
      set "tempFile=%AppData%\LM Studio\settings_temp.json"
      echo [%DATE% %TIME:,=.%] tempFile: !tempFile!
      set searchString=downloadsFolder
      
      rem "downloadsFolder": "..\\..\\..\\..\\.lmstudio\\models",
      set replaceString=  "downloadsFolder": "%UserProfile:\=\\%\\.lmstudio\\models",
      echo [%DATE% %TIME:,=.%] replaceString: !replaceString!
      (
         rem Recreate config file with a modified downloadsFolder
         for /f "usebackq delims=" %%A in ("!inputFile!") do (
            set "line=%%A"
            echo !line! | findstr /c:!searchString! >nul
            if !errorlevel! equ 0 (
               rem Replace line if the string is found
               echo !replaceString!
            ) else (
               rem Keep rest of lines
               echo !line!
            )
         )
      ) > "!tempFile!"

      rem Replace original settings file with modified one
      echo [%DATE% %TIME:,=.%] Replacing !inputFile! with modified !tempFile!...
      move /y "!tempFile!" "!inputFile!"
   )
)

if exist "%AppPath%\LM Studio.exe" (
   rem Start app
   call "%AppPath%\LM Studio.exe"
   pause && exit
) else (
   echo Please check why LM Studio was not properly installed under %AppPath%
   pause && exit
)