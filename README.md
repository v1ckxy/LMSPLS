# LM Studio Portable Launch Script (LMS PLS)

## Installation
Just create a directory and put the .cmd files inside it:
- Execute *launchLMS.cmd*
  - It will create some directories and will ask you to download "LM-Studio-x.y.z.exe" from his website
  - Download it and put it inside \<currentPath\>\\Installers path

- Execute *launchLMS.cmd* again
  - LMStudio will install. 
    - Install it for "current user" (only for me) in the default path: \<currentPath\>\\AppData\\Local\\Programs\\LM Studio
      - Be sure to check current install path.
  - Deselect "Run LM Studio", click on Finish.

- Execute *launchLMS.cmd* **(yes, again)**
  - In case you don't skip onboarding, you'll be prompted to "Enable local LLM service on login" in the "Download your first local LLM" page:
      ⚠️ **Disable it** ⚠️ 

  - Download a model, check configuration, etc...
  - Close LM Studio

  - Everything should be as it was before on next run

## Launching as a service
After normal installation, you can start *launchLMS_service.cmd* to run LMS in headless mode.

## Known Bugs
LMS will populate \<currentPath\>\\UserProfile\\.lmstudio with some (empty) dirs and config-presets (json).  
Those config-presets aren't actually being downloaded from the internet, but recreated upon launch.  

I've set up the script to grab those and sync them with the portable dirs:  
The path is being used by electron upon launch and the app will crash if its forcefully deleted while it's running (content is not)  

## Folder Icon
You can either...  
- Execute setFolderIcon.cmd  

or

- Open a CMD/terminal window inside the portable app dir and execute three comands:
```
attrib +R .
attrib +H +S desktop.ini
attrib +H +S icon.ico
```

## License
GNU General Public License v3.0