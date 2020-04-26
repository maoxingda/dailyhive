-- 查询名字中含有"风"字的学生信息:
use test0402;

select *
from student
where s_name like '%风%';
