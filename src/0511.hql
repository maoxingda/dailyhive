-- 查询每门课程成绩最好的前三名:
use test0402;

(
    select *
    from score
    where c_id = '01'
    order by s_score desc
    limit 3
)
union all
(
    select *
    from score
    where c_id = '02'
    order by s_score desc
    limit 3
)
union all
(
    select *
    from score
    where c_id = '03'
    order by s_score desc
    limit 3
)
;