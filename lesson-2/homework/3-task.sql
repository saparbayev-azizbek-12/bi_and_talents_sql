use lesson_2;
go

create table photos
(
	id int primary key identity,
	photo varbinary(max)
);

insert into photos
select BulkColumn from openrowset(
	bulk 'F:\HMS\media\image\google-plus.png', single_blob
) as img;

select * from photos;