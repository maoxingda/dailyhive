

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

### 1 查询"01"课程比"02"课程成绩高的学生的信息及课程分数:
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
### 2 查询平均成绩大于等于60分的同学的学生编号和学生姓名和平均成绩:
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
### 3 查询所有同学的学生编号、学生姓名、选课总数、所有课程的总成绩:
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

### 4 查询"李"姓老师的数量:
```mysql
use test0402;

select
    count(*) total_teacher
from
    teacher
where
    substring(t_name, 1, 1) = '李';
```

### 5 查询学过"张三"老师授课的同学的信息:

```mysql
use test0402;

-- "张三"老师上过的课程的课程id
create table t1 as
select
    course.c_id
from
    teacher
join
    course
on
    teacher.t_id = course.t_id
where
    teacher.t_name = '张三';

-- 学过"张三"老师上过的课程的学生id
create table t2 as
select
    distinct s_id
from
    score
join
    t1
on
    score.c_id = t1.c_id;

-- 查询学过"张三"老师授课的同学的信息:
select
    student.*
from
    student
join
    t2
on
    student.s_id = t2.s_id;

-- 删除临时表
drop table t1;
drop table t2;
```

### 6 查询学过编号为"01"并且也学过编号为"02"的课程的同学的信息:

```mysql
use test0402;

-- 学过01课程和02课程的学生id
create table t1 as
select
    s_id
from
    score
where
    c_id in ("01", "02")
group by
    s_id
having
    count(1) = 2;

-- 学生信息
select
    *
from
    student
join
    t1
on
    student.s_id = t1.s_id;

-- 删除临时表
drop table t1;
```

### 7 查询学过编号为"01"但是没有学过编号为"02"的课程的同学的信息:

```mysql
use test0402;

-- 学过01课程的学生id
create table t1 as
select
    s_id
from
    score
where
    c_id = '01';

-- 学过02课程的学生id
create table t2 as
select
    s_id
from
    score
where
    c_id = '02';

-- 学过01课程没学过02课程的学生id
create table t3 as
select
    t1.s_id
from
    t1
left join
    t2
on
    t1.s_id = t2.s_id
where
    t2.s_id is null;

-- 学过01课程没学过02课程的学生信息
select
    *
from
    student
join
    t3
on
    student.s_id = t3.s_id;

-- 删除临时表
drop table t1;
drop table t2;
drop table t3;
```

### 8 查询没有学全所有课程的同学的信息:

```mysql
use test0402;

-- 有成绩的学生的id、课程总数
create table t1 as
select
    s_id,
    count(*) num_course
from
    score
group by
    s_id;

select
    st.*
from
    student st
join
    t1
on
    st.s_id = t1.s_id
where
    t1.num_course < (select count(*) from course);

-- 删除临时表
drop table t1;
```