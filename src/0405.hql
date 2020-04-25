-- 查询学过编号为"01"并且也学过编号为"02"的课程的同学的信息:
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
