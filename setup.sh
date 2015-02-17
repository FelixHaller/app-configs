#!/bin/bash

# This script will install some needed packages and create symlinks for my
# config files.

HOMEFILES_DIR=home
HOMEFILES=`ls -1A ./$HOMEFILES_DIR/`


if [ `which pacman | wc -l` == 1 ]
then
 sudo pacman -Syy
 sudo pacman -S --needed git bash-completion 2>/dev/zero

elif [ `which apt-get | wc -l` == 1 ]
then
 sudo apt-get update 2>/dev/zero
 sudo apt-get install git bash-completion
fi

# create symlinks for config files
for FNAME in ${HOMEFILES[@]}
do
 ln -s `pwd`/$HOMEFILES_DIR/$FNAME ~/$FNAME
done

