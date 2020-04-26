-- 查询同名同性学生名单，并统计同名人数:
use test0402;

select s_name,
       s_sex,
       count(*) cnt
from student
group by s_name, s_sex
having cnt > 1;
