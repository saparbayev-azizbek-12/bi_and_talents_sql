use lesson_1
go

drop table if exists books;
create table books
(
	book_id int primary key identity,
	title varchar(255) not null,
	price decimal(10,2),
	genre varchar(255) default 'Unknown',
	constraint books_price check (price > 0)
);

insert into books(title, price)
values
	('Atom Habits', 8.45)

insert into books(title, price, genre)
values
	('Harry Potter', 19.45, 'Advanture, Fantastic')

insert into books(title, price, genre)
values
	('Harry Potter', -19.45, 'Advanture, Fantastic')
-- The INSERT statement conflicted with the CHECK constraint "books_price". The conflict occurred in database "lesson_1", table "dbo.books", column 'price'.


select * from books

