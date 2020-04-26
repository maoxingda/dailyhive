-- 查询选修"张三"老师所授课程的学生中，成绩最高的学生信息及其成绩:
use test0402;

select st.*, c_name, s_score
from student st
join
     (
         select s_id, c_name, s_score
         from score s
         join course c on s.c_id = c.c_id
         join teacher t on c.t_id = t.t_id
         where t_name = '张三'
         order by s_score desc
         limit 1
     ) t1
on st.s_id = t1.s_id
;