-- 统计各科成绩各分数段人数：课程编号,课程名称,[100-85],[85-70],[70-60],[0-60]及所占百分比
use test0402;

select c.c_id, c_name,
       sum(if(s.s_score >= 0 and s.s_score < 60, 1, 0)) sum0_60,
       round(100 * sum(if(s.s_score >= 0 and s.s_score < 60, 1, 0)) / count(c.c_id), 2) `%0_60`,
       sum(if(s.s_score >= 60 and s.s_score < 70, 1, 0)) sum60_70,
       round(100 * sum(if(s.s_score >= 60 and s.s_score < 70, 1, 0)) / count(c.c_id), 2) `%60_70`,
       sum(if(s.s_score >= 70 and s.s_score < 85, 1, 0)) sum70_85,
       round(100 * sum(if(s.s_score >= 70 and s.s_score < 85, 1, 0)) / count(c.c_id), 2) `%70_85`
from course c
join score s on c.c_id = s.c_id
group by c.c_id, c_name;