-- 查询所有学生的课程及分数情况:
use test0402;

select s_name,
       sum(`if`(c.c_name = '语文', s.s_score, 0)) chinese,
       sum(`if`(c.c_name = '数学', s.s_score, 0)) math,
       sum(`if`(c.c_name = '英语', s.s_score, 0)) english,
       sum(s_score) total_score
from student
join score s on student.s_id = s.s_id
join course c on s.c_id = c.c_id
group by s_name;
