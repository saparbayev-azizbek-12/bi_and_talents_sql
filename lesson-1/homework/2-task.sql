use MyDB
go

drop table product
create table product
(
	product_id int unique,
	product_name varchar(255),
	price decimal(10,2)
);

alter table product
drop constraint UQ__product__47027DF4261C03B9;

alter table product
add constraint UQ__product__47027DF4261C03B9 unique(product_id);

alter table product
add constraint UQ__product__47027DF4261C03B8 unique(product_id, product_name);