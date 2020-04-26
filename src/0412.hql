-- 查询"李"姓老师的数量:
use test0402;

select
    count(*) total_teacher
from
    teacher
where
    t_name like '%李%';