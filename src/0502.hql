-- 查询平均成绩大于等于85的所有学生的学号、姓名和平均成绩:
use test0402;

select sc.s_id,
       s.s_name,
       round(avg(sc.s_score), 1) avg_score
from score sc
join student s on sc.s_id = s.s_id
group by sc.s_id, s.s_name
having avg(sc.s_score) >= 85;
