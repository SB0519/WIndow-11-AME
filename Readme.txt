I made some changes to the script.     (Updated to work with the latest public release of WIndows 11 22h2)

1. I added the ability to install the latest security patch from script which can be downloaded from the update catalog site you can get the latest KB from the latest windows 11 update history site.
-In root of C:\

2. You must install Startisallback, this is a trial but a few dollars is way better than paying hundreds for a OS that spies on you due to it breaking the stock UI but works well, use the following setting to get the best out of 11.

(Startisback)Select the following options (11.sh and Amelioration Script.bat)
-(Welcome) >> "Kinda 10"
-(Start Menu) >> Visual style "Default" and optionally choose the other settings you would like to use.
-(Taskbar) >> Visual style "Default" and optionally choose the other settings you would like you to use.

-This script gives you the ability to install Dolby Atmos automatically most may not need but maybe helpful if you have a TV or surround sound to support it to enable it right click the sound icon from taskbar highlight sound setup and choose Dolby Atmos and you should see Dolby Atmos on you your TV info. There maybe minor bugs but works well for the most part. If you have to mute and unmute to get audio working for instance watching youtube try updating your TV's firmware fixed on my LG CX TV.

3. The Linux script has changed to 11.sh at the end of the script it will ask if you want to restore clipsvc.dll which you require for Dolby Atmos app but just do ctrl-c to cancel if you didn't install it.

Some helpful links
https://ameliorated.info/documentation.html
https://www.youtube.com/watch?v=YTL0i5XzS7k


Windows 11 and 21H2 update history Wouldn't recommend intalling preview versions
https://support.microsoft.com/en-us/topic/windows-11-update-history-a19cd327-b57f-44b9-84e0-26ced7109ba9

Windows 11 and 22H2 update history Wouldn't recommend intalling preview versions
https://support.microsoft.com/en-us/topic/windows-11-version-22h2-update-history-ec4229c3-9c5f-4e75-9d6d-9025ab70fcce

Windows Update Catolog
https://www.catalog.update.microsoft.com/Search.aspx?

Startisback link (Required and recommend installing before running script)

https://www.startallback.com/

I don't know if anyone uses Dolby ATMOS just message me and I may provide a google drive link in the future.

_______________________________________________________________________________________________________________

11s.sh and  AME store apps.bat is for installing windows store apps and connecting to the internet without Microsoft updating and installing store apps automatically. You can even loging in to the store to retrieve the license for apps you purchased, apps tested DTS Unbound, Dolby access, Netflix, Qobuz, Razer controller app, Amazon Music, Spotify, and Candy Crush. Some apps may still not work like Minecraft and Roblox and will probably never work.

1. Install Windows 11 without a internet connection.
2. Install the latest Cumulative Update from Windows 11 22H2 update history & the update catalog.
   (Don't install the preview Builds.)
3. Run AME store apps.bat as admin and choose option 1 and then reboot with option 5
   (Before connecting to the internet) Important!
4. Connect to the intenet and install the store apps you want a lot will work but some may not but open all before proceeding to next step.
    (You may see a bunch of apps popup in start buy they're not being installed.)
5. Install StartAllBack
6. Run the script again and choose option 2 Run Pre-Amelioration.
7. If you don't want edge put edge.bat at root and the Pre-Amelioration will run it automatically
   (Powershell will popup once it closes you can close the extra command prompt window.)
8. Set the permissions as usual with the original script and reboot.
9. Boot into Linux and run 11s.sh once done reboot and test what apps work.
