<meta name="google-site-verification" content="Guvcpri3VY7BhPelKDT-Bd82vkQtRn_k36gpWPcbfTo" />

I made some changes to the script. (Updated to work with the latest public release of WIndows 11 22h2) 
(11.sh and Amelioration Script.bat)

I would also recommend installing Windows Pro as gpedit is in that version of Windows for either script.

You must install Startisallback, this is a trial but a few dollars is way better than paying hundreds for a OS that spies on you due to it breaking the stock UI but works well, use the following setting to get the best out of 11.

(Startisback)
 Select the following options 
 1. (Welcome) >> "Kinda 10" 
 2. (Start Menu) >> Visual style "Default" and optionally choose the other settings you would like to use. 
 3. (Taskbar) >> Visual style "Default" and optionally choose the other settings you would like you to use.

Some helpful links 
  
  https://ameliorated.info/documentation.html https://www.youtube.com/watch?v=YTL0i5XzS7k

Windows 11 and 21H2 update history Wouldn't recommend intalling preview versions 
  
  https://support.microsoft.com/en-us/topic/windows-11-update-history-a19cd327-b57f-44b9-84e0-26ced7109ba9

Windows 11 and 22H2 update history Wouldn't recommend intalling preview versions 
  
  https://support.microsoft.com/en-us/topic/windows-11-version-22h2-update-history-ec4229c3-9c5f-4e75-9d6d-9025ab70fcce

Windows Update Catolog 
  
  https://www.catalog.update.microsoft.com/Search.aspx?

Startisback link (Required and recommend installing before running script)
  
  https://www.startallback.com/

If you forget to install startisback before running script Press CTRL+SHFT+ESC and choose run new task and locate the file and install it.

--------------------------------------------------------------------------------------------------------------------------------------------------

11s.sh and AME store apps.bat is for installing windows store apps and connecting to the internet without Microsoft updating and installing store apps automatically. You can even login to the store to retrieve the license for apps you purchased, apps tested DTS Unbound, Dolby access, Netflix, Qobuz, Razer controller app, Amazon Music, Spotify, and Candy Crush. Some apps may still not work like Minecraft and Roblox and will probably never work.

1. Install Windows 11 without a internet connection.
2. Install the latest Cumulative Update from Windows 11 22H2 update history & the update catalog. 
     (Don't install the preview Builds.)
3. Run AME store apps.bat as admin and choose option 1 and then reboot with option 5 (Before connecting to the internet) Important!
4. Connect to the intenet and install the store apps you want a lot will work but some may not but open all before proceeding to next step. 
    (You may see a bunch of apps popup in start buy they're not being installed.)
5. Install StartAllBack
6. Run the script again and choose option 2 Run Pre-Amelioration.
7. If you don't want edge put edge.bat at root and the Pre-Amelioration will run it automatically.
   (Powershell will popup once it closes you can close the extra command prompt window.)
9. Set the permissions as usual with the original script and reboot.
10. Boot into Linux and run 11s.sh once done reboot and test what apps work.
 
Warning you will see signs of Windows updating but nothing to be worried about, its mainly store apps and Windows defender nothing serious relelating to the core system components and many of these apps will be uninstalled anyways but investigate in the future.

-----------------------------------------------------------------------------------------------------------------------------------------------
For both options you will need Startisback.

If you want to install the latest security update

1. Download it from links provided on top from the change for 21H2 and 22H2.
2. Disable internet connection.
2. Boot into Linux and do "sudo ./restore.sh" at root of windows install partition.
3. Boot into windows and install update by doulble clicking and acknowledging prompts.
4. Once update completes and reboots goto start type winver and hit enter
   verify in second line starting with version and very last numbers (OS Build 00000.XXX).
5. Boot back into Linux and "sudo ./remove.sh" once complete reboot.
6. Reenable internet connection.
