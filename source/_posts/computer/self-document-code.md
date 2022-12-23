---
title: Self-Document Code
date: 2022-12-17 21:05:02
tags:
- code style
- software engineering
category:
- computer
lang: en
---

It is a good code-writing habit for code understanding and development.

# Why

Over time, code evolves, whereas code comments go stale.

<!-- more -->

# & Document

Self-documenting code does not obviate the need for documentation. Consider README files and Swagger docs. We still need those. Also, sometimes it might still make sense to leave code comments or drop a link to a confluence doc in the code in the code.

# Example

Version B is a self-document code.

Version A:

```swift
// The cellular range from the tower is 5 km.
// Let's assume there will be cell coverage in a circular area 
// where the tower is at the center. A simple model.
// Taking pi to the nearest hundredth, the coverage area will
// then be calculated as follows.
let x = 5.0
let y = 3.14 * pow(x, 2)
```

Version B:

```swift
let cellularRangeFromTowerKm = 5.0
let coverageAreaKm = circleArea(radius: cellularRangeFromTowerKm)

function circleArea(radius: Double) -> Double {
    let pi = 3.14
    let area = pi * pow(x, 2)
    return area
}
```
