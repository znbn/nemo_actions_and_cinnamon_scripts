#!/bin/bash
# Script to set a per workspace desktop background in Cinnamon.
# Save as ~/bin/workspace_backgrounds_switcher.sh or ~/.local/bin/workspace_backgrounds_switcher.sh and make executable
# Add an entry in startup applications to launch the script on start-up.
# this is a fork from https://github.com/smurphos/nemo_actions_and_cinnamon_scripts
# adapted by Giacomo Zanobini

# the images are found in /home/jack/Backgrounds/ folder
# the script is more verbose, so you can debug it if something is wrong and you run it from shell

# Set your images here - one per active workspace.
# Add extra WORKSPACE_BACKGROUND[X] entries as necessary.
WORKSPACE_BACKGROUND[0]="/home/jack/Backgrounds/0.png"
WORKSPACE_BACKGROUND[1]="/home/jack/Backgrounds/1.png"
WORKSPACE_BACKGROUND[2]="/home/jack/Backgrounds/2.jpg"
WORKSPACE_BACKGROUND[3]="/home/jack/Backgrounds/3.jpg"

# Check for existing instance and exit if already running
echo "Script: ${0##*/}"
if pidof -o %PPID -x "${0##*/}"; then
  echo "The script is already running."
  echo "Kill it, before restarting."
  exit 1
fi

# Monitor for workspace changes and set the background on change.
xprop -root -spy _NET_CURRENT_DESKTOP | while read -r;
  do
    echo "changed background for workspace ${REPLY: -1} to file://${WORKSPACE_BACKGROUND[${REPLY: -1}]} "
    gsettings set org.cinnamon.desktop.background picture-uri "file://${WORKSPACE_BACKGROUND[${REPLY: -1}]}"
  done

echo "Script terminated by user"
