-- 查询本月过生日的学生:
use test0402;

select s_name, s_birth
from student
where month(`current_date`()) = month(s_birth);