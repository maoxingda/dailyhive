-- 查询没学过"张三"老师讲授的任一门课程的学生姓名:
use test0402;

-- 张三老师的id
create table t1 as
select
    t_id
from
    teacher
where
    t_name = '张三';

-- 张三老师所讲授的课程id
create table t2 as
select
    c_id
from
    course
join
    t1
on
    course.t_id = t1.t_id;

-- 学过张三老师课程的学生id
create table t3 as
select s_id
from score
join t2 t on score.c_id = t.c_id;

-- 没学过张三老师课程的学生id
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
