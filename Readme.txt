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

I will be uploading an updated script for people that want to install store apps and can even login to obtaine licensed apps. What will happem is you'll install Windows 22H2 and then run the ame option 1 which will disable auto update from installing updates through a group policy and then reg keys to prevent your store login to be shared in Windows like in the settings app and to prevent the store from automatically installing app except teams but it will be uninstalled later with the script. I have managed to remove some .dll files with the Linux script and using netstat -t & -b to verify that there aren't any pernament connections. I would say the original method is probably safer however I think this new script is fairly a great option. The following apps that was tested was Netflix app, Spotify app, Razer controller app, Dolby Unbound with license retrieval, Dolby Atmos, and Qobuz. I will also offer an option to strip out MS Edge from both versions of the scripts.

