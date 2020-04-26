-- 求每门课程的学生人数:
use test0402;

select c_name, count(*) cnt
from course
join score s on course.c_id = s.c_id
group by c_name;