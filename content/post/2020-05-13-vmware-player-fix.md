---
title: "Fixing VMWare Workstation 'Device/Credential Guard are not compatible' / 64-bit Guest OS can't run on 32-bit host"
subtitle: ""
summary: ""
authors: []
tags: [fixme, howto, vmware, windows]
categories: []
date: 2020-05-26T12:00:18-08:00
lastmod: 2020-05-26T12:00:18-08:00
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

## Symptoms
 - VMWare Wrokstation Player shows a warning when you try to create a new 64-bit VM on a 64-bit host (Win10 Pro host in my case)
 - VMWare Wrokstation Player just starts the vm, shows black screen and then an error message pops up, saying: 
 `VMWare Workstation and Device/Credential Guard are not compatible.`

## TL;DR;
- Disable `Hyper-V` and `Windows Sandbox` in *Windows Features*
- Enable processor virtualization in BIOS
 - From elevated CMD (run as administrator):
    ```
    bcdedit /set hypervisorlaunchtype off
    shutdown /r /t 0
    ```

## Some details of what might be wrong
- Make sure vitualization is turned on for the processor in BIOS (this step varies by BIOS manufacturer)
- In Windows' features check that `Hyper-V` and `Windows Sandbox` are not enabled.

## My experience
I had `Windows Sandbox` enabled in the first place. This was causing VMWare Workstation 15.5.2 to show the warning about 64-bit guest
on 32-bit host. Even though the host was 64-bit in fact. I then uninstalled `Windows Sandbox` via `Add/Remove Windows Features` menu.
Then I started getting the more common *Device/Credential Guard are not compatible* error message.  
Running from elevated CMD:
```
    bcdedit /set hypervisorlaunchtype off
    shutdown /r /t 0
```
Did the final trick.