-- 查询任何一门课程成绩在70分以上的学生姓名、课程名称和分数:
use test0402;

select s_name, c_name, s_score
from student
join score s on student.s_id = s.s_id
join course c on s.c_id = c.c_id
where s_score > 70
group by s.s_id, s_name, c_name, s_score;