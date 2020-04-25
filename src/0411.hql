-- 查询两门及其以上不及格课程的同学的学号，姓名及其平均成绩:
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
