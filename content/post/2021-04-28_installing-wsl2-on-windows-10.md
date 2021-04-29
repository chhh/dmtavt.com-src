---
# Documentation: https://sourcethemes.com/academic/docs/managing-content/

title: "Installing WSL2 on Windows 10"
subtitle: "You will get performant access to the filesystem with WSL2!"
summary: "The easy way. Get the full featured Linux running under Windows."
authors: [chhh]
tags: [windows, linux, wsl, wsl2]
categories: []
date: 2021-04-28T23:48:48-07:00
lastmod: 2021-04-28T23:48:48-07:00
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

- From elevated PowerShell (Run as Administrator):
```powershell
dism.exe /online /enable-feature /featurename:Microsoft-Windows-Subsystem-Linux /all /norestart
dism.exe /online /enable-feature /featurename:VirtualMachinePlatform /all /norestart
```

- Now reboot.

- Download and install the Linux kernel update package:
https://wslstorestorage.blob.core.windows.net/wslblob/wsl_update_x64.msi

- Set WSL 2 as your default version:
```powershell
wsl --set-default-version 2
```

You're basically done.
- From Windows Store do a search for `WSL`.
A bunch of distros will come up - I went for Ubuntu 20.04 as the simplest
to manage.

You don't have to install the distro from the Windows Store though!
For example, here's a gist covering how to run **Arch on WSL2**:
https://gist.github.com/chhh/8458a41de99d9127c3364b5f3561a6e2

---

Instructions taken from: https://docs.microsoft.com/en-us/windows/wsl/install-win10