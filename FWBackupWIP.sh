
#!/system/bin/sh
# Online Odin FirmWare maker
#by iamareebjamal
#XDA Developers 2013


#If you are seeing this, it means that 
# you want to know about what is happening
#here


# This script is originally built by me by using the code given by Rafael.Baugis
# and my Knowledge of the scripting of Linux with help about loop by GermainZ 

# Credit of source code goes to Rafael.Baugis whose
# guide and OdinFW.zip made a lot clear about script

#  However, this script is totally built from ground 

# If you want to know which command backs up
# the firmware package files, then check out the commands

# However, you are not allowed to share
# this work without my permission 

# However, it is open sourced and you can learn 
# and try and use any command you like 
# but copying and editing some things and 
# sharing is not appreciated 

# Enough talks :) 


echo "Odin FirmWare BackUP script"
sleep 2
 echo ""
 echo ""
 echo "by IamAreebJamal"
 echo ""
 echo "" 
 sleep 2 
 echo "based on the source given" 
 echo "by Rafael.Baugis" 
 echo "(In CWM_FWOdin.zip)" 
 echo ""
 sleep 2 
 echo "" 
 echo "Script backs up" 
 echo "your ROM" 
 echo ""
 echo ""
 sleep 1 
 echo "And creates Odin flashable" 
 echo "Packages of it" 
 sleep 2 
 echo "So, you can" 
 echo "flash custom ROM through" 
 echo "Odin" 
 echo ""
 sleep 2 
 echo ""
 echo "Remember : Script is not tested for the" 
 echo "ROMs with sd-ext partition" 
 echo ""
 sleep 1 
 echo "So, it is advised to first flash" 
 echo "Custom ROM and then without modding, " 
 echo "Take the backup" 
 echo ""
 echo "" 
 sleep 3 
 echo "Note: Only restore backup through Odin v1.85 or Odin v1.87" 
 echo ""
 sleep 1 
 echo "Not the Odin v3.07" 
 sleep 3 
 echo "Let's start :) " 
id=`id`; 
id=`echo ${id#*=}`; 
id=`echo ${id%%\(*}`; 
id=`echo ${id%% *}`
if [ "$id" != "0" ] && [ "$id" != "root" ]; then
echo "Script NOT running as root!"
sleep 2
echo "Maybe your phone isn't rooted or SuperUser access not granted!"
sleep 2
echo "Please type 'su' first before running this script..."
exit
else
echo "Script Ready to continue..."
echo ""
sleep 2
fi 
if [ ! "'which busybox'" ]
then
echo "Sorry, no busybox found"
echo "" 
sleep 2
echo "First, install it and then proceed"
exit 
fi
 bbb=0

if [ ! "`which awk`" ]
then bbb=1
echo "awk applet NOT FOUND!"
sleep 2
else 
echo "Awesome! awk found! :D"
sleep 2
fi

if [ ! "`which run-parts`" ]
then bbb=1
echo "run-parts applet NOT FOUND!"
sleep 2
else
echo "Good! run-parts found! :)"
echo ""
sleep 2
fi

if [ $bbb -eq 1 ] 
then
echo ""
echo "Required applets are NOT FOUND!"
echo ""
sleep 2
echo "Please reinstall busybox!"
exit
fi 
echo "Press enter to continue..."
read enterKey 
 echo "" 
 echo ""
 echo "Creating BOOT.tar" 
 echo ""
 sleep 2 
 echo "The following text is about"
 echo "the size and different time" 
 echo "taken by partitions " 
 echo "to get Backed Up"
 sleep 2 
busybox dd if=/dev/bml1 of=/sdcard/BcmBoot.img


busybox dd if=/dev/bml14 of=/sdcard/HEDGE_NVRAM8_RF_LE.bin


busybox dd if=/dev/bml13 of=/sdcard/sysparm_dep.img 


busybox tar -c -f /sdcard/BOOT.tar -C /sdcard BcmBoot.img HEDGE_NVRAM8_RF_LE.bin sysparm_dep.img


busybox rm /sdcard/BcmBoot.img /sdcard/HEDGE_NVRAM8_RF_LE.bin /sdcard/sysparm_dep.img
 echo ""
 echo "" 
 echo "BOOT.tar created" 
 echo ""
 sleep 2 
 echo ""
 echo ""
 echo "Creating PHONE.tar" 
 echo "" 
busybox dd if=/dev/bml5 of=/sdcard/BcmCP.img


busybox tar -c -f /sdcard/PHONE.tar -C /sdcard BcmCP.img 


busybox rm /sdcard/BcmCP.img
 echo ""
 echo "" 
 echo "PHONE.tar created" 
 echo ""
 echo ""
 echo ""
 sleep 2 
 echo ""
 echo "Creating PDA.tar" 
 sleep 2 
 echo "It will take a lot of time" 
 echo "Approximately 15 minutes " 
 echo "So don't panic and wait :) " 
 echo "" 
busybox dd if=/dev/bml2 of=/sdcard/sbl.bin


busybox dd if=/dev/stl6 of=/sdcard/param.lfs


busybox dd if=/dev/bml7 of=/sdcard/boot.img


busybox dd if=/dev/stl9 of=/sdcard/system.img


busybox tar -c -f /sdcard/PDA.tar -C /sdcard system.img boot.img param.lfs sbl.bin userdata.img


busybox rm /sdcard/system.img /sdcard/boot.img /sdcard/param.lfs /sdcard/sbl.bin /sdcard/userdata.img
 echo ""
 echo "PDA.tar created " 
 echo ""
 echo ""
 sleep 2 
 echo "" 
 echo "Creating CSC_clean.tar" 


busybox tar -c -f /sdcard/CSC_clean.tar -C /sdcard csc.rfs


busybox rm /sdcard/csc.rfs
 echo ""
 echo ""
 echo "CSC_clean.tar created" 
 echo ""
 sleep 2 
 echo ""
 echo "Creating CSC.tar " 
 echo "" 

busybox dd if=/dev/stl10 of=/sdcard/csc.rfs


busybox tar -c -f /sdcard/CSC.tar -C /sdcard csc.rfs


busybox rm /sdcard/csc.rfs

 echo ""
 echo "CSC.tar created"
 echo ""
 echo ""
 sleep 2 
 echo "" 
busybox dd if=/dev/bml15 of=/sdcard/bml15_EFS.img
 echo "All packages created" 
 echo ""
 sleep 1 
 echo "Congratulations :) " 
 echo "Now, moving the packages" 
 echo "to /sdcard/FirmWare" 
 echo ""
 echo "" 
 sleep 2 

if [ -e /sdcard/FirmWare ]

then
busybox mv /sdcard/PHONE.tar /sdcard/BOOT.tar /sdcard/PDA.tar /sdcard/CSC.tar /sdcard/CSC_clean.tar /sdcard/bml15_EFS.img /sdcard/FirmWare

else
busybox mkdir /sdcard/FirmWare

busybox mv /sdcard/PHONE.tar /sdcard/BOOT.tar /sdcard/PDA.tar /sdcard/CSC.tar /sdcard/CSC_clean.tar /sdcard/bml15_EFS.img /sdcard/FirmWare
fi
 echo ""
 echo "Everything moved"
 echo "" 
 echo "Process Completed"
 echo "" 
 sleep 1 
 echo "By IamAreebJamal" 
 echo ""
 echo ""
 sleep 2 
 echo "" 
echo "Bye" 
exit