-- 查询男生、女生人数:
use test0402;

select sum(`if`(s_sex = '男', 1, 0)) man,
       sum(`if`(s_sex = '女', 1, 0)) woman
from student;
