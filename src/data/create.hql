create schema if not exists test0402
    location 'hdfs://hadoop11:8020/user/hive/warehouse/test0402.db';

create table if not exists test0402.course
(
    c_id string,
    c_name string,
    t_id string
);

create table if not exists test0402.score
(
    s_id string,
    c_id string,
    s_score int
);

create table if not exists test0402.student
(
    s_id string,
    s_name string,
    s_birth string,
    s_sex string
);

create table if not exists test0402.teacher
(
    t_id string,
    t_name string
);