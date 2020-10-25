---
# Documentation: https://sourcethemes.com/academic/docs/managing-content/

title: "If it feels `git clone` is throttled on Windows..."
subtitle: "Try changing automated packet size selection"
summary: "Symptoms of the problem: internet connection is fast and a torrent download of Ubuntu
can go at 10MB/s, but git clone gets 'stuck' at 500-600KB/s."
authors: [chhh]
tags: [git, windows, troubleshooting]
categories: []
date: 2020-10-25T00:07:15-07:00
lastmod: 2020-10-25T00:07:15-07:00
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

## Symptoms of the problem
- Internet connection is fast and a torrent download of Ubuntu can go at 10MB/s,
but git clone gets 'stuck' at 500-600KB/s.
- Connecting through VPN helps a bit sometimes, increasing the speed, but not to
it's full potential.
- Another computer using the same network (wired or wireless) gets full download
speed when cloning, so you know it's not the connection at fault.

```bat
netsh interface tcp show global
```
Output:
```yaml
Querying active state...

TCP Global Parameters
----------------------------------------------
Receive-Side Scaling State          : disabled
Receive Window Auto-Tuning Level    : disabled
Add-On Congestion Control Provider  : default
ECN Capability                      : disabled
RFC 1323 Timestamps                 : disabled
Initial RTO                         : 1000
Receive Segment Coalescing State    : enabled
Non Sack Rtt Resiliency             : disabled
Max SYN Retransmissions             : 4
Fast Open                           : enabled
Fast Open Fallback                  : enabled
HyStart                             : enabled
Proportional Rate Reduction         : enabled
Pacing Profile                      : off
```

The problem is this line: `Receive Window Auto-Tuning Level    : disabled`.

## Solution

Change `Receive Window Auto-Tuning Level` to `normal` (from elevated cmd/powershell):

```bat
netsh int tcp set global autotuninglevel=normal
```

After this my `git clone` speeds went up to the bandwidth of my internet connection.
