-- 查询学过编号为"01"但是没有学过编号为"02"的课程的同学的信息:
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
