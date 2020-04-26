-- 查询学生平均成绩及其名次:
use test0402;

select *,
       row_number() over (order by avg_score desc) rank
from (
         select st.s_name,
                round(avg(s_score), 0) avg_score
         from score sc
                  join student st on sc.s_id = st.s_id
         group by st.s_id, st.s_name
     ) t1;
