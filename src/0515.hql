-- 查询各学生的年龄(周岁):
-- 按照出生日期来算，当前月日 < 出生年月的月日则，年龄减一
use test0402;

select s_name, s_birth,
       `if`(case when month(`current_date`()) < month(s_birth) then true
           when month(`current_date`()) = month(s_birth) and day(`current_date`()) < day(s_birth) then true
           else false end,
           year(`current_date`()) - year(s_birth) - 1,
           year(`current_date`()) - year(s_birth)) age
from student;
