-- 查询课程编号为01且课程成绩在80分以上的学生的学号和姓名:
use test0402;

select s2.s_id, s_name, s_score
from course
join score s on course.c_id = s.c_id
join student s2 on s.s_id = s2.s_id
where s.c_id = '01' and s_score >= 80;