-- 按平均成绩从高到低显示所有学生的所有课程的成绩以及平均成绩:
use test0402;

select
    a.s_id,
    tmp1.s_score chinese,
    tmp2.s_score math,
    tmp3.s_score english,
    round(avg(a.s_score), 2) avgScore
from
    score a
left join
    (select s_id, s_score from score s1 where c_id = '01') tmp1
on
    tmp1.s_id = a.s_id
left join
    (select s_id, s_score from score s2 where c_id = '02') tmp2
on tmp2.s_id = a.s_id
left join
    (select s_id, s_score from score s3 where c_id = '03') tmp3
on tmp3.s_id = a.s_id
group by
    a.s_id, tmp1.s_score, tmp2.s_score, tmp3.s_score
order by
    avgScore desc;
