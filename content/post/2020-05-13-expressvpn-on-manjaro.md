---
title: "Installing ExpressVPN client on Manjaro Linux"
subtitle: ""
summary: "How to install expressvpn client on a fresh install of Manjaro / Arch"
authors: []
tags: [howto, expressvpn, manjaro, arch-linux]
categories: []
date: 2020-05-12T12:30:18-08:00
lastmod: 2020-05-12T12:30:18-08:00
featured: false
draft: false

# Featured image
# To use, add an image named `featured.jpg/png` to your page's folder.
# Focal points: Smart, Center, TopLeft, Top, TopRight, Left, Right, BottomLeft, Bottom, BottomRight.
image:
  caption: ""
  focal_point: ""
  preview_only: false

# Projects (optional).
#   Associate this post with one or more of your projects.
#   Simply enter your project's folder or file name without extension.
#   E.g. `projects = ["internal-project"]` references `content/project/deep-learning/index.md`.
#   Otherwise, set `projects = []`.
projects: []
---

## Solution origin - awesome Manjaro forums
https://forum.manjaro.org/t/installing-expressvpn-on-manjaro-how-to/125345/9

## Solution

### Remove old install (optional)
Stop and remove old install of expressvpn, if present:
```bash
expressvpn disconnect
sudo systemctl stop expressvpn
sudo systemctl disable expressvpn
sudo pacman -Rns expressvpn

``` 

### Install new package from ExpressVPN website
ExpressVPN website provides a package for Arch now. Manjaro is based on Arch, so that's what we need.  
Download 64 bit `.pkg.tar.xz` Arch package: https://www.expressvpn.com/setup#linux

if you have a fresh install of manjaro:

- go to expressvpn and download the Arch 64 bit version and copy the activation code
- install it via pacman
    - `sudo pacman -U /path/to/expressvpn.package.tar.xz`

- copy the service scripts to the correct location
    - `sudo cp /usr/lib/expressvpn/expressvpn*.service /etc/systemd/system/.`

- enable and start the service
    - `sudo systemctl enable expressvpn`
    - `sudo systemctl start expressvpn`

- activate it with the activation code you copied earlier
    - `expressvpn activate`

- connect vpn
    - `expressvpn connect smart`


When you connect, expressvpn gives you some valuable infor you might miss:

- To check your connection status, type `expressvpn status`.
- If your VPN connection unexpectedly drops, internet traffic will be blocked to protect your privacy.
- To disable Network Lock, disconnect ExpressVPN then type 'expressvpn preferences set network_lock off'.
