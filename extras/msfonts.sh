#!/usr/bin/env bash

set -euo pipefail

sudo dnf install -y curl cabextract xorg-x11-font-utils mkfontscale fontconfig cpio unzip

curl -fLO --output-dir /tmp https://downloads.sourceforge.net/project/mscorefonts2/rpms/msttcore-fonts-installer-2.6-1.noarch.rpm

rpmfile="/tmp/msttcore-fonts-installer-2.6-1.noarch.rpm"
workdir=$(mktemp -d)
trap 'rm -rf "$workdir"' EXIT

fontdir="/usr/local/share/fonts/microsoft-core"
extractdir="$workdir/microsoft-core"

cd "$workdir"
rpm2cpio "$rpmfile" | cpio -id --quiet
mkdir -p "$extractdir"
./usr/lib/msttcore-fonts-installer/refresh-msttcore-fonts.sh -F "$extractdir"
for required_font in arial.ttf calibri.ttf; do
	if [ ! -s "$extractdir/$required_font" ]; then
		printf 'Missing expected font: %s\n' "$required_font"
		exit 1
	fi
done
sudo install -d -m 0755 "$fontdir"
sudo find "$fontdir" -mindepth 1 -maxdepth 1 -exec rm -rf {} +
sudo cp -a "$extractdir"/. "$fontdir"/
sudo chown -R root:root "$fontdir"
sudo find "$fontdir" -type d -exec chmod 0755 {} +
sudo find "$fontdir" -type f -exec chmod 0644 {} +
sudo fc-cache -f "$fontdir"
