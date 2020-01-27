---
# Documentation: https://sourcethemes.com/academic/docs/managing-content/

title: "Zipping all relevant files in a git repo"
subtitle: ""
summary: "How to make a zip copy of all git repo files without garbage"
authors: []
tags: [git, howto]
categories: []
date: 2020-01-26T18:34:18-08:00
lastmod: 2020-01-26T18:34:18-08:00
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
This will skip all the unnecessary stuff, like `.git` directory,
and files ignored in the git repo itself:

`git archive --format=zip -o archive-name.zip HEAD`

You can omit `--format.zip` when you specify output files via `-o`,
the format will be inferred.  
Add `--prefix  subdir-name` to have all files in the archive be put into a folder inside the archive, e.g:  

`git archive --prefix subdir-name/ -o archive-name.zip HEAD`
