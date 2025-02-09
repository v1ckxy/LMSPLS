# LM Studio Portable Launch Script (LMS PLS)
> ℹ️ Latest version tested: **0.3.9 build 6**

## Installation
Just create a directory and put the .cmd files inside it:
1. Execute *launchLMS.cmd*
   - It will create some directories and will ask you to download "LM-Studio-\*.exe" from his website
   - Download it and put it inside \<currentPath\>\\Installer path 
     > ℹ️ Name should be: LM-Studio-whatever.exe

2. Execute *launchLMS.cmd* again
   - LM Studio will be automatically installed under \<currentPath\>\\App
   - After installation, LM Studio will be automatically started
     - Download a model, check configuration, etc...
     - Everything should be as it was before on next run

## Launching as a service
You can start *launchLMS_service.cmd* to run LMS in headless mode.
  > ℹ️ If its not installed, will be installed automatically as the normal script.

## MultiGPU Scenarios
Simply set the following variable at the beginning of the script:

`set CUDA_VISIBLE_DEVICES=X`

Being **X**:
   - 0 for the 1st GPU
   - 1 for the 2nd
   - 2 for the 3rd (and so on)

> ℹ️ Specify multiple GPUs with commas: 1,2,3

> ℹ️ ROCm & HIP have similar variables (https://rocm.docs.amd.com/en/latest/conceptual/gpu-isolation.html)

## Extra info
- Models will be saved under \<currentPath\>\\.lmstudio\\models
- `_gpuX.cmd` scripts will launch normal script with cuda device set as **X**
- `_debug.cmd` scripts will write down all output to console and will wait for a keypress before closing it.
  - Probably useful for debugging purposes.

## Known Bugs / Quirks
NSIS Installer will check registry for previously installed versions and will uninstall the previously installed version if found.\
To avoid that, the script will try to clean-up these registry keys BEFORE and AFTER installation.

Current version (**0.3.9 build 6**) registry Keys for "current user" installation :
  1. HKCU\\Software\\c6dbe996-22a9-5998-b542-7abe33da3b83
  2. HKCU\\Software\\Microsoft\\Windows\\CurrentVersion\\Uninstall\\c6dbe996-22a9-5998-b542-7abe33da3b83

> ℹ️ Not tested under system-wide installs

_That aside_, I don't think there is any behavior out of the ordinary anymore.

## Folder Icon
You can either:
   - Execute `setFolderIcon.cmd` _or_ 
   - Open a CMD/terminal window inside the portable app dir and manually set proper permissions:
      ```
      attrib +R .
      attrib +H +S desktop.ini
      attrib +H +S icon.ico
      ```

## License
GNU General Public License v3.0