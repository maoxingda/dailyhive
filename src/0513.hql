-- 检索至少选修两门课程的学生学号:
use test0402;

select s_id
from score
group by s_id
having count(c_id) >= 2
;