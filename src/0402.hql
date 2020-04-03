-- 查询"01"课程比"02"课程成绩高的学生的信息及课程分数
select
    a.*,
    b.s_score 01_score,
    c.s_score 02_score
from
    student a
inner join
    score b
on
    a.s_id = b.s_id and b.c_id = '01'
left join
    score c
on
    a.s_id = c.s_id and c.c_id = '02'
where
    b.s_score > c.s_score
;