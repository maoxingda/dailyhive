-- 查询所有课程的成绩第2名到第3名的学生信息及该课程成绩:
use test0402;

(
    select s2.*,
           c.c_name,
           s.s_score `score`
    from course c
             join score s on c.c_id = s.c_id
             join student s2 on s.s_id = s2.s_id
    where c.c_id = '01'
    order by s.s_score desc
    limit 2, 2
)
union all
(
    select s2.*,
           c.c_name,
           s.s_score `score`
    from course c
             join score s on c.c_id = s.c_id
             join student s2 on s.s_id = s2.s_id
    where c.c_id = '02'
    order by s.s_score desc
    limit 2, 2
)
union all
(
    select s2.*,
           c.c_name,
           s.s_score `score`
    from course c
             join score s on c.c_id = s.c_id
             join student s2 on s.s_id = s2.s_id
    where c.c_id = '03'
    order by s.s_score desc
    limit 2, 2
)
;