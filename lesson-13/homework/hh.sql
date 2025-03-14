use lesson_13;

declare @input_day date = '2025-03-01';

declare @days_of_month int = day(eomonth(@input_day));
declare @i int = 1;

drop table if exists w_days;
create table w_days
(
    day_num int,
    week_day nvarchar(50)
);

while @i <= @days_of_month
begin
    insert into w_days (day_num, week_day)
    values (
        @i, 
        datename(weekday, datefromparts(year(@input_day), month(@input_day), @i))
    );
    
    set @i = @i + 1;
end;

select 
    min(case when week_day = 'sunday' then day_num end) as sunday,
    max(case when week_day = 'monday' then day_num end) as monday,
    max(case when week_day = 'tuesday' then day_num end) as tuesday,
    max(case when week_day = 'wednesday' then day_num end) as wednesday,
    max(case when week_day = 'thursday' then day_num end) as thursday,
    max(case when week_day = 'friday' then day_num end) as friday,
    max(case when week_day = 'saturday' then day_num end) as saturday
from w_days
group by datepart(week, cast(concat(year(@input_day), '-', month(@input_day), '-', day_num) as date)) 
         - datepart(week, datefromparts(year(@input_day), month(@input_day), 1));


