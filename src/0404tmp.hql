drop table if exists stu_buk;

create table if not exists stu_buk
(
    id   string,
    name string
)
    clustered by (id) into 4 buckets
    row format delimited fields terminated by '\t'
-- stored as orc
;

desc stu_buk;

desc formatted stu_buk;

truncate table stu_buk;

load data inpath '/student/student.txt' into table stu_buk;
load data local inpath '/opt/module/datas/student.txt' into table stu_buk;

select *
from stu_buk
;

select *
from stu_buk
         tablesample (bucket 1 out of 2)
;

create table if not exists dept
(
    deptno int,
    dname  string,
    loc    int
)
    row format delimited fields terminated by '\t';

create table if not exists emp
(
    empno    int,
    ename    string,
    job      string,
    mgr      int,
    hiredate string,
    sal      double,
    comm     double,
    deptno   int
)
    row format delimited fields terminated by '\t';

load data local inpath '/opt/module/datas/dept.txt' into table dept;
load data local inpath '/opt/module/datas/emp.txt' into table emp;

select *
from dept
;

select *
from emp
;

select deptno,
       round(avg(sal), 0) avg_sal
from emp
group by deptno
order by avg_sal
;

select deptno,
       job,
       max(sal) max_sal
from emp
group by deptno, job
;

select deptno,
       round(avg(sal), 0) avg_sal
from emp
group by deptno
having avg(sal) > 2000
;

-- 根据员工表和部门表中的部门编号相等，查询员工编号、员工名称和部门名称；
select emp.empno,
       emp.ename,
       d.dname
from emp
         join dept d on emp.deptno = d.deptno
;

select e.empno,
       e.ename,
       d.deptno
from emp e
         join
     dept d
     on
                 e.deptno
                 = d.deptno or e.ename = d.deptno;

set mapreduce.job.reduces=3;
set mapreduce.job.reduces;

select *
from emp sort by deptno desc;

insert overwrite local directory '/opt/module/datas/sortby-result'
select *
from emp sort by deptno desc;

insert overwrite local directory '/opt/module/datas/distribute-result'
select *
from emp
    distribute by
    deptno
    sort by
    empno desc
;

select comm, comm
from emp;

select comm, nvl(comm, -1)
from emp;

-- name	dept_id	sex
-- 悟空	A	男
-- 大海	A	男
-- 宋宋	B	男
--
--
-- 凤姐	A	女
-- 婷姐	B	女
-- 婷婷	B	女
create table if not exists emp2
(
    name   string,
    deptid string,
    sex    string
)
    row format delimited fields terminated by '\t'
;

desc emp2;

select *
from emp2
;

select deptid,
       count(*)
from emp2
group by deptid
;

-- 求出不同部门男女各多少人
select deptid,
       sum(if(sex = '男', 1, 0)) sum_male,
       sum(if(sex = '女', 1, 0)) sum_female
from emp2
group by deptid
;

-- name	constellation	blood_type
-- 孙悟空	白羊座	A
-- 大海	射手座	A
-- 宋宋	白羊座	B
-- 猪八戒	白羊座	A
-- 凤姐	射手座	A
-- 苍老师	白羊座	B

drop table if exists nconst;

create table if not exists nconst
(
    name  string,
    const string,
    blood string
)
    row format delimited fields terminated by '\t'
;

desc nconst;

select *
from nconst;

select t1.col1,
       concat_ws('|', collect_set(t1.name))
from (
         select concat_ws(',', const, blood) col1,
                name
         from nconst
     ) t1
group by t1.col1
;

-- 《疑犯追踪》	悬疑,动作,科幻,剧情
-- 《Lie to me》	悬疑,警匪,动作,心理,剧情
-- 《战狼2》	战争,动作,灾难

create table if not exists movie_info
(
    movie    string,
    category string
)
    row format delimited fields terminated by '\t'
;

desc movie_info;

select *
from movie_info;

truncate table movie_info;

select movie_info.movie,
       tbl.cate
from movie_info
         lateral view
             explode(split(category, ',')) tbl as cate;
