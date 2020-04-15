-- 查询学过"张三"老师授课的同学的信息:
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
