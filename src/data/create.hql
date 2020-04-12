create database if not exists test0402;

create table if not exists test0402.course
(
    c_id   string,
    c_name string,
    t_id   string
)
    row format delimited fields terminated by ',';

create table if not exists test0402.score
(
    s_id    string,
    c_id    string,
    s_score int
)
    row format delimited fields terminated by ',';

create table if not exists test0402.student
(
    s_id    string,
    s_name  string,
    s_birth string,
    s_sex   string
)
    row format delimited fields terminated by ',';

create table if not exists test0402.teacher
(
    t_id   string,
    t_name string
)
    row format delimited fields terminated by ',';

load data local inpath 'test0402_student.csv' into table test0402.student;
load data local inpath 'test0402_teacher.csv' into table test0402.teacher;
load data local inpath 'test0402_course.csv' into table test0402.course;
load data local inpath 'test0402_score.csv' into table test0402.score;

use test0402;
select * from student;
select * from teacher;
select * from course;
select * from score;