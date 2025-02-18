use lesson_2;
go

create table student 
(
	id int primary key identity(1,1),
	name varchar(255),
	classes int not null,
	tuition_per_class decimal(10,2) not null,
	total_tuition as (classes * tuition_per_class) persisted
);

insert into student (name, classes, tuition_per_class) 
values 
    ('Ali', 5, 200.00),
    ('Bobur', 3, 250.50),
    ('Bahrom', 4, 180.75);

select * from student

