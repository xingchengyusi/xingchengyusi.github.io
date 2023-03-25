---
title: Python Variables of Class or Instance
lang: en
date: 2023-03-24 01:04:33
tags:
- python language
- computer
category:
- computer
---

# What they are?

In Python class, there are two kinds of variables: class variables and instance variables. 

| Kinds | Belong | Declear | Value |
| --- | --- | --- | --- |
| Class | Class | Class Block | Share |
| Instance | Instance | Inside functions | Unique |

For example, we have class variables `a` and `b`, and instance variables `c`.

```python
class Example:
    a = 'a'
    b = 'b'

    def __init__(self, v):
        self.c = v
```

# Difference

## Initialization

From the above example, we can see that the class variables are pre-set by definition, but the instance variables should initialize by the instance initialization.

## Calling

For class variables, we could call it by any instance of the class, or just use the class name. For instance variables, we can only call it by the corresponding instance. For instance:

```python
e1 = Example(1)
e2 = Example(2)

print(e1.a) # a
print(e2.a) # a
print(Example.a) # a

print(e1.c) # 1
print(e2.c) # 2
```

## Modification

Since class variables belong to the class itself, all instances of the same class will share the same values of those variables. Edit the value of class variables though one instance will be reflected when calling the same variable by other instances or classes.

Following the above instance, we have:

```python
print(Example.a) # a
print(Example.b) # b

print(e1.c) # 1
print(e2.c) # 2

Example.a = 'z'
print(Example.a) # z
print(e1.a) # z
print(e2.a) # z
```

## Priority

Similar to the local variables and global variables, the priority of the instance variable is higher than the class variable. That means if one instance and class variable has the same name with different values, Python will print the value of the instance first when calling by instance. For example, we define the class `Example2`:

```python
class Example2:
    a = 'a'
    b = 'b'

    def __init__(self, v):
        self.c = v
        self.a = v

e3 = Example2(3)
e4 = Example2(4)

print(e3.a) # 3
print(e4.a) # 4
print(Example2.a) # a
```

# Conclusion

In object-oriented programming, Python defines the class-level variables as class variables and sees the object level as instance variables. Initialization, calling, modification, and priority are four different points they have. Correct usage could help reduce the repeat and code smartly.
