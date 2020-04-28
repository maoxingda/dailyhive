-- 查询本周过生日的学生:
use test0402;

select s_name, s_birth
from student
where date_format(s_birth, 'MM-dd')
    between date_format(date_add(`current_date`(), 1 - dayofweek(`current_date`())), 'mm-dd')
    and date_format(date_add(`current_date`(), 7 - dayofweek(`current_date`())), 'mm-dd');
