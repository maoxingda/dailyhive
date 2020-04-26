-- 按各科成绩进行排序，并显示排名
use test0402;

(
    select s1.*,
           row_number() over (order by s1.s_score desc) Ranking
    from score s1
    where s1.c_id = '01'
    order by Ranking asc
)
union all
(
    select s2.*,
           row_number() over (order by s2.s_score desc) Ranking
    from score s2
    where s2.c_id = '02'
    order by Ranking asc
)
union all
(
    select s3.*,
           row_number() over (order by s3.s_score desc) Ranking
    from score s3
    where s3.c_id = '03'
    order by Ranking asc
);
