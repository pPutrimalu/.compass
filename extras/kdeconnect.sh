#!/usr/bin/env bash

clear

sudo pacman -S --noconfirm kdeconnect

if firewall-cmd --version &>/dev/null; then
	sudo firewall-cmd --new-zone=sharing
	sudo firewall-cmd --zone=sharing --add-service=kdeconnect
	sudo firewall-cmd --reload
	sudo firewall-cmd --runtime-to-permanent
fi
