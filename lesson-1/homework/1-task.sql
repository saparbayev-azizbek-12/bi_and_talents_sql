use MyDB
go

create table student
(
	id int,
	name varchar(255),
	age int
);

alter table student
alter column id int not null;