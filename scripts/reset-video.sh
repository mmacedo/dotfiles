sudo apt-get purge -y fglrx*
sudo rm /etc/X11/xorg.conf
sudo apt-get install --reinstall -y xserver-xorg-core libgl1-mesa-glx:i386 libgl1-mesa-dri:i386 libgl1-mesa-glx:amd64 libgl1-mesa-dri:amd64
sudo dpkg-reconfigure xserver-xorg
sudo reboot