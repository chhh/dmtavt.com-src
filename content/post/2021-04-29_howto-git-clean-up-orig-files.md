---
# Documentation: https://sourcethemes.com/academic/docs/managing-content/

title: "How-to: Git clean up .orig files generated after conflict resolution"
subtitle: "This works even if .orig has been added to .gitignore. Works for any files matching a regular expression."
summary: ""
authors: [chhh]
tags: [howto, git]
categories: [howto]
date: 2021-04-29T00:02:34-07:00
lastmod: 2021-04-29T00:02:34-07:00
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

## Preamble
After a merge conflict resolution you're often left with files ending
with `.orig` extension. I have them added to my global `.gitignore`.
Hence I can't easily get rid of them with regular:
`git clean -fd`.

## Solution
`git clean` has `-e` argument for a regular expression to match files.
To preview what will happen:  
`git clean -e '!*.orig' --dry-run`

To actually delete the files:  
`git clean -e '!*.orig' -f`


It's that simple.