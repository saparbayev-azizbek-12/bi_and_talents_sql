use lesson_1
go

create table customer
(
	customer_id int primary key,
	name varchar(255),
	city varchar(255) default 'Unknown'
);

alter table customer
drop constraint [DF__customer__city__6A30C649];

alter table customer
add constraint [DF_customer_city] default 'Unknown' for city;