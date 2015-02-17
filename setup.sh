#!/bin/bash

# This script will install some needed packages and create symlinks for my
# config files.

HOMEFILES_DIR=home
NANOCONFDIR=".nano"

if [ `which pacman | wc -l` == 1 ]
then
 sudo pacman -Syy
 sudo pacman -S --needed git bash-completion curl nano 2>/dev/zero
 curl -O https://aur.archlinux.org/packages/pa/package-query/package-query.tar.gz
 tar -xvzf package-query.tar.gz
 cd package-query
 makepkg -si
 cd ..
 curl -O https://aur.archlinux.org/packages/ya/yaourt/yaourt.tar.gz
 tar -xvzf yaourt.tar.gz
 cd yaourt
 makepkg -si
 cd ..
 #remove temp folders
 rm -r yaourt package-query yaourt.tar.gz package-query.tar.gz
 yaourt -S byobu

elif [ `which apt-get | wc -l` == 1 ]
then
 sudo apt-get update &> /dev/zero
 sudo apt-get install git bash-completion byobu nano
fi

rm -rf ~/.nano/
git clone git://github.com/serialhex/nano-highlight.git ~/.nano

cp -r $HOMEFILES_DIR/. ~/
byobu-enable

NANORCS=`ls -1 ~/$NANOCONFDIR/*.nanorc`

for FNAME in ${NANORCS[@]}
do
  echo "include $FNAME" >> ~/.nanorc
done
