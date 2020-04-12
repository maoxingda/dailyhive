-- 查询所有同学的学生编号、学生姓名、选课总数、所有课程的总成绩:
use test0402;

select stu.s_id,
       stu.s_name,
       count(s.c_id)  totalcourse,
       sum(s.s_score) totalscore
from student stu
         join score s on stu.s_id = s.s_id
group by stu.s_id, stu.s_name
order by totalscore desc;

