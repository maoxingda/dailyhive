-- 查询没有学全所有课程的同学的信息:
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
