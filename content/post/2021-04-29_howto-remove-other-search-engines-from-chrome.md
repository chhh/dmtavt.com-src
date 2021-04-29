---
# Documentation: https://sourcethemes.com/academic/docs/managing-content/

title: "How to remove \"other search engines\" from Chrome"
subtitle: ""
summary: ""
authors: [chhh]
tags: [howto, chrome]
categories: [howto]
date: 2021-04-29T00:15:51-07:00
lastmod: 2021-04-29T00:15:51-07:00
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

- Open the Chrome search engine settings page: [chrome://settings/searchEngines](chrome://settings/searchEngines)

- Selector for topmost "Remove search engine" button in "Other search engines" list:

```js
document.querySelector("body > settings-ui").shadowRoot
.querySelector("#main").shadowRoot
.querySelector("settings-basic-page").shadowRoot
.querySelector("#basicPage > settings-section.expanded > settings-search-page").shadowRoot
.querySelector("#pages > settings-subpage > settings-search-engines-page").shadowRoot
.querySelector("#otherEngines").shadowRoot
.querySelector("#frb0").shadowRoot
.querySelector("#delete");
```

- You can repeatedly call the selector and "click()" on the button.

```js
document.querySelector("body > settings-ui").shadowRoot
.querySelector("#main").shadowRoot
.querySelector("settings-basic-page").shadowRoot
.querySelector("#basicPage > settings-section.expanded > settings-search-page").shadowRoot
.querySelector("#pages > settings-subpage > settings-search-engines-page").shadowRoot
.querySelector("#otherEngines").shadowRoot
.querySelector("#frb0").shadowRoot
.querySelector("#delete")
.click();  
```
