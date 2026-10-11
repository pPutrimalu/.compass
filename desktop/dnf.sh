#!/usr/bin/env bash

clear

[[ -f /etc/dnf/dnf-conf.bak ]] || sudo cp /etc/dnf/dnf.conf /etc/dnf/dnf-conf.bak

sudo tee /etc/dnf/dnf.conf <<-EOF
	# see man dnf.conf for defaults and possible options

	[main]
	fastestmirror=True
	max_parallel_downloads=$(nproc)
	keepcache=True
EOF

sudo dnf update -y
sudo dnf install -y https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm
