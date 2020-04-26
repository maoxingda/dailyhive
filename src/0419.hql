-- 查询学生的总成绩并进行排名:
use test0402;

select s.s_id,
       s.s_name,
       sum(s_score) sum_score,
       row_number() over (order by sum(s_score) desc) rn
from score sc
join student s on sc.s_id = s.s_id
group by s.s_id, s.s_name
;
