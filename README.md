# dailyhive
an daily exercise of hive   
[Hive sql语句必练50题](https://blog.csdn.net/Thomson617/article/details/83212338)

[TOC]

### query syntax
```mysql
SELECT [ALL | DISTINCT] select_expr, select_expr, ...
FROM table_reference
[WHERE condition]
[GROUP BY col_list [HAVING condition]]
[CLUSTER BY col_list | [DISTRIBUTE BY col_list][SORT BY | ORDER BY col_list]]
[LIMIT number]
```

### 查询"01"课程比"02"课程成绩高的学生的信息及课程分数:
```mysql
select a.*,
       b.s_score 01_score,
       c.s_score 02_score
from student a
         inner join
     score b
     on
         a.s_id = b.s_id and b.c_id = '01'
         left join
     score c
     on
         a.s_id = c.s_id and c.c_id = '02'
where b.s_score > c.s_score
;
```
### 查询平均成绩大于等于60分的同学的学生编号和学生姓名和平均成绩:
```mysql
select a.s_id,
       a.s_name,
       round(avg(b.s_score), 1) avg_score
from student a
         join
     score b
     on
         a.s_id = b.s_id
group by a.s_id,
         a.s_name
having avg(b.s_score) >= 60
;
```
### 查询所有同学的学生编号、学生姓名、选课总数、所有课程的总成绩:
```mysql
select stu.s_id,
       stu.s_name,
       count(s.c_id) totalcourse,
       sum(s.s_score) totalscore
from student stu
         join score s on stu.s_id = s.s_id
group by stu.s_id, stu.s_name
order by totalscore desc ;
```

### 查询"李"姓老师的数量:
```mysql
use test0402;

select
    count(*) total_teacher
from
    teacher
where
    substring(t_name, 1, 1) = '李';
```