-- 查询课程名称为"数学"，且分数低于60的学生姓名和分数:
use test0402;

select s2.s_name, s_score
from course
join score s on course.c_id = s.c_id
join student s2 on s.s_id = s2.s_id
where c_name = '数学' and s_score < 60;