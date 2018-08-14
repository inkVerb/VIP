#!/bin/sh

# This is a set of semi-complex commands that might prove useful

# See if an application is already installed
## This will see if Pluma the text editor for MATE is installed.
if [ -x "$(command -v pluma)" ]; then
echo "Pluma!"
else
echo "No Pluma."
fi

# Make a directory and all subdirectories one thru six and don't echo errors if they already exist
mkdir -p one/two/three/four/five/six

# Remove broken symlinks
cd /path/to/dir
for x in * .[!.]* ..?*; do if [ -L "$x" ] && ! [ -e "$x" ]; then rm -- "$x"; fi; done

# Do something for each file in a directory
cd /path/to/dir
for wut in * 
do
 if [ -f "$wut" ]; the
  echo "I found $wut"
 fi
done

# Remove periods from a string
STRING=this.is.my.string
DOTLESS_STRING=$(echo $STRING | sed -e 's/\.//g')
echo "$DOTLESS_STRING"

# Generate a random character string for a varible
## THIS REQUIRES: #!/bin/sh
## THIS WILL FAIL: #!/bin/bash

## Random AZaz09, 20 characters long, 1 set
RANDOMCHAR=$(pwgen 20)
echo "$RANDOMCHAR"

## Very random AZaz09, 24 characters long, 1 set
RANDOMCHAR=$(pwgen -s 24)
echo "$RANDOMCHAR"

## Very random AZaz, 30 characters long, 2 sets
RANDOMCHAR=$(pwgen -s -1 30 2)
echo "$RANDOMCHAR"

# Check if one number is greater than another using "bc"
## This requires bc installed: apt install bc
if [ $(echo "${GREATER_NUMBER}>${LESSER_NUMBER}"|bc) = 1 ]; then
echo "Yep, it's greater."
fi

# Check if a repo has already been added
## This example repo is: deb http://archive.ubuntu.com/ubuntu $(lsb_release -sc) universe
## Note in setting the variable $vrk_add_repo_universe, we put $(lsb_release -sc) outside the quotes
if [ ! -f "/var/local/vrk/.vubuntu-studiolite-repo-universe" ]; then
vrk_add_repo_universe="eb http://archive.ubuntu.com/ubuntu "$(lsb_release -sc)" universe"
 if ! grep -q "^deb .*$vrk_add_repo_universe" /etc/apt/sources.list /etc/apt/sources.list.d/*; then
add-apt-repository "deb http://archive.ubuntu.com/ubuntu $(lsb_release -sc) universe"
touch /var/local/vrk/.vubuntu-studiolite-repo-universe
 fi
fi
