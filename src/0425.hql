-- 查询每门课程被选修的学生数:
use test0402;

select c.c_name, count(distinct s.s_id) cnt
from course c
join score s on c.c_id = s.c_id
group by c.c_id, c.c_name;
;