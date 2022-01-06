#!/bin/bash

folder="${HOME}/Pictures/desktop-wallpapers"
pic=$(ls $folder/* | shuf -n1)

gsettings set org.gnome.desktop.background picture-options 'zoom'
gsettings set org.gnome.desktop.background picture-uri "file://$pic"
