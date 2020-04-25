-- 检索"01"课程分数小于60，按分数降序排列的学生信息:
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
