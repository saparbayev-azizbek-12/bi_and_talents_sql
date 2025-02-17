use lesson_1
go

create table category
(
	category_id int primary key,
	category_name varchar(255),
);

create table item
(
	item_id int primary key,
	item_name varchar(255),
	category_id int foreign key references category(category_id)
);

alter table item
drop constraint [FK__item__category_i__4E88ABD4];

alter table item
add constraint [FK__item__category_i__4E88ABD4] foreign key(category_id) references category(category_id); 
