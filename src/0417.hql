-- 查询各科成绩最高分、最低分和平均分：以如下形式显示：
-- 课程ID，课程name，最高分，最低分，平均分，及格率，中等率，优良率，优秀率:
-- 及格为>=60，中等为：70-80，优良为：80-90，优秀为：>=90
use test0402;

select c.c_id,
       c.c_name,
       t1.maxScore,
       t1.minScore,
       t1.avgScore,
       t1.passRate,
       t1.modeRate,
       t1.goodRate,
       t1.excellentRates
from course c
join (
    select c_id,
           max(s_score) as                                                       maxScore,
           min(s_score) as                                                       minScore,
           round(avg(s_score), 2)                                                avgScore,
           round(sum(if(s_score >= 60, 1, 0)) / count(c_id), 2)                  passRate,
           round(sum(if(s_score >= 60 and s_score < 70, 1, 0)) / count(c_id), 2) modeRate,
           round(sum(if(s_score >= 70 and s_score < 80, 1, 0)) / count(c_id), 2) goodRate,
           round(sum(if(s_score >= 80 and s_score < 90, 1, 0)) / count(c_id), 2) excellentRates
    from score
    group by c_id) t1 on t1.c_id = c.c_id;

