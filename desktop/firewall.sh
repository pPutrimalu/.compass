#!/usr/bin/env bash

clear

sudo dnf install -y iptables \
	nftables \
	firewalld \
	firewall-config \
	firewall-applet

sudo systemctl enable firewalld
sudo firewall-cmd --permanent --zone=home --add-service=kdeconnect
sudo firewall-cmd --reload
