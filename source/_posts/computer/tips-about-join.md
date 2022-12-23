---
title: Tips About Join
lang: en
date: 2022-12-17 21:32:02
tags:
- sql
- data science
category:
- computer
---

![](https://www.runoob.com/wp-content/uploads/2019/01/sql-join.png)
`left` and `right` join are outer join.

<!-- more -->

What happens after left joins? Example: [[183. Customers Who Never Order]]
```sql
Create table If Not Exists Customers (id int, name varchar(255))
Create table If Not Exists Orders (id int, customerId int)
Truncate table Customers
insert into Customers (id, name) values ('1', 'Joe')
insert into Customers (id, name) values ('2', 'Henry')
insert into Customers (id, name) values ('3', 'Sam')
insert into Customers (id, name) values ('4', 'Max')
Truncate table Orders
insert into Orders (id, customerId) values ('1', '3')
insert into Orders (id, customerId) values ('2', '1')

# if run
SELECT *
FROM Customers
LEFT JOIN Orders
ON Customers.id = Orders.customerId

# result are
{"headers": ["id", "name", "id", "customerId"], "values": [[1, "Joe", 2, 1], [2, "Henry", null, null], [3, "Sam", 1, 3], [4, "Max", null, null]]}
```
## Without ON
In the left or right join, ON is necessary. However, in MySQL and `join`, ON is optional. In this case, using `join` without `on` will produce a cross join.
## Condition in ON or WHERE
In the inner join, write conditions in on or where has no differences. However, if using a left join or right join, there is a difference. For example:
```sql
SELECT *
FROM dbo.Customers AS CUS 
LEFT JOIN dbo.Orders AS ORD 
ON CUS.CustomerID = ORD.CustomerID
WHERE ORD.OrderDate >'20090515'

SELECT *
FROM dbo.Customers AS CUS 
LEFT JOIN dbo.Orders AS ORD 
ON CUS.CustomerID = ORD.CustomerID
AND ORD.OrderDate >'20090515'
```
ON is **a filter when producing the temp table**, in the left join case it will return all left items and ignore the `date` condition in the above example. Different from `ON`, `WHERE` will **execute after the temp table is produced**. Thus it will delete all items that do not meet the conditions.