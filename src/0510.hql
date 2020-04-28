-- 查询不同课程成绩相同的学生的学生编号、课程编号、学生成绩:
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