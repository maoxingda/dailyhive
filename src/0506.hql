-- 查询课程不及格的学生:
use test0402;

select student.*,
       c_name,
       s_score
from student
join score s on student.s_id = s.s_id
join course c on s.c_id = c.c_id
where s_score < 60;