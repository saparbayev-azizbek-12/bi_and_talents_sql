use lesson_1
go

drop table if exists Book;
create table Book
(
	book_id int primary key identity(1,1),
	title varchar(255),
	author varchar(255),
	published_year int,
);

drop table if exists Member;
create table Member
(
	member_id int primary key identity(1,1),
	name varchar(255),
	email varchar(255),
	phone_number varchar(255)
);

drop table if exists Loan
create table Loan
(
	load_id int primary key identity(1,1),
	book_id int foreign key references Book(book_id),
	member_id int foreign key references Member(member_id),
	loan_date date,
	return_date date null
);

-- insert simple date
insert into Book (title, author, published_year) values
('the great gatsby', 'f. scott fitzgerald', 1925),
('to kill a mockingbird', 'harper lee', 1960),
('1984', 'george orwell', 1949);

insert into Member (name, email, phone_number) values
('alice johnson', 'alice@example.com', '123-456-7890'),
('bob smith', 'bob@example.com', '234-567-8901'),
('charlie brown', 'charlie@example.com', '345-678-9012');

insert into Loan (book_id, member_id, loan_date, return_date) values
(1, 1, '2025-02-01', '2025-02-10'),
(2, 2, '2025-02-05', null),
(3, 3, '2025-02-07', null);

select * from Loan;