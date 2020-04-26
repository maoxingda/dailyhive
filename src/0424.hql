-- 查询各科成绩前三名的记录
use test0402;

select c.c_name, st.s_name, sc.s_score
from course c
join score sc on c.c_id = sc.c_id
join student st on sc.s_id = st.s_id
where c.c_id = '01'
order by sc.s_score desc
limit 3
;