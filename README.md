# dailyhive
an daily exercise of hive

# query syntax
    SELECT [ALL | DISTINCT] select_expr, select_expr, ...
    FROM table_reference
    [WHERE condition]
    [GROUP BY col_list [HAVING condition]]
    [CLUSTER BY col_list | [DISTRIBUTE BY col_list][SORT BY | ORDER BY col_list]]
    [LIMIT number]

# 查询"01"课程比"02"课程成绩高的学生的信息及课程分数
    select a.*,
           b.s_score 01_score,
           c.s_score 02_score
    from student a
             join
         score b
         on
             a.s_id = b.s_id and b.c_id = '01'
             left join
         score c
         on
             a.s_id = c.s_id and c.c_id = '02'
    where b.s_score > c.s_score;
