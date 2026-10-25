#!/usr/bin/env bash

clear

sudo pacman -S --noconfirm kdeconnect

if firewall-cmd --version &>/dev/null; then
	sudo firewall-cmd --permanent --new-zone=home
	sudo firewall-cmd --zone=home --add-service=kdeconnect
	sudo firewall-cmd --runtime-to-permanent
	sudo firewall-cmd --reload
fi
