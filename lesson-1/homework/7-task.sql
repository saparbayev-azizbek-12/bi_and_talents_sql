use lesson_1
go

create table invoice
(
	invoice_id int identity(1,1) primary key,
	amount decimal
);

insert into invoice(amount) values (100.50), (200.75), (150.00), (175.25), (250.40);

set identity_insert invoice on;
insert into invoice(invoice_id, amount) values (100, 300.25);
set identity_insert invoice off;
