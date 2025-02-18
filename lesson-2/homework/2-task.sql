use lesson_2
go

create table data_types_demo
(
	id int,
	name varchar(255),
	price decimal(18,2),
	timestapms datetime,
	weight float,
	age tinyint,
	notes text,
	is_active bit
);

insert into data_types_demo 
values
	(1, 'John Doe', 50000.75, GETDATE(), 76.234, 24, 'This is a sample note', 1);


select * from data_types_demo;