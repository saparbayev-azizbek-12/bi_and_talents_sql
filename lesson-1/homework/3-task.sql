create database lesson_1

use lesson_1
go

create table orders
(
	order_id int primary key,
	customer_name varchar(255),
	order_date date
);

alter table orders
drop constraint PK__orders__46596229D4416B28;

alter table orders
add constraint PK__orders__46596229D4416B28 primary key(order_id);