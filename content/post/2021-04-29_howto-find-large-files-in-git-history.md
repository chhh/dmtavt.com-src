---
# Documentation: https://sourcethemes.com/academic/docs/managing-content/

title: "How to find large files in Git history: a one-liner"
subtitle: ""
summary: ""
authors: [chhh]
tags: [howto, git]
categories: [howto]
date: 2021-04-29T00:25:35-07:00
lastmod: 2021-04-29T00:25:35-07:00
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

One liner:
```shell
git rev-list --objects --all \
| git cat-file --batch-check='%(objecttype) %(objectname) %(objectsize) %(rest)' \
| sed -n 's/^blob //p' \
| sort --numeric-sort --key=2 \
| cut -c 1-12,41- \
| $(command -v gnumfmt || echo numfmt) --field=2 --to=iec-i --suffix=B --padding=7 --round=nearest
```

---
Credit SO: https://stackoverflow.com/a/42544963/88814