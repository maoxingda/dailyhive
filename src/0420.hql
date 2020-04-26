-- 查询不同老师所教不同课程平均分从高到低显示:
use test0402;

select t.t_name, c.c_name,
       round(avg(s.s_score), 1) avg_score
from teacher t
join course c on t.t_id = c.t_id
join score s on c.c_id = s.c_id
group by t.t_id, t.t_name, c.c_id, c.c_name
order by avg_score desc;