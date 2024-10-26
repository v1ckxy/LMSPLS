# LMStudio Portable Launch Script (LMS PLS)

## Installation
Just create a directory and put the .cmd files inside it:
- Execute *launchLMS.cmd*
  - It will create some directories and will ask you to download "LM-Studio-x.y.z-Setup.exe" from his website
  - Download it and put it inside \Installers path

- Execute *launchLMS.cmd* again
  - LMStudio will install. 
    - In case you don't skip onboarding, you'll be prompted to "Enable local LLM service on login" in the "Download your first local LLM" page:
      ⚠️ **Disable it** ⚠️ 

  - Download a model, check configuration, etc...
  - Close LM Studio

- Execute *launchLMS.cmd* **again**
  - Everything should be as it was before.

## Launching as a service
After normal installation, you can start *launchLMS_service.cmd* to run LMS in headless mode.

## Known Bugs
LMS will populate *UserProfile\.cache\lm-studio* with some <empty> dirs and config-presets (json) during launch.  
Those config-presets aren't actually being downloaded from the internet, but recreated.  

I've set up the script to grab those and sync them with the portable dirs:  
The path is being used by electron upon launch and the app will crash if its forcefully deleted while it's running (content is not)  

## License
GNU General Public License v3.0