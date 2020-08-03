---
# Documentation: https://sourcethemes.com/academic/docs/managing-content/

title: "Automatically starting ssh-agent when powershell or git-bash are started"
subtitle: "Including a snippet for .bashrc on linux-like environment"
summary: "Start ssh-agent once when powershell or git-bash is started.
Saves typing the ssh key password every time you interact with
a remote repo."
authors: []
tags: [powershell, ssh, ssh-agent]
categories: []
date: 2020-08-03T11:49:38-07:00
lastmod: 2020-08-03T11:49:38-07:00
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


## Windows environment
It's best to configure OpenSSH Authentication Agent service to automatically start.
Alternatively, you can start it manually every time when opening powershell for the first time:

```powershell
Start-Service ssh-agent
```

To have SSH agent to automatically start with Windows, you can run  (from elevated powershell prompt):
```powershell
Set-Service ssh-agent -StartupType Automatic 
```

After that, you need to add your ssh key once:
```powershell
ssh-add C:\Users\your-name\ssh\id_rsa 
```

Now everytime the `ssh-agent` is started, the key will be there. You can check which keys are registered with the `ssh-agent`:

```powershell
ssh-add -l
```

Credit:
https://superuser.com/questions/1327633/how-to-maintain-ssh-agent-login-session-with-windows-10s-new-openssh-and-powers



## Linux-like environement
On linux or in git-for-windows environment, I use the following snippet in my `.bashrc` to achieve the same effect:

```bash
# This is used to start ssh-agent once when git-bash is started.
# Saves typing the ssh key password every time you interact with
# a remote repo.

env=~/.ssh/agent.env

agent_load_env () { test -f "$env" && . "$env" >| /dev/null ; }

agent_start () {
    (umask 077; ssh-agent >| "$env")
    . "$env" >| /dev/null ; }

agent_load_env

# agent_run_state: 0=agent running w/ key; 1=agent w/o key; 2= agent not running
agent_run_state=$(ssh-add -l >| /dev/null 2>&1; echo $?)

if [ ! "$SSH_AUTH_SOCK" ] || [ $agent_run_state = 2 ]; then
    agent_start
    ssh-add
elif [ "$SSH_AUTH_SOCK" ] && [ $agent_run_state = 1 ]; then
    ssh-add
fi

unset env
```
