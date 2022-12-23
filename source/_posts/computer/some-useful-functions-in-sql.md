---
title: Some Useful Functions in SQL
lang: en
date: 2022-12-17 21:35:27
tags:
- sql
- data science
category:
- computer
---

## combine two varchar
`concat('a', 'b')`
in *group*: `group_concate(distinct name order by name separator ',')`

<!-- more -->

## upper case and lower case
`upper('a')` and `lower('a')`
## select char in varchar
1. select n char from left or right side `left(name, n)` or `right(name, n)`
2. select all chars from nTH to mTH from the left `substr(name, n, m)`
## length
`length('aaaa')`
## agg functions
`count(name)`
in *group* also could use `count(distinct name)`
## ROUND numbers
rounds a number to a specified number of decimal places
`round(num, 2)` or `round(235.415, -1) = 240.000`