use lesson_1
go

drop table account;
create table account
(
	account_id int primary key,
	balance decimal,
	account_type varchar(255),
	constraint account_balance_check check (balance >= 0),
	constraint account_account_type_check check (account_type in ('Saving', 'Checking'))
);

alter table account
drop constraint account_balance_check;
alter table account
drop constraint account_account_type_check;

alter table account
add constraint account_balance_check check (balance >= 0);
alter table account
add constraint account_account_type_check check (account_type in ('Saving', 'Checking'));
