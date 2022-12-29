---
title: Import in Python
lang: en
date: 2022-12-23 14:20:48
tags:
- computer language
- computer
- python
category:
- computer
---

Hello, as a Pythonista, sometimes I have been confused about how to use `import` correctly and efficiently. This article will cover all things I know about it.

<!-- more -->

# What do we import?

In an application, we often use `import` to import another module or package and let the following code could use them. So in the first part, I will discuss what modules and packages are.

A module is an object that serves as an organizational unit of Python code. It has a namespace containing arbitrary Python objects. Also, it is a concept of Python runtime. In coding, it often corresponds to a `.py` file.

A package is a special module with `__path__` attribute. In coding, it often corresponds to a dictionary that contain multiple `.py` files and dictionaries.

| | In OS | In Python |
| --- | --- | --- |
| module | file | object |
| packge | dictionary | object with `__path__` attribute |

# Import module

Import the change file to a Python module. For example,

```python
import mytest
```

In this process, Python will:

1. Get the name `mytest` as a string.
2. Check a module name `mytest` exists **in cache**.
3. Begin to find module `mytest`.
4. Find the module in **build-in module** (`sys`, `os`).
5. Find file could be loaded as `mytest` in `sys.path` as the sequence.
   - If Python finds a file in the first dictionary, it will stop finding and begin loading.
6. Building a module: run the file in an independent namespace.
7. Update cache.
8. Assign the object to variable `mytest`.

{% asset_img import-module.drawio.svg Import module flow chart %}

All set. Now we could use the variable!

## Special Scenario

I will use some special scenarios in this section to show the details.

### Import a module multiple times

For instance, there is a Python file `test.py`:

```python
class T:
    pass


print("test is imported.")
```

Now, we import it in `example1.py` two times. What will happen? How many times of above string will be printed?

```python
import test
import test
```

The answer is **1** time. Since after the first run, Python will store this object in the cache, and next time, it will check and load from the cache directly.

{% asset_img import-module-multiple-times.png %}

### Import class from a file

If there is a Python file `test.py` contains a class `T`:

```python
class T:
    pass


print("test is imported.")
```

If in the following code, What is the output of the following code?

```python
from test import T
print('second')
import test
```

The answer is:

{% asset_img import_class_from_a_file.png %}

When Python imports a class inside a file, it will find and run the file to produce an object of this file. The only difference from importing the whole module is assigning the class to the variable, not the entire thing. Also, updating the cache will store the whole object, not just the class object. So the print sentence will run once when importing the class `T` before importing the whole `test`.

### Import file from custom sys.path 1

Consider the following code:

```python
import sys
sys.path = []

import test
```

What is the output of the program?

{% asset_img import_file_from_custom_syspath_1.png %}

Well, the program will report an error and import nothing. Since `test` is not in the cache and is not a built-in package, Python will find it in dictionaries of `sys.path`. However, the program sets this list to empty, and Python will find nothing absolutely.

### Import file from custom sys.path 2

Consider the following code. Unlike above, I have two same-name files in sub-folder `dir1` and `dir2`.

```python
import sys
sys.path = ['/Users/cz/projects/example/dir2', '/Users/cz/projects/example/dir1']
print(sys.path)

import test
```

What is the output of the program?

{% asset_img import_file_from_custom_syspath_2.png %}

According to the above rules, *Python* will search the file in `sys.path` as a sequence. If *Python* finds the target file in the first folder, it will terminate the search and never look up the second one. In this case, only the `test.py` file in `dir2` will be imported.

# Import package

# Reference

Special Thanks [Tian Gao's detailed video](https://www.bilibili.com/video/BV1K24y1k7XA) in Bilibili. I highly recommend everyone who knows Chinese should review it.