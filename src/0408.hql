-- 查询至少有一门课与学号为"01"的同学所学课程相同的同学的信息:
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
