---
# Documentation: https://sourcethemes.com/academic/docs/managing-content/

title: "How to view Git changes on a single branch since its creation"
subtitle: ""
summary: ""
authors: [chhh]
tags: [howto, git]
categories: [howto]
date: 2021-04-29T00:20:37-07:00
lastmod: 2021-04-29T00:20:37-07:00
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
The command:
`git log --oneline master..feature/some-branch`

Will show commits on feature branch since it was forked off master.

Suppose you have a repo that looks like this:
```
base  -  A  -  B  -  C  -  D   (master)
                \
                 \-  X  -  Y  -  Z   (myBranch)
```

Verify the repo status:
```shell
> git checkout master
Already on 'master'
> git status ; git log --oneline
On branch master
nothing to commit, working directory clean
d9addce D
110a9ab C
5f3f8db B
0f26e69 A
e764ffa base
```

and for myBranch:

```shell
> git checkout myBranch
> git status ; git log --oneline
On branch myBranch
nothing to commit, working directory clean
3bc0d40 Z
917ac8d Y
3e65f72 X
5f3f8db B
0f26e69 A
e764ffa base
```

Suppose you are on myBranch, and you want only changes **SINCE** master. Use the two-dot version:

```shell
> git log --oneline master..myBranch
3bc0d40 Z
917ac8d Y
3e65f72 X
```

The three-dot version gives all changes from the tip of master to the tip of myBranch. However, note that the common commit B is not included:

```shell
> git log --oneline master...myBranch
d9addce D
110a9ab C
3bc0d40 Z
917ac8d Y
3e65f72 X
```

--- 

Credits:
- SO question: https://stackoverflow.com/questions/9725531/show-commits-since-branch-creation
- SO answer: https://stackoverflow.com/a/24769534/88814
