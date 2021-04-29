---
# Documentation: https://sourcethemes.com/academic/docs/managing-content/

title: "Auto Resize Guest VM Desktop running under VMWare"
subtitle: ""
summary: "In VMWare Workstation guest OS desktop doesn't auto-resize to fill host OS window after first reboot. Solution."
authors: []
tags: [howto, vmware, manjaro, open-vm-tools, vmtoolsd]
categories: [howto]
date: 2020-05-14T00:23:27-07:00
lastmod: 2020-05-14T00:23:27-07:00
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

## Symptopms
- After first reboot of VM destop of guest OS stopped auto-resizing to fill host window.
- But it was working fine during guest OS install, or while it was running from live cd. 

## TL;DR;
Restart `vmtoolsd` service.

**On Manjaro / Arch**:  
`sudo systemctl restart vmtoolsd`  
Has to be done after every boot-up. And sometimes after session locks out as well.

Some suggest that delaying the start of the service helps:  
`sudo vim /etc/systemd/system/multi-user.target.wants/vmtoolsd.service`  
and add the folowing in [Unit] section:  
```
[Unit]
After=graphical.target
```
Didn't help me.

## A bit more context
VMWare Workstation requires you to have `open-vm-tools` package service installed, which actually does the resizing.
I was running Manjaro 20 under VMWare Workstation 15 on Win10 Pro. Open VM Tools was already pre-installed with
Manjaro distribution.  
However it seems like the service named `vmtoolsd` starts too early. On the internet everyone mentions `open-vm-tools`, 
but it probably changed name to `vmtoolsd`.

## Possible solutions
https://github.com/vmware/open-vm-tools/issues/253
https://github.com/vmware/open-vm-tools/issues/303
