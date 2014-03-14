#!/bin/bash
############################
# .make.sh
# This script creates symlinks from ~ and ~/.config to any desired dotfiles in ~/dotfiles
############################

########## Variables

dir=~/dotfiles                    # dotfiles directory
olddir=~/backup/dotfiles_old      # old dotfiles backup directory

# list of files/folders to symlink in ~
homeFiles="bash_aliases bashrc compton.conf conkyrc gitconfig muttrc vim vimrc"    

# list of files/folders to symlink in ~/.config/
confFiles="openbox terminator tint2rc"

####################


# create dotfiles_old in ~
echo -n "Creating $olddir for backup of any existing dotfiles in ~ ..."
mkdir -p $olddir
echo "done"

# change to the dotfiles directory
echo -n "Changing to the $dir directory ..."
cd $dir
echo "done"

# 1. move any existing dotfiles in ~ to dotfiles_old directory, 
# 2. create symlinks from ~ to any file specified in $homeFiles
for file in $homeFiles; do
    echo "Moving any existing dotfiles from ~ to $olddir"
    mv ~/.$file ~/dotfiles_old/
    echo "Creating symlink to $file in home directory."
    ln -s $dir/$file ~/.$file
done

# 1. move any existing dotfiles in ~/.config to dotfiles_old directory, 
# 2. create symlinks from ~/.config to any file specified in $confFiles
for file in $confFiles; do
    echo "Moving any existing dotfiles from ~/.config to $olddir"
    mv ~/.config/$file ~/dotfiles_old/
    echo "Creating symlink to $file in ~/.config."
    ln -s $dir/$file ~/.config/$file
done
