---
title: Tips About NULL in SQL
lang: en
date: 2022-12-17 21:34:16
tags:
- sql
- data science
- NULL
category:
- computer
---

## Select

should use `is null`, not `= null` because NULL is a special marker to indicate a data value does not exist, not a data value. So that cannot use = to check for equality.

<!-- more -->

## Output NULL

To output null as a value, should use another select clause as a shell, for example:
```sql
select (
	select distinct salary as SecondHighestSalary
	from Employee
	order by salary desc
	limit 1 offset 1
) as SecondHighestSalary
```
The clause will output the second higher salary but cannot output "NULL" if the database is null. The shell clause will transfer them to the null.

Additional, to assign a variable, using = is Ok.