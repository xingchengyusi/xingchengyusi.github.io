---
title: Git Commands
date: 2022-12-17 14:17:20
tags:
- git
- version control
- software engineering
category:
- computer
lang: en
---

# Merge

# Commit

## Edit commit before push

```bash
git commit --amend
```

# Hooks

Like a real hook, Git Hook will run a specific script before or after important git actions, such as committing, rebasing, and pushing.

## Where is it

All the hook files are stored in the `.git/hooks`:

```bash
applypatch-msg.sample     post-update.sample        pre-merge-commit.sample   pre-receive.sample        update.sample
commit-msg.sample         pre-applypatch.sample     pre-push.sample           prepare-commit-msg.sample
fsmonitor-watchman.sample pre-commit.sample                pre-rebase.sample         push-to-checkout.sample
```

## How to write?

Open `post-update.sample`; here is an example:

```bash
#!/bin/sh
#
# An example hook script to prepare a packed repository for use over
# dumb transports.
#
# To enable this hook, rename this file to "post-update".

exec git update-server-info
```

Actually, not only bash script works, `Python`, `Lua`, or other script language work. Remember to add the path of exec file at the first line.

```bash
#!/bin/sh
#!/bin/python3
#!/usr/bin/env python3
```

### Exit Value

In some `pre` check, the exit value could control whether the next step will run. If `exit(0)` is used in the pre-commit hook, the commit will achieve success. However, if the hook exit with `-1`(`exit(-1)`), the commit will be prevented until the requirements are met. Here is an example:

```python
#!/usr/bin/env python3

import os

res = os.system('black ./tensor/ --check')

if res == 0:
    exit(0)
else:
    print('Some codes need to be format! please fix it.')

exit(-1)
```

In this example, the script uses `black` to check whether the code is formatted or not. If the code is unformatted, it will prevent the commit.

## Usage

Remove the `.sample` in the file name; the hook will automatically run at a certain time.