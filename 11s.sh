#!/bin/bash

clear
echo "                 ╔═══════════════╗"
echo "                 ║ !!!WARNING!!! ║"
echo "╔════════════════╩═══════════════╩══════════════════╗"
echo "║ This script comes without any warranty.           ║"
echo "║ If your computer no longer boots, explodes, or    ║"
echo "║ divides by zero, you are the only one responsible ║"
echo "╟╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╢"
echo "║ This script only works on Debian based distros.   ║"
echo "║ An Ubuntu 16.04/18.04 Live ISO is recommended.    ║"
echo "╚═══════════════════════════════════════════════════╝"
echo ""
read -p "To continue press [ENTER], or Ctrl-C to exit"

title_bar() {
	clear
	echo "╔═══════════════════════════════════════════════════════════╗"
	echo "║             AMEliorate Windows 11 22H2      09.21.22      ║"
	echo "║  Give credit to the original team they are better than me ║"
	echo "╚═══════════════════════════════════════════════════════════╝"
}

# prompts to install git and 7zip if not already installed
title_bar
sudo apt update
PKG_OK=$(dpkg-query -W --showformat='${Status}\n' git|grep "install ok installed")
echo "Checking for git: $PKG_OK"
if [ "" == "$PKG_OK" ]; then
	echo "curl not found, prompting to install git..."
	sudo apt-get -y install git
fi
PKG_OK=$(dpkg-query -W --showformat='${Status}\n' p7zip-full|grep "install ok installed")
echo "Checking for 7zip: $PKG_OK"
if [ "" == "$PKG_OK" ]; then
	echo "curl not found, prompting to install 7zip..."
	sudo apt-get -y install p7zip-full
fi

# prompts to install fzf if not already installed
title_bar
echo "fzf is required for this script to function"
echo "Please allow for fzf to install following this message"
echo "Enter "y" (yes) for all prompts"
read -p "To continue press [ENTER], or Ctrl-C to exit"
echo "\n"
title_bar
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install

# start AME process
title_bar
echo "Starting AME process, searching for files..."
Term=(applocker autologger clipsvc clipup cortana DeliveryOptimization diagtrack dmclient dosvc EnhancedStorage homegroup hotspot invagent microsoftedge.exe msra sihclient slui startupscan storsvc usoclient usocore windowsmaps windowsupdate wsqmcons wua wus)
touch fzf_list.txt
for i in "${Term[@]}"
do
	echo "Looking for $i"
	$HOME/.fzf/bin/fzf -e -f $i >> fzf_list.txt
done

# check if fzf found anything
title_bar
FZFCHECK = wc -l fzf_list.txt
if FZFCHECK = 0; then
	echo "ERROR! no files found, exiting..."
	exit 1
elif FZFCHECK > 0; then
	echo "Directory file not empty, continuing..."
fi

# directory processing starts here!
rm dirs*
touch dirs.txt

# removes the FileMaps directories/files
awk '!/FileMaps/' fzf_list.txt > fzf_list_cleaned.txt
# removes everything after the last slash in the file list
sed 's%/[^/]*$%/%' fzf_list_cleaned.txt >> dirs.txt

# removes a trailing slash, repeats several times to get all the directories
for a in {0..12..2}
do
        if [ $a -eq 0 ]
        then
                cat dirs.txt > dirs$a.txt
        fi
        b=$((a+1))
        c=$((b+1))
        sed 's,/$,,' dirs$a.txt >> dirs$b.txt
        sed 's%/[^/]*$%/%' dirs$b.txt >> dirs$c.txt
        cat dirs$c.txt >> dirs.txt
done

# removes duplicates and sorts by length
awk '!a[$0]++' dirs.txt > dirs_deduped.txt
awk '{ print length($0) " " $0; }' dirs_deduped.txt | sort -n | cut -d ' ' -f 2- > dirs_sorted.txt
# appends root backup directory
awk -v quote='"' '{print "mkdir " quote "AME_Backup/" $0 quote}' dirs_sorted.txt > mkdirs.sh
# adds some needed things
echo 'mkdir "AME_Backup/Program Files (x86)"' | cat - mkdirs.sh > temp && mv temp mkdirs.sh
echo 'mkdir AME_Backup/Windows/SoftwareDistribution' | cat - mkdirs.sh > temp && mv temp mkdirs.sh
echo 'mkdir AME_Backup/Windows/InfusedApps' | cat - mkdirs.sh > temp && mv temp mkdirs.sh
echo 'mkdir AME_Backup/Windows' | cat - mkdirs.sh > temp && mv temp mkdirs.sh
echo 'mkdir AME_Backup' | cat - mkdirs.sh > temp && mv temp mkdirs.sh
echo '#!/bin/bash' | cat - mkdirs.sh > temp && mv temp mkdirs.sh
chmod +x mkdirs.sh
rm dirs*

# creates backup script
awk -v quote='"' '{print "cp -fa --preserve=all " quote $0 quote " " quote "AME_Backup/" $0 quote}' fzf_list_cleaned.txt > backup.txt
# adds individual directories to top of script
echo 'cp -fa --preserve=all "Program Files/Internet Explorer" "AME_Backup/Program Files/Internet Explorer"' | cat - backup.txt > temp && mv temp backup.txt
echo 'cp -fa --preserve=all "Program Files/WindowsApps" "AME_Backup/Program Files/WindowsApps"' | cat - backup.txt > temp && mv temp backup.txt
echo 'cp -fa --preserve=all "Program Files/Windows Defender" "AME_Backup/Program Files/Windows Defender"' | cat - backup.txt > temp && mv temp backup.txt
echo 'cp -fa --preserve=all "Program Files/Windows Mail" "AME_Backup/Program Files/Windows Mail"' | cat - backup.txt > temp && mv temp backup.txt
echo 'cp -fa --preserve=all "Program Files/Windows Media Player" "AME_Backup/Program Files/Windows Media Player"' | cat - backup.txt > temp && mv temp backup.txt
echo 'cp -fa --preserve=all "Program Files (x86)/Internet Explorer" "AME_Backup/Program Files (x86)/Internet Explorer"' | cat - backup.txt > temp && mv temp backup.txt
echo 'cp -fa --preserve=all "Program Files (x86)/Windows Defender" "AME_Backup/Program Files (x86)/Windows Defender"' | cat - backup.txt > temp && mv temp backup.txt
echo 'cp -fa --preserve=all "Program Files (x86)/Windows Mail" "AME_Backup/Program Files (x86)/Windows Mail"' | cat - backup.txt > temp && mv temp backup.txt
echo 'cp -fa --preserve=all "Program Files (x86)/Windows Media Player" "AME_Backup/Program Files (x86)/Windows Media Player"' | cat - backup.txt > temp && mv temp backup.txt
echo 'cp -fa --preserve=all Windows/System32/wua* AME_Backup/Windows/System32' | cat - backup.txt > temp && mv temp backup.txt
echo 'cp -fa --preserve=all Windows/System32/wups* AME_Backup/Windows/System32' | cat - backup.txt > temp && mv temp backup.txt
echo 'cp -fa --preserve=all Windows/SystemApps/*CloudExperienceHost* AME_Backup/Windows/SystemApps' | cat - backup.txt > temp && mv temp backup.txt
echo 'cp -fa --preserve=all Windows/SystemApps/*ContentDeliveryManager* AME_Backup/Windows/SystemApps' | cat - backup.txt > temp && mv temp backup.txt
echo 'cp -fa --preserve=all Windows/SystemApps/Microsoft.MicrosoftEdge* AME_Backup/Windows/SystemApps' | cat - backup.txt > temp && mv temp backup.txt
echo 'cp -fa --preserve=all Windows/SystemApps/Microsoft.Windows.Cortana* AME_Backup/Windows/SystemApps' | cat - backup.txt > temp && mv temp backup.txt
echo 'cp -fa --preserve=all Windows/SystemApps/Microsoft.XboxGameCallableUI* AME_Backup/Windows/SystemApps' | cat - backup.txt > temp && mv temp backup.txt
echo 'cp -fa --preserve=all Windows/diagnostics/system/Apps AME_Backup/Windows/diagnostics/system' | cat - backup.txt > temp && mv temp backup.txt
echo 'cp -fa --preserve=all Windows/diagnostics/system/WindowsUpdate AME_Backup/Windows/diagnostics/system' | cat - backup.txt > temp && mv temp backup.txt
echo '#!/bin/bash' | cat - backup.txt > temp && mv temp backup.txt
awk '{ print length($0) " " $0; }' backup.txt | sort -n | cut -d ' ' -f 2- > backup.sh
rm backup.txt
chmod +x backup.sh

# creates recovery script
awk -v quote='"' '{print "cp -fa --preserve=all " quote "AME_Backup/" $0 quote " " quote $0 quote}' fzf_list_cleaned.txt > restore.txt
echo 'cp -fa --preserve=all "AME_Backup/Program Files/Internet Explorer" "Program Files/Internet Explorer"' | cat - restore.txt > temp && mv temp restore.txt
echo 'cp -fa --preserve=all "AME_Backup/Program Files/WindowsApps" "Program Files/WindowsApps"' | cat - restore.txt > temp && mv temp restore.txt
echo 'cp -fa --preserve=all "AME_Backup/Program Files/Windows Defender" "Program Files/Windows Defender"' | cat - restore.txt > temp && mv temp restore.txt
echo 'cp -fa --preserve=all "AME_Backup/Program Files/Windows Mail" "Program Files/Windows Mail"' | cat - restore.txt > temp && mv temp restore.txt
echo 'cp -fa --preserve=all "AME_Backup/Program Files/Windows Media Player" "Program Files/Windows Media Player"' | cat - restore.txt > temp && mv temp restore.txt
echo 'cp -fa --preserve=all "AME_Backup/Program Files (x86)/Internet Explorer" "Program Files (x86)/Internet Explorer"' | cat - restore.txt > temp && mv temp restore.txt
echo 'cp -fa --preserve=all "Program Files (x86)/Windows Defender" "Program Files (x86)/Windows Defender"' | cat - restore.txt > temp && mv temp restore.txt
echo 'cp -fa --preserve=all "AME_Backup/Program Files (x86)/Windows Mail" "Program Files (x86)/Windows Mail"' | cat - restore.txt > temp && mv temp restore.txt
echo 'cp -fa --preserve=all "AME_Backup/Program Files (x86)/Windows Media Player" "Program Files (x86)/Windows Media Player"' | cat - restore.txt > temp && mv temp restore.txt
echo 'cp -fa --preserve=all AME_Backup/Windows/System32/wua* Windows/System32' | cat - restore.txt > temp && mv temp restore.txt
echo 'cp -fa --preserve=all AME_Backup/Windows/System32/wups* Windows/System32' | cat - restore.txt > temp && mv temp restore.txt
echo 'cp -fa --preserve=all AME_Backup/Windows/SystemApps/*CloudExperienceHost* Windows/SystemApps' | cat - restore.txt > temp && mv temp restore.txt
echo 'cp -fa --preserve=all AME_Backup/Windows/SystemApps/*ContentDeliveryManager* Windows/SystemApps' | cat - restore.txt > temp && mv temp restore.txt
echo 'cp -fa --preserve=all AME_Backup/Windows/SystemApps/Microsoft.MicrosoftEdge* Windows/SystemApps' | cat - restore.txt > temp && mv temp restore.txt
echo 'cp -fa --preserve=all AME_Backup/Windows/SystemApps/Microsoft.Windows.Cortana* Windows/SystemApps' | cat - restore.txt > temp && mv temp restore.txt
echo 'cp -fa --preserve=all AME_Backup/Windows/SystemApps/Microsoft.XboxGameCallableUI* Windows/SystemApps' | cat - restore.txt > temp && mv temp restore.txt
echo 'cp -fa --preserve=all AME_Backup/Windows/diagnostics/system/Apps Windows/diagnostics/system' | cat - restore.txt > temp && mv temp restore.txt
echo 'cp -fa --preserve=all AME_Backup/Windows/diagnostics/system/WindowsUpdate Windows/diagnostics/system' | cat - restore.txt > temp && mv temp restore.txt
awk '{ print length($0) " " $0; }' restore.txt | sort -n | cut -d ' ' -f 2- > restore.sh
echo 'read -p "To continue press [ENTER], or Ctrl-C to exit"' | cat - restore.sh > temp && mv temp restore.sh
echo 'echo "This script will restore all the necessary files for Windows Updates to be installed manually"' | cat - restore.sh > temp && mv temp restore.sh
echo '#!/bin/bash' | cat - restore.sh > temp && mv temp restore.sh
rm restore.txt
chmod +x restore.sh

# creates removal script
awk -v quote='"' '{print "rm -rf " quote $0 quote}' fzf_list_cleaned.txt > remove.sh
echo 'rm -rf "Program Files/Internet Explorer"' | cat - remove.sh > temp && mv temp remove.sh
#echo 'rm -rf "Program Files/WindowsApps"' | cat - remove.sh > temp && mv temp remove.sh
echo 'rm -rf "Program Files/Windows Defender"' | cat - remove.sh > temp && mv temp remove.sh
echo 'rm -rf "Program Files/Windows Mail"' | cat - remove.sh > temp && mv temp remove.sh
echo 'rm -rf "Program Files/Windows Media Player"' | cat - remove.sh > temp && mv temp remove.sh
echo 'rm -rf "Program Files (x86)/Internet Explorer"' | cat - remove.sh > temp && mv temp remove.sh
echo 'rm -rf "Program Files (x86)/Windows Defender"' | cat - remove.sh > temp && mv temp remove.sh
echo 'rm -rf "Program Files (x86)/Windows Mail"' | cat - remove.sh > temp && mv temp remove.sh
echo 'rm -rf "Program Files (x86)/Windows Media Player"' | cat - remove.sh > temp && mv temp remove.sh
echo 'rm -rf Windows/System32/wua*' | cat - remove.sh > temp && mv temp remove.sh
echo 'rm -rf Windows/System32/wpnservice.dll' | cat - remove.sh > temp && mv temp remove.sh
echo 'rm -rf Windows/System32/cloud*' | cat - remove.sh > temp && mv temp remove.sh
echo 'rm -rf Windows/SysWOW64/cloud*' | cat - remove.sh > temp && mv temp remove.sh
echo 'rm -rf Windows/System32/Cloud*' | cat - remove.sh > temp && mv temp remove.sh
echo 'rm -rf Windows/SysWOW64/Cloud*' | cat - remove.sh > temp && mv temp remove.sh
echo 'rm -rf Windows/System32/wups*' | cat - remove.sh > temp && mv temp remove.sh
echo 'rm -rf Windows/SystemApps/*CloudExperienceHost*' | cat - remove.sh > temp && mv temp remove.sh
echo 'rm -rf Windows/SystemApps/*ContentDeliveryManager*' | cat - remove.sh > temp && mv temp remove.sh
echo 'rm -rf Windows/SystemApps/Microsoft.MicrosoftEdge*' | cat - remove.sh > temp && mv temp remove.sh
echo 'rm -rf Windows/SystemApps/MicrosoftWindows.Client*' | cat - remove.sh > temp && mv temp remove.sh
echo 'rm -rf Windows/SystemApps/WindowsAppRuntime.Inbox*' | cat - remove.sh > temp && mv temp remove.sh
echo 'rm -rf Windows/SystemApps/Microsoft.Windows.Cortana*' | cat - remove.sh > temp && mv temp remove.sh
echo 'rm -rf Windows/SystemApps/Microsoft.XboxGameCallableUI*' | cat - remove.sh > temp && mv temp remove.sh
echo 'rm -rf Windows/SystemApps/Microsoft.XboxIdentityProvider*' | cat - remove.sh > temp && mv temp remove.sh
echo 'rm -rf Windows/SystemApps/MicrosoftWindows.Client.CBS*' | cat - remove.sh > temp && mv temp remove.sh
echo 'rm -rf Windows/SystemApps/Microsoft.AAD.BrokerPlugin*' | cat - remove.sh > temp && mv temp remove.sh
echo 'rm -rf Windows/SystemApps/Microsoft.AccountsControl*' | cat - remove.sh > temp && mv temp remove.sh
echo 'rm -rf Windows/SystemApps/Microsoft.AsyncTextService*' | cat - remove.sh > temp && mv temp remove.sh
echo 'rm -rf Windows/SystemApps/Microsoft.BioEnrollment*' | cat - remove.sh > temp && mv temp remove.sh
echo 'rm -rf Windows/SystemApps/microsoft.creddialoghost*' | cat - remove.sh > temp && mv temp remove.sh
echo 'rm -rf Windows/SystemApps/Microsoft.ECApp*' | cat - remove.sh > temp && mv temp remove.sh
echo 'rm -rf Windows/SystemApps/Microsoft.LockApp*' | cat - remove.sh > temp && mv temp remove.sh
echo 'rm -rf Windows/SystemApps/Microsoft.Win32WebViewHost*' | cat - remove.sh > temp && mv temp remove.sh
echo 'rm -rf Windows/SystemApps/Microsoft.Windows.AddSuggestedFoldersToLibraryDialog*' | cat - remove.sh > temp && mv temp remove.sh
echo 'rm -rf Windows/SystemApps/Microsoft.Windows.AppRep.ChxApp*' | cat - remove.sh > temp && mv temp remove.sh
echo 'rm -rf Windows/SystemApps/Microsoft.Windows.AppResolverUX*' | cat - remove.sh > temp && mv temp remove.sh
echo 'rm -rf Windows/SystemApps/Microsoft.Windows.AssignedAccessLockApp*' | cat - remove.sh > temp && mv temp remove.sh
echo 'rm -rf Windows/SystemApps/Microsoft.Windows.CallingShellApp*' | cat - remove.sh > temp && mv temp remove.sh
echo 'rm -rf Windows/SystemApps/Microsoft.Windows.CapturePicker*' | cat - remove.sh > temp && mv temp remove.sh
echo 'rm -rf Windows/SystemApps/Microsoft.Windows.FilePicker*' | cat - remove.sh > temp && mv temp remove.sh
echo 'rm -rf Windows/SystemApps/microsoft.windows.narratorquickstart*' | cat - remove.sh > temp && mv temp remove.sh
echo 'rm -rf Windows/SystemApps/Microsoft.Windows.OOBENetworkCaptivePortal*' | cat - remove.sh > temp && mv temp remove.sh
echo 'rm -rf Windows/SystemApps/Microsoft.Windows.FileExplorer*' | cat - remove.sh > temp && mv temp remove.sh
echo 'rm -rf Windows/SystemApps/Microsoft.Windows.OOBENetworkConnectionFlow*' | cat - remove.sh > temp && mv temp remove.sh
echo 'rm -rf Windows/SystemApps/Microsoft.Windows.PeopleExperienceHost*' | cat - remove.sh > temp && mv temp remove.sh
echo 'rm -rf Windows/SystemApps/Microsoft.Windows.Search*' | cat - remove.sh > temp && mv temp remove.sh
echo 'rm -rf Windows/SystemApps/Microsoft.Windows.SecureAssessmentBrowser*' | cat - remove.sh > temp && mv temp remove.sh
echo 'rm -rf Windows/SystemApps/Microsoft.Windows.StartMenuExperienceHost*' | cat - remove.sh > temp && mv temp remove.sh
echo 'rm -rf Windows/SystemApps/Microsoft.Windows.PinningConfirmationDialog*' | cat - remove.sh > temp && mv temp remove.sh
echo 'rm -rf Windows/SystemApps/Microsoft.Windows.XGpuEjectDialog*' | cat - remove.sh > temp && mv temp remove.sh
echo 'rm -rf Windows/SystemApps/MicrosoftWindows.UndockedDevKit*' | cat - remove.sh > temp && mv temp remove.sh
echo 'rm -rf Windows/SystemApps/Microsoft.Windows.PrintQueueActionCenter*' | cat - remove.sh > temp && mv temp remove.sh
echo 'rm -rf Windows/SystemApps/MicrosoftWindows.Client.Core*' | cat - remove.sh > temp && mv temp remove.sh
echo 'rm -rf Windows/SystemApps/NcsiUwpApp*' | cat - remove.sh > temp && mv temp remove.sh
echo 'rm -rf Windows/SystemApps/ParentalControls*' | cat - remove.sh > temp && mv temp remove.sh
echo 'rm -rf Windows/SystemApps/Windows.CBSPreview*' | cat - remove.sh > temp && mv temp remove.sh
echo 'rm -rf Windows/diagnostics/system/Apps' | cat - remove.sh > temp && mv temp remove.sh
echo 'rm -rf Windows/diagnostics/system/WindowsUpdate' | cat - remove.sh > temp && mv temp remove.sh
echo 'rm -rf "Windows/System32/smartscreen.exe"' | cat - remove.sh > temp && mv temp remove.sh
echo 'rm -rf "Windows/System32/smartscreenps.dll"' | cat - remove.sh > temp && mv temp remove.sh
echo 'rm -rf "Windows/System32/SecurityHealthAgent.dll"' | cat - remove.sh > temp && mv temp remove.sh
echo 'rm -rf "Windows/System32/SecurityHealthService.exe"' | cat - remove.sh > temp && mv temp remove.sh
echo 'rm -rf "Windows/System32/SecurityHealthSystray.exe"' | cat - remove.sh > temp && mv temp remove.sh
echo 'rm -rf Program\ Files/WindowsApps/Microsoft.UI.Xaml*' | cat - remove.sh > temp && mv temp remove.sh
echo 'rm -rf Program\ Files/WindowsApps/MicrosoftCorporationII.MicrosoftFamily*' | cat - remove.sh > temp && mv temp remove.sh
echo 'rm -rf Program\ Files/WindowsApps/MicrosoftCorporationII.QuickAssist*' | cat - remove.sh > temp && mv temp remove.sh
echo 'rm -rf Program\ Files/WindowsApps/Microsoft.Windows.Photos*' | cat - remove.sh > temp && mv temp remove.sh
echo 'rm -rf Program\ Files/WindowsApps/Microsoft.WindowsNotepad*' | cat - remove.sh > temp && mv temp remove.sh
echo 'rm -rf Program\ Files/WindowsApps/Microsoft.WindowsStore*' | cat - remove.sh > temp && mv temp remove.sh
echo 'rm -rf Program\ Files/WindowsApps/Microsoft.WindowsTerminal*' | cat - remove.sh > temp && mv temp remove.sh
echo 'rm -rf Program\ Files/WindowsApps/MicrosoftTeams*' | cat - remove.sh > temp && mv temp remove.sh
echo 'rm -rf Program\ Files/WindowsApps/MicrosoftWindows.Client.WebExperience*' | cat - remove.sh > temp && mv temp remove.sh
echo 'rm -rf Program\ Files/WindowsApps/Microsoft.BingNews*' | cat - remove.sh > temp && mv temp remove.sh
echo 'rm -rf Program\ Files/WindowsApps/Microsoft.BingWeather*' | cat - remove.sh > temp && mv temp remove.sh
echo 'rm -rf Program\ Files/WindowsApps/Microsoft.GamingApp*' | cat - remove.sh > temp && mv temp remove.sh
echo 'rm -rf Program\ Files/WindowsApps/Microsoft.GetHelp*' | cat - remove.sh > temp && mv temp remove.sh
echo 'rm -rf Program\ Files/WindowsApps/Microsoft.Getstarted*' | cat - remove.sh > temp && mv temp remove.sh
echo 'rm -rf Program\ Files/WindowsApps/Microsoft.MicrosoftOfficeHub*' | cat - remove.sh > temp && mv temp remove.sh
echo 'rm -rf Program\ Files/WindowsApps/Microsoft.MicrosoftSolitaireCollection*' | cat - remove.sh > temp && mv temp remove.sh
echo 'rm -rf Program\ Files/WindowsApps/Microsoft.MicrosoftStickyNotes*' | cat - remove.sh > temp && mv temp remove.sh
echo 'rm -rf Program\ Files/WindowsApps/Microsoft.Paint*' | cat - remove.sh > temp && mv temp remove.sh
echo 'rm -rf Program\ Files/WindowsApps/Microsoft.People*' | cat - remove.sh > temp && mv temp remove.sh
echo 'rm -rf Program\ Files/WindowsApps/Microsoft.PowerAutomateDesktop*' | cat - remove.sh > temp && mv temp remove.sh
echo 'rm -rf Program\ Files/WindowsApps/Microsoft.ScreenSketch*' | cat - remove.sh > temp && mv temp remove.sh
echo 'rm -rf Program\ Files/WindowsApps/Microsoft.WindowsAlarms*' | cat - remove.sh > temp && mv temp remove.sh
echo 'rm -rf Program\ Files/WindowsApps/Microsoft.WindowsCalculator*' | cat - remove.sh > temp && mv temp remove.sh
echo 'rm -rf Program\ Files/WindowsApps/Microsoft.WindowsCamera*' | cat - remove.sh > temp && mv temp remove.sh
echo 'rm -rf Program\ Files/WindowsApps/microsoft.windowscommunicationsapps*' | cat - remove.sh > temp && mv temp remove.sh
echo 'rm -rf Program\ Files/WindowsApps/Microsoft.WindowsFeedbackHub*' | cat - remove.sh > temp && mv temp remove.sh
echo 'rm -rf Program\ Files/WindowsApps/Microsoft.WindowsMaps*' | cat - remove.sh > temp && mv temp remove.sh
echo 'rm -rf Program\ Files/WindowsApps/Microsoft.WindowsSoundRecorder*' | cat - remove.sh > temp && mv temp remove.sh
echo 'rm -rf Program\ Files/WindowsApps/Microsoft.XboxGameOverlay*' | cat - remove.sh > temp && mv temp remove.sh
#echo 'rm -rf Program\ Files/WindowsApps/Microsoft.XboxIdentityProvider*' | cat - remove.sh > temp && mv temp remove.sh
echo 'rm -rf Program\ Files/WindowsApps/Microsoft.XboxSpeechToTextOverlay*' | cat - remove.sh > temp && mv temp remove.sh
echo 'rm -rf Program\ Files/WindowsApps/Microsoft.Xbox.TCUI*' | cat - remove.sh > temp && mv temp remove.sh
echo 'rm -rf Program\ Files/WindowsApps/Microsoft.YourPhone*' | cat - remove.sh > temp && mv temp remove.sh
echo 'rm -rf Program\ Files/WindowsApps/Microsoft.ZuneMusic*' | cat - remove.sh > temp && mv temp remove.sh
echo 'rm -rf Program\ Files/WindowsApps/Microsoft.ZuneVideo*' | cat - remove.sh > temp && mv temp remove.sh
echo 'rm -rf Program\ Files/WindowsApps/Microsoft.549981C3F5F10*' | cat - remove.sh > temp && mv temp remove.sh
echo 'rm -rf Program\ Files/WindowsApps/Microsoft.DesktopAppInstaller*' | cat - remove.sh > temp && mv temp remove.sh
echo 'rm -rf Program\ Files/WindowsApps/Microsoft.HEIFImageExtension*' | cat - remove.sh > temp && mv temp remove.sh
echo 'rm -rf Program\ Files/WindowsApps/Microsoft.MicrosoftEdge*' | cat - remove.sh > temp && mv temp remove.sh
echo 'rm -rf Program\ Files/WindowsApps/Microsoft.XboxGamingOverlay*' | cat - remove.sh > temp && mv temp remove.sh
echo 'rm -rf Program\ Files/WindowsApps/Clipchamp.Clipchamp*' | cat - remove.sh > temp && mv temp remove.sh
echo 'rm -rf Program\ Files/WindowsApps/Microsoft.SecHealthUI*' | cat - remove.sh > temp && mv temp remove.sh
echo 'rm -rf Program Files/WindowsApps/Microsoft.SecHealthUI*' | cat - remove.sh > temp && mv temp remove.sh
#echo 'rm -rf Program Files/WindowsApps/Microsoft.Services.Store.Engagement_10.0.19011.0_x64__8wekyb3d8bbwe' | cat - remove.sh > temp && mv temp remove.sh
#echo 'rm -rf Program Files/WindowsApps/Microsoft.Services.Store.Engagement_10.0.19011.0_x86__8wekyb3d8bbwe' | cat - remove.sh > temp && mv temp remove.sh
echo 'rm -rf Program\ Files/WindowsApps/Microsoft.StorePurchaseApp*' | cat - remove.sh > temp && mv temp remove.sh
echo 'rm -rf Program\ Files/WindowsApps/Microsoft.Todos*' | cat - remove.sh > temp && mv temp remove.sh
echo 'rm -rf Program\ Files/WindowsApps/Deleted' | cat - remove.sh > temp && mv temp remove.sh
echo 'rm -rf Program\ Files/WindowsApps/DeletedAllUserPackages' | cat - remove.sh > temp && mv temp remove.sh
echo 'rm -rf Program\ Files/WindowsApps/Merged' | cat - remove.sh > temp && mv temp remove.sh
echo 'rm -rf Program\ Files/WindowsApps/MovedPackages' | cat - remove.sh > temp && mv temp remove.sh
echo 'rm -rf Program\ Files/WindowsApps/Mutable' | cat - remove.sh > temp && mv temp remove.sh
echo 'rm -rf Program\ Files/WindowsApps/MutableBackup' | cat - remove.sh > temp && mv temp remove.sh
echo 'rm -rf Program\ Files/WindowsApps/Projected' | cat - remove.sh > temp && mv temp remove.sh
echo '#!/bin/bash' | cat - remove.sh > temp && mv temp remove.sh

#Blacklisting MS IP's
echo "0.0.0.0       telemetry.microsoft.com" >> "Windows/System32/drivers/etc/hosts"
echo "0.0.0.0       vortex.data.microsoft.com" >> "Windows/System32/drivers/etc/hosts"
echo "0.0.0.0       vortex-win.data.microsoft.com" >> "Windows/System32/drivers/etc/hosts"
echo "0.0.0.0       telecommand.telemetry.microsoft.com" >> "Windows/System32/drivers/etc/hosts"
echo "0.0.0.0       telecommand.telemetry.microsoft.com.nsatc.net" >> "Windows/System32/drivers/etc/hosts"
echo "0.0.0.0       oca.telemetry.microsoft.com" >> "Windows/System32/drivers/etc/hosts"
echo "0.0.0.0       oca.telemetry.microsoft.com.nsatc.net" >> "Windows/System32/drivers/etc/hosts"
echo "0.0.0.0       sqm.telemetry.microsoft.com" >> "Windows/System32/drivers/etc/hosts"
echo "0.0.0.0       sqm.telemetry.microsoft.com.nsatc.net" >> "Windows/System32/drivers/etc/hosts"
echo "0.0.0.0       watson.telemetry.microsoft.com" >> "Windows/System32/drivers/etc/hosts"
echo "0.0.0.0       watson.telemetry.microsoft.com.nsatc.net" >> "Windows/System32/drivers/etc/hosts"
echo "0.0.0.0       redir.metaservices.microsoft.com" >> "Windows/System32/drivers/etc/hosts"
echo "0.0.0.0       choice.microsoft.com" >> "Windows/System32/drivers/etc/hosts"
echo "0.0.0.0       choice.microsoft.com.nsatc.net" >> "Windows/System32/drivers/etc/hosts"
echo "0.0.0.0       df.telemetry.microsoft.com" >> "Windows/System32/drivers/etc/hosts"
echo "0.0.0.0       wes.df.telemetry.microsoft.com" >> "Windows/System32/drivers/etc/hosts"
echo "0.0.0.0       reports.wes.df.telemetry.microsoft.com" >> "Windows/System32/drivers/etc/hosts"
echo "0.0.0.0       services.wes.df.telemetry.microsoft.com" >> "Windows/System32/drivers/etc/hosts"
echo "0.0.0.0       sqm.df.telemetry.microsoft.com" >> "Windows/System32/drivers/etc/hosts"
echo "0.0.0.0       watson.ppe.telemetry.microsoft.com" >> "Windows/System32/drivers/etc/hosts"
echo "0.0.0.0       telemetry.appex.bing.net" >> "Windows/System32/drivers/etc/hosts"
echo "0.0.0.0       telemetry.urs.microsoft.com" >> "Windows/System32/drivers/etc/hosts"
echo "0.0.0.0       telemetry.appex.bing.net:443" >> "Windows/System32/drivers/etc/hosts"
echo "0.0.0.0       settings-sandbox.data.microsoft.com" >> "Windows/System32/drivers/etc/hosts"
echo "0.0.0.0       vortex-sandbox.data.microsoft.com" >> "Windows/System32/drivers/etc/hosts"
echo "0.0.0.0       watson.microsoft.com" >> "Windows/System32/drivers/etc/hosts"
echo "0.0.0.0       survey.watson.microsoft.com" >> "Windows/System32/drivers/etc/hosts"
echo "0.0.0.0       watson.live.com" >> "Windows/System32/drivers/etc/hosts"
echo "0.0.0.0       statsfe2.ws.microsoft.com" >> "Windows/System32/drivers/etc/hosts"
echo "0.0.0.0       corpext.msitadfs.glbdns2.microsoft.com" >> "Windows/System32/drivers/etc/hosts"
echo "0.0.0.0       compatexchange.cloudapp.net" >> "Windows/System32/drivers/etc/hosts"
echo "0.0.0.0       cs1.wpc.v0cdn.net" >> "Windows/System32/drivers/etc/hosts"
echo "0.0.0.0       a-0001.a-msedge.net" >> "Windows/System32/drivers/etc/hosts"
echo "0.0.0.0       fe2.update.microsoft.com.akadns.net" >> "Windows/System32/drivers/etc/hosts"
echo "0.0.0.0       statsfe2.update.microsoft.com.akadns.net" >> "Windows/System32/drivers/etc/hosts"
echo "0.0.0.0       sls.update.microsoft.com.akadns.net" >> "Windows/System32/drivers/etc/hosts"
echo "0.0.0.0       diagnostics.support.microsoft.com" >> "Windows/System32/drivers/etc/hosts"
echo "0.0.0.0       corp.sts.microsoft.com" >> "Windows/System32/drivers/etc/hosts"
echo "0.0.0.0       statsfe1.ws.microsoft.com" >> "Windows/System32/drivers/etc/hosts"
echo "0.0.0.0       pre.footprintpredict.com" >> "Windows/System32/drivers/etc/hosts"
echo "0.0.0.0       i1.services.social.microsoft.com" >> "Windows/System32/drivers/etc/hosts"
echo "0.0.0.0       i1.services.social.microsoft.com.nsatc.net" >> "Windows/System32/drivers/etc/hosts"
echo "0.0.0.0       feedback.windows.com" >> "Windows/System32/drivers/etc/hosts"
echo "0.0.0.0       feedback.microsoft-hohm.com" >> "Windows/System32/drivers/etc/hosts"
echo "0.0.0.0       feedback.search.microsoft.com" >> "Windows/System32/drivers/etc/hosts"
echo "0.0.0.0       cdn.content.prod.cms.msn.com" >> "Windows/System32/drivers/etc/hosts"
echo "0.0.0.0       cdn.content.prod.cms.msn.com.edgekey.net" >> "Windows/System32/drivers/etc/hosts"
echo "0.0.0.0       e10663.g.akamaiedge.net" >> "Windows/System32/drivers/etc/hosts"
echo "0.0.0.0       dmd.metaservices.microsoft.com" >> "Windows/System32/drivers/etc/hosts"
echo "0.0.0.0       schemas.microsoft.com" >> "Windows/System32/drivers/etc/hosts"
echo "0.0.0.0       go.microsoft.com" >> "Windows/System32/drivers/etc/hosts"
echo "0.0.0.0       40.76.0.0/14" >> "Windows/System32/drivers/etc/hosts"
echo "0.0.0.0       40.96.0.0/12" >> "Windows/System32/drivers/etc/hosts"
echo "0.0.0.0       40.124.0.0/16" >> "Windows/System32/drivers/etc/hosts"
echo "0.0.0.0       40.112.0.0/13" >> "Windows/System32/drivers/etc/hosts"
echo "0.0.0.0       40.125.0.0/17" >> "Windows/System32/drivers/etc/hosts"
echo "0.0.0.0       40.74.0.0/15" >> "Windows/System32/drivers/etc/hosts"
echo "0.0.0.0       40.80.0.0/12" >> "Windows/System32/drivers/etc/hosts"
echo "0.0.0.0       40.120.0.0/14" >> "Windows/System32/drivers/etc/hosts"
echo "0.0.0.0       137.116.0.0/16" >> "Windows/System32/drivers/etc/hosts"
echo "0.0.0.0       23.192.0.0/11" >> "Windows/System32/drivers/etc/hosts"
echo "0.0.0.0       23.32.0.0/11" >> "Windows/System32/drivers/etc/hosts"
echo "0.0.0.0       23.64.0.0/14" >> "Windows/System32/drivers/etc/hosts"
echo "0.0.0.0       23.55.130.182" >> "Windows/System32/drivers/etc/hosts"
#New
echo "0.0.0.0       20.110.81.91" >> "Windows/System32/drivers/etc/hosts"
echo "0.0.0.0       168.62.240.75" >> "Windows/System32/drivers/etc/hosts"
echo "0.0.0.0       13.107.42.14" >> "Windows/System32/drivers/etc/hosts"
echo "0.0.0.0       13.107.21.239" >> "Windows/System32/drivers/etc/hosts"
echo "0.0.0.0       13.107.6.156" >> "Windows/System32/drivers/etc/hosts"
echo "0.0.0.0       52.96.226.130" >> "Windows/System32/drivers/etc/hosts"
echo "0.0.0.0       13.107.21.200" >> "Windows/System32/drivers/etc/hosts"
echo "0.0.0.0       204.79.197.219" >> "Windows/System32/drivers/etc/hosts"
echo "0.0.0.0       13.107.227.51" >> "Windows/System32/drivers/etc/hosts"
echo "0.0.0.0       52.189.67.17" >> "Windows/System32/drivers/etc/hosts"
echo "0.0.0.0       40.126.29.10" >> "Windows/System32/drivers/etc/hosts"
echo "0.0.0.0       20.42.65.88" >> "Windows/System32/drivers/etc/hosts"
echo "0.0.0.0       13.107.213.51" >> "Windows/System32/drivers/etc/hosts"
echo "0.0.0.0       13.107.246.51" >> "Windows/System32/drivers/etc/hosts"
echo "0.0.0.0       40.126.29.14" >> "Windows/System32/drivers/etc/hosts"
echo "0.0.0.0       104.43.200.36" >> "Windows/System32/drivers/etc/hosts"
echo "0.0.0.0       23.96.225.71" >> "Windows/System32/drivers/etc/hosts"
echo "0.0.0.0       20.52.64.200" >> "Windows/System32/drivers/etc/hosts"
echo "0.0.0.0       20.49.97.26" >> "Windows/System32/drivers/etc/hosts"
echo "0.0.0.0       20.189.173.15" >> "Windows/System32/drivers/etc/hosts"
echo "0.0.0.0       52.167.85.21" >> "Windows/System32/drivers/etc/hosts"
echo "0.0.0.0       40.83.240.146" >> "Windows/System32/drivers/etc/hosts"
echo "0.0.0.0       13.64.180.106" >> "Windows/System32/drivers/etc/hosts"
echo "0.0.0.0       52.137.108.250" >> "Windows/System32/drivers/etc/hosts"

chmod +x remove.sh

# runs the scripts
title_bar
FILE=./AME_Backup/
if [ -d $FILE ]; then
	now=$(date +"%Y.%m.%d.%H.%M")
	7z a AME_Backup_$now.zip AME_Backup/
	rm -rf AME_Backup/
else
   echo "$FILE' not found, continuing"
fi
echo "Creating Directories"
./mkdirs.sh
echo "Done."
echo "Backing up files"
./backup.sh
echo "Done."
echo "Removing files"
./remove.sh
echo "Done."
sync
title_bar
echo "You may now reboot into Windows"

#Creating Entry In Restore Remove.sh to restore clipsvc.dll and restoring clipsvc.dll
echo 'cp -fa --preserve=all "AME_Backup/Windows/System32/ClipSVC.dll" "Windows/System32/ClipSVC.dll"' >> remove.sh
cp -fa --preserve=all "AME_Backup/Windows/System32/ClipSVC.dll" "Windows/System32/ClipSVC.dll"

#echo "This will restore clipsvc.dll for Windows store apps to work if didn't install Dolby or store apps CANCEL"
#read -p "To continue press [ENTER], or Ctrl-C to CANCEL"
#cp -fa --preserve=all "AME_Backup/Windows/System32/ClipSVC.dll" "Windows/System32/ClipSVC.dll"
