#!/bin/bash
clear
if [ "$(whoami)" != "root" ]; then
	echo "Please run this script as sudo."
	exit 1
fi

sudo apt-get install whiptail
sudo apt-get install git
sudo apt-get install xz-utils



if (whiptail --title "Upgrade & Update" --yesno "Do you want to update your system?" 10 60) then
    sudo apt-get update && apt-get upgrade
else
	if [ $2 == "--no-update" ]; then
		echo "ok mr expert. but its your fault it something breaks."
	else
		echo "Sorry, we cant support you then."
		exit 1
	fi
	
fi


installlocation=$(whiptail --title "Question" --inputbox "Choose a location for everything to install." 10 60 /home/fx/ 3>&1 1>&2 2>&3)
exitstatus=$?
if [ $exitstatus = 0 ]; then
    if [ -d $installlocation ]; then
    	echo "That directory exist already. Please choose a non existent."
    	exit 1;
    fi
else
    echo "Aborting."
    exit 1
fi



## install process

    mkdir -p $installlocation/fxdata
	cd $installlocation/fxdata
	wget https://runtime.fivem.net/artifacts/fivem/build_proot_linux/master/290-04e034829f75169f11ee33abf67281ecd74728e3/fx.tar.xz # at point of making the newest.
	tar xf fx.tar.xz
	rm fx.tar.xz
	cd ..
	mkdir servers
	mkdir managerfiles
	# download manager.sh
	# download ./managerfiles/default-config.cfg
	# download ./used-ports.txt
	chmod -R 777 $installlocation
	
echo "Installation process is over, please run 'sudo $installlocation/manager.sh' now. Dont forget to update the fxdata."
