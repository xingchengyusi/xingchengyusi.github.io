---
title: Bash Commands
lang: en
date: 2022-12-17 21:28:36
tags:
- bash
- terminal
category:
- computer
---

# PATH

`echo $PATH` to display the variables.

And use `PATH DEFAULT=${PATH}:/path/to/file` to add a new one.

# pwd

shows the current dictionary.

# find

find a file with given name:

`find . -name file_name`

# cat

`cat` could read the file content and output as a standard output stream.

# alias

Create a shortcut of a command, for example:

`alias lll = ls -a`

# more, less, most

less = more + backward navigation

most = more + less + some other features

| name | more | less | most |
| --- | --- | --- | --- |
| forward navigation | support | support | s |
| backward navigation | limited | s | s |
| other features | no | some | all of more and less |

# which

`which ls` display the location of executables.

# | Pipeline

Receive the input stream and output as the input of another command.

`history | grep ls`

# > Direction

Receive the input stream and overwrite to the file.

`"aaa" > a.py`

# chmod

`chmod 777 main.py` add permission for the file to be executable.

the second parameter is person add/remove permission.

- User
    - u: user
    - g: group
    - o: other
- +/-
- Permission
    - r: read
    - w: write
    - e: execute

# whoami

existential crisis, to show the user name.

# Run executable file in terminal

## PATH

Type in `./clean` instead of `clean`. Or, if you don't want to type the `./` prefix every time, add the present working directory (the dot) to your PATH environment variable (e.g. in your ~/.bash_profile or its equivalent in another shell).