

# dailyhive

an daily exercise of hive   
[Hive sql语句必练50题](https://blog.csdn.net/Thomson617/article/details/83212338)

[TOC]



### query syntax
```mysql
SELECT [ALL | DISTINCT] select_expr, select_expr, ...
FROM table_reference
[WHERE where_condition]
[GROUP BY col_list]
[ORDER BY col_list]
[CLUSTER BY col_list | [DISTRIBUTE BY col_list] [SORT BY col_list]]
[LIMIT [offset,] rows]
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

### 9 查询至少有一门课与学号为"01"的同学所学课程相同的同学的信息:

```mysql
use test0402;

-- 01同学所学课程id
create table t1 as
select
    c_id
from
    score
where
    s_id = '01';

-- 至少学过1门01同学所学课程的学生id
create table t2 as
select
    distinct score.s_id
from
    score
left join
    t1
on
    t1.c_id = score.c_id
where
    t1.c_id is not null;

select
    st.*
from
    student st
join
    t2
on
    st.s_id = t2.s_id;

-- 删除临时表
drop table t1;
drop table t2;
```

### 10 查询和"01"号的同学学习的课程完全相同的其他同学的信息:

```mysql
use test0402;

-- 01同学所学课程id
create table t1 as
select
    c_id
from
    score
where
    s_id = '01';

-- 至少学过1门01同学所学课程的学生id
create table t2 as
select
    score.s_id
from
    score
join
    t1
on
    t1.c_id = score.c_id
group by
    score.s_id
having
    count(*) = (select count(*) from t1);

select
    st.*
from
    student st
join
    t2
on
    st.s_id = t2.s_id;

-- 删除临时表
drop table t1;
drop table t2;
```

### 11 没学过张三老师课程的学生id

```mysql
select s_name
from student
where s_id not in (select * from t3);

-- 没学过张三老师课程的学生id
select s_name
from student
where not exists (select * from t3 where student.s_id = t3.s_id);

-- 没学过张三老师课程的学生id
select s_name
from student
left join t3 on student.s_id = t3.s_id
where t3.s_id is null;

-- 删除临时表
drop table t1;
drop table t2;
drop table t3;
```

### 12 查询两门及其以上不及格课程的同学的学号，姓名及其平均成绩:

```mysql
use test0402;

-- 有课程不及格的学生id
create table t1 as
select s_id
from score
where s_score < 60;

-- 不及格课程总数
create table t2 as
select s_id,
       count(*) cnt
from t1
group by s_id;

-- 平均成绩
create table t3 as
select s_id,
       avg(s_score) avg_score
from score
group by s_id;

select s.s_id,
       s.s_name,
       t.avg_score
from t2
join student s on t2.s_id = s.s_id
join t3 t on s.s_id = t.s_id
where t2.cnt >= 2;

-- 删除临时表
drop table t1;
drop table t2;
drop table t3;
```

### 13 查询"李"姓老师的数量:

```mysql
use test0402;

select
    count(*) total_teacher
from
    teacher
where
    substring(t_name, 1, 1) = '李';
```

### 14 检索"01"课程分数小于60，按分数降序排列的学生信息:

```mysql
use test0402;

-- 01课程不及格学生id，score
create table t1 as
select s_id, s_score
from score
where c_id = '01' and s_score < 60;

-- 按01课程分数降序排序
select s.*, t1.s_score
from t1
join student s on t1.s_id = s.s_id
order by t1.s_score desc;

-- 删除临时表
drop table t1;
```

### 15 按平均成绩从高到低显示所有学生的所有课程的成绩以及平均成绩:

```mysql
use test0402;

select
    a.s_id,
    tmp1.s_score chinese,
    tmp2.s_score math,
    tmp3.s_score english,
    round(avg(a.s_score), 2) avgScore
from
    score a
left join
    (select s_id, s_score from score s1 where c_id = '01') tmp1
on
    tmp1.s_id = a.s_id
left join
    (select s_id, s_score from score s2 where c_id = '02') tmp2
on tmp2.s_id = a.s_id
left join
    (select s_id, s_score from score s3 where c_id = '03') tmp3
on tmp3.s_id = a.s_id
group by
    a.s_id, tmp1.s_score, tmp2.s_score, tmp3.s_score
order by
    avgScore desc;
```

### 16 查询学过"张三"老师授课的同学的信息:

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

### 17 查询没学过"张三"老师授课的同学的信息:

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

-- 查询没学过"张三"老师授课的同学的信息:
select
    student.*
from
    student
left join
    t2
on
    student.s_id = t2.s_id
where t2.s_id is null;

-- 删除临时表
drop table t1;
drop table t2;
```

### 18 cid，cname，最高分，最低分，平均分，及格率，中等率，优良率，优秀率:

```mysql
use test0402;

select c.c_id,
       c.c_name,
       t1.maxScore,
       t1.minScore,
       t1.avgScore,
       t1.passRate,
       t1.modeRate,
       t1.goodRate,
       t1.excellentRates
from course c
join (
    select c_id,
           max(s_score) as                                                       maxScore,
           min(s_score) as                                                       minScore,
           round(avg(s_score), 2)                                                avgScore,
           round(sum(if(s_score >= 60, 1, 0)) / count(c_id), 2)                  passRate,
           round(sum(if(s_score >= 60 and s_score < 70, 1, 0)) / count(c_id), 2) modeRate,
           round(sum(if(s_score >= 70 and s_score < 80, 1, 0)) / count(c_id), 2) goodRate,
           round(sum(if(s_score >= 80 and s_score < 90, 1, 0)) / count(c_id), 2) excellentRates
    from score
    group by c_id) t1 on t1.c_id = c.c_id;
```

### 19 按各科成绩进行排序，并显示排名

```mysql
use test0402;

(
    select s1.*,
           row_number() over (order by s1.s_score desc) Ranking
    from score s1
    where s1.c_id = '01'
    order by Ranking asc
)
union all
(
    select s2.*,
           row_number() over (order by s2.s_score desc) Ranking
    from score s2
    where s2.c_id = '02'
    order by Ranking asc
)
union all
(
    select s3.*,
           row_number() over (order by s3.s_score desc) Ranking
    from score s3
    where s3.c_id = '03'
    order by Ranking asc
);
```

### 20 查询学生的总成绩并进行排名:

```mysql
use test0402;

select s.s_id,
       s.s_name,
       sum(s_score) sum_score,
       row_number() over (order by sum(s_score) desc) rn
from score sc
join student s on sc.s_id = s.s_id
group by s.s_id, s.s_name
;
```

### 21 查询不同老师所教不同课程平均分从高到低显示:

```mysql
use test0402;

select t.t_name, c.c_name,
       round(avg(s.s_score), 1) avg_score
from teacher t
join course c on t.t_id = c.t_id
join score s on c.c_id = s.c_id
group by t.t_id, t.t_name, c.c_id, c.c_name
order by avg_score desc;
```

### 22 查询所有课程的成绩第2名到第3名的学生信息及该课程成绩:

```mysql
use test0402;

(
    select s2.*,
           c.c_name,
           s.s_score `score`
    from course c
             join score s on c.c_id = s.c_id
             join student s2 on s.s_id = s2.s_id
    where c.c_id = '01'
    order by s.s_score desc
    limit 2, 2
)
union all
(
    select s2.*,
           c.c_name,
           s.s_score `score`
    from course c
             join score s on c.c_id = s.c_id
             join student s2 on s.s_id = s2.s_id
    where c.c_id = '02'
    order by s.s_score desc
    limit 2, 2
)
union all
(
    select s2.*,
           c.c_name,
           s.s_score `score`
    from course c
             join score s on c.c_id = s.c_id
             join student s2 on s.s_id = s2.s_id
    where c.c_id = '03'
    order by s.s_score desc
    limit 2, 2
)
;
```

### 23 统计各科成绩各分数段人数：课程编号,课程名称,[100-85],[85-70],[70-60],[0-60]及所占百分比

```mysql
use test0402;

select c.c_id, c_name,
       sum(if(s.s_score >= 0 and s.s_score < 60, 1, 0)) sum0_60,
       round(100 * sum(if(s.s_score >= 0 and s.s_score < 60, 1, 0)) / count(c.c_id), 2) `%0_60`,
       sum(if(s.s_score >= 60 and s.s_score < 70, 1, 0)) sum60_70,
       round(100 * sum(if(s.s_score >= 60 and s.s_score < 70, 1, 0)) / count(c.c_id), 2) `%60_70`,
       sum(if(s.s_score >= 70 and s.s_score < 85, 1, 0)) sum70_85,
       round(100 * sum(if(s.s_score >= 70 and s.s_score < 85, 1, 0)) / count(c.c_id), 2) `%70_85`
from course c
join score s on c.c_id = s.c_id
group by c.c_id, c_name;
```

### 24 查询学生平均成绩及其名次:

```mysql
use test0402;

select *,
       row_number() over (order by avg_score desc) rank
from (
         select st.s_name,
                round(avg(s_score), 0) avg_score
         from score sc
                  join student st on sc.s_id = st.s_id
         group by st.s_id, st.s_name
     ) t1;
```

### 25 查询各科成绩前三名的记录

```mysql
use test0402;

select c.c_name, st.s_name, sc.s_score
from course c
join score sc on c.c_id = sc.c_id
join student st on sc.s_id = st.s_id
where c.c_id = '01'
order by sc.s_score desc
limit 3
;
```

### 26 查询每门课程被选修的学生数:

```mysql
use test0402;

select c.c_name, count(distinct s.s_id) cnt
from course c
join score s on c.c_id = s.c_id
group by c.c_id, c.c_name;
;
```

### 27 查询出只有两门课程的全部学生的学号和姓名:

```mysql
use test0402;

select sc.s_id, st.s_name
from score sc
join student st on sc.s_id = st.s_id
group by sc.s_id, st.s_name
having count(sc.s_score) = 2;
```

### 27 查询男生、女生人数:

```mysql
use test0402;

select sum(`if`(s_sex = '男', 1, 0)) man,
       sum(`if`(s_sex = '女', 1, 0)) woman
from student;
```

### 28 查询名字中含有"风"字的学生信息:

```mysql
use test0402;

select *
from student
where s_name like '%风%';
```

### 29 查询同名同性学生名单，并统计同名人数:

```mysql
use test0402;

select s_name,
       s_sex,
       count(*) cnt
from student
group by s_name, s_sex
having cnt > 1;
```

### 30 查询1990年出生的学生名单:

```mysql
use test0402;

select * from student where s_birth like '%1990%';
```

### 31 查询每门课程的平均成绩，结果按平均成绩降序排列

```mysql
-- 平均成绩相同时，按课程编号升序排列:
use test0402;

select c.c_id,
       round(avg(s.s_score), 1) avg_score
from course c
join score s on c.c_id = s.c_id
group by c.c_id
order by avg_score desc, c.c_id;
```

### 32 查询平均成绩大于等于85的所有学生的学号、姓名和平均成绩:

```mysql
use test0402;

select sc.s_id,
       s.s_name,
       round(avg(sc.s_score), 1) avg_score
from score sc
join student s on sc.s_id = s.s_id
group by sc.s_id, s.s_name
having avg(sc.s_score) >= 85;
```

### 33 查询课程名称为"数学"，且分数低于60的学生姓名和分数:

```mysql
use test0402;

select s2.s_name, s_score
from course
join score s on course.c_id = s.c_id
join student s2 on s.s_id = s2.s_id
where c_name = '数学' and s_score < 60;
```

### 34 查询所有学生的课程及分数情况:

```mysql
use test0402;

select s_name,
       sum(`if`(c.c_name = '语文', s.s_score, 0)) chinese,
       sum(`if`(c.c_name = '数学', s.s_score, 0)) math,
       sum(`if`(c.c_name = '英语', s.s_score, 0)) english,
       sum(s_score) total_score
from student
join score s on student.s_id = s.s_id
join course c on s.c_id = c.c_id
group by s_name;
```

### 35 查询任何一门课程成绩在70分以上的学生姓名、课程名称和分数:

```mysql
use test0402;

select s_name, c_name, s_score
from student
join score s on student.s_id = s.s_id
join course c on s.c_id = c.c_id
where s_score > 70
group by s.s_id, s_name, c_name, s_score;
```

### 36 查询课程不及格的学生:

```mysql
use test0402;

select student.*,
       c_name,
       s_score
from student
join score s on student.s_id = s.s_id
join course c on s.c_id = c.c_id
where s_score < 60;
```

### 37 查询课程编号为01且课程成绩在80分以上的学生的学号和姓名:

```mysql
use test0402;

select s2.s_id, s_name, s_score
from course
join score s on course.c_id = s.c_id
join student s2 on s.s_id = s2.s_id
where s.c_id = '01' and s_score >= 80;
```

### 38 求每门课程的学生人数:

```mysql
use test0402;

select c_name, count(*) cnt
from course
join score s on course.c_id = s.c_id
group by c_name;
```

### 39 查询选修"张三"老师所授课程的学生中，成绩最高的学生信息及其成绩:

```mysql
use test0402;

select st.*, c_name, s_score
from student st
join
     (
         select s_id, c_name, s_score
         from score s
         join course c on s.c_id = c.c_id
         join teacher t on c.t_id = t.t_id
         where t_name = '张三'
         order by s_score desc
         limit 1
     ) t1
on st.s_id = t1.s_id
;
```

### 40 查询不同课程成绩相同的学生的学生编号、课程编号、学生成绩:

```mysql
use test0402;

create table t1 as
select *,
       rank() over (partition by s_id order by s_score) rk
from score;

create table t2 as
select s_id
from t1
group by s_id
having sum(rk) = count(c_id);

select s.*
from t2
join score s on t2.s_id = s.s_id;

-- 删除临时表
drop table t1;
drop table t2;
```

### 41 查询每门课程成绩最好的前三名:

```mysql
use test0402;

(
    select *
    from score
    where c_id = '01'
    order by s_score desc
    limit 3
)
union all
(
    select *
    from score
    where c_id = '02'
    order by s_score desc
    limit 3
)
union all
(
    select *
    from score
    where c_id = '03'
    order by s_score desc
    limit 3
)
;
```

### 42 统计每门课程的学生选修人数（超过5人的课程才统计）:

```mysql
use test0402;

select c_id,
       count(distinct s_id) stus
from score
group by c_id
having stus > 5
order by stus desc, c_id;
```

### 43 检索至少选修两门课程的学生学号:

```mysql
use test0402;

select s_id
from score
group by s_id
having count(c_id) >= 2
;
```

### 44 查询选修了全部课程的学生信息:

```mysql
use test0402;

select s_id
from score
group by s_id
having count(c_id) = (select count(c_id) from course);
```

### 45 查询各学生的年龄(周岁):

```mysql
use test0402;

select s_name, s_birth,
       `if`(case when month(`current_date`()) < month(s_birth) then true
           when month(`current_date`()) = month(s_birth) and day(`current_date`()) < day(s_birth) then true
           else false end,
           year(`current_date`()) - year(s_birth) - 1,
           year(`current_date`()) - year(s_birth)) age
from student;
```

### 46 查询本周过生日的学生:

```mysql
use test0402;

select s_name, s_birth
from student
where date_format(s_birth, 'MM-dd')
    between date_format(date_add(`current_date`(), 1 - dayofweek(`current_date`())), 'mm-dd')
    and date_format(date_add(`current_date`(), 7 - dayofweek(`current_date`())), 'mm-dd');
```

### 47 查询下周过生日的学生:

```mysql
use test0402;

select s_name, s_birth
from student
where date_format(s_birth, 'MM-dd')
    between date_format(date_add(date_add(`current_date`(), 7), 1 - dayofweek(`current_date`())), 'mm-dd')
    and date_format(date_add(date_add(`current_date`(), 7), 7 - dayofweek(`current_date`())), 'mm-dd');
```

### 48 查询本月过生日的学生:

```mysql
use test0402;

select s_name, s_birth
from student
where month(`current_date`()) = month(s_birth);
```

### 49 查询12月过生日的学生:

```mysql
use test0402;

select s_name, s_birth
from student
where month(s_birth) = '12'
;
```