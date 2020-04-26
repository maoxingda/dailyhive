-- 查询每门课程的平均成绩，结果按平均成绩降序排列
-- 平均成绩相同时，按课程编号升序排列:
use test0402;

select c.c_id,
       round(avg(s.s_score), 1) avg_score
from course c
join score s on c.c_id = s.c_id
group by c.c_id
order by avg_score desc, c.c_id;