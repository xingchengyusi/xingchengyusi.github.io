---
title: Tmux Shortcut
lang: en
date: 2022-12-17 21:30:52
tags:
- tmux
- shortcut
- terminal
- remote
category:
- computer
---

start new:

    tmux

start new with session name:

    tmux new -s myname

<!-- more -->

attach:

    tmux a  #  (or at, or attach)

attach to named:

    tmux a -t myname

list sessions:

    tmux ls

<a name="killSessions"></a>kill session:

    tmux kill-session -t myname

<a name="killAllSessions"></a>Kill all the tmux sessions:

    tmux ls | grep : | cut -d. -f1 | awk '{print substr($1, 0, length($1)-1)}' | xargs kill

Copy from https://gist.github.com/MohamedAlaa/2961058