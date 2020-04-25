-- 查询和"01"号的同学学习的课程完全相同的其他同学的信息:
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
