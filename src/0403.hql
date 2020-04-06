-- 查询平均成绩大于等于60分的同学的学生编号和学生姓名和平均成绩:
select a.s_id,
       a.s_name,
       round(avg(b.s_score), 1) avg_score
from student a
         join
     score b
     on
         a.s_id = b.s_id
group by a.s_id,
         a.s_name
having avg(b.s_score) >= 60
;