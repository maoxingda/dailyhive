-- 查询出只有两门课程的全部学生的学号和姓名:
use test0402;

select sc.s_id, st.s_name
from score sc
join student st on sc.s_id = st.s_id
group by sc.s_id, st.s_name
having count(sc.s_score) = 2;