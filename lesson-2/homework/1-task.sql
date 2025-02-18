create database lesson_2
go

use lesson_2
go

create table test_identity
(
	id int identity(1,1),
	name varchar(255)
);

insert into test_identity(name) 
values ('Alice'), ('Bob'), ('Charlie'), ('David'), ('Eve');

-- Delete
delete from test_identity;
select * from test_identity;
insert into test_identity(name) 
values ('Ali');
select * from test_identity;

-- Truncate
truncate table test_identity;
select * from test_identity;
insert into test_identity(name) 
values ('Ali');
select * from test_identity;

-- Drop
drop table test_identity;
select * from test_identity;