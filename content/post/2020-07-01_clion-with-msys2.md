---
title: "Using Msys2 as the MinGW based toolchain in CLion"
subtitle: ""
summary: "Quick tutorials on installation of toolchains on CLion website are a little vague. Step by step instructions provided here."
authors: []
tags: [clion, msys2, c++]
categories: []
date: 2020-07-01T00:10:15-07:00
lastmod: 2020-07-01T00:10:15-07:00
featured: false
draft: true

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
## Why MinGW?
MinGW - in order to make native binaries without extra library dependencies, such as `cygwin1.dll` in case of Cygwin.

## Problem
Following this tutorial about configuring CLion on Windows:  
https://www.jetbrains.com/help/clion/quick-tutorial-on-configuring-clion-on-windows.html  
I went to the [download site for MinGW-w64](http://mingw-w64.org/doku.php/download) and was baffled by the abundance of choices.
You probably can try using just [MingW-W64-builds](http://mingw-w64.org/doku.php/download/mingw-builds), but I chose [Msys2](https://www.msys2.org/) instead.

## The process
- Download and run the Msys2 installer: https://www.msys2.org.
- At the end start Msys2 command prompt.
- Update the packages:
  - `pacman -Syu`
  - `pacman -Su`
- Install the mingw-w64-x86_64 toolchain collection, it includes everything CLion expects:
  - `pacman -S mingw-w64-x86_64-toolchain`
    - Presents you a choice of tools, I pressed _Enter_ for _default=All_.
- Optionally install CMake as well:
  - `pacman -S mingw-w64-x86_64-cmake`
- Start CLion, _Settings_->_Build, Execution, Deployment_->Toolchains,
click `+` sign to add a new MinGW toolchain.
- Select `<msys2-install>/mingw64` as the Environment path. It should find all the other tools within it.
- If you installed CMake in Msys2, also manually point CLion to its binary: `<msys2-install>/bin/cmake.exe`. For me it seemed to work fine with CMake that's bundled in CLion.
