use lesson_2;
go

drop table if exists worker;
create table worker (
    id int primary key,
    name nvarchar(100)
);

bulk insert worker
from 'C:\Users\ADMIN\Desktop\bi_and_talents_sql\lesson-2\homework\sample.csv'
with (
    firstrow = 2,
    fieldterminator = ',',
    rowterminator = '\n'
);

select * from worker;
