-- 查询选修了全部课程的学生信息:
use test0402;

select s_id
from score
group by s_id
having count(c_id) = (select count(c_id) from course);