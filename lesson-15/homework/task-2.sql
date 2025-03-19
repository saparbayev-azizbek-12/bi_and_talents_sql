
use lesson_15;

drop table if exists items;
go

create table items
(
	ID						varchar(10),
	CurrentQuantity			int,
	QuantityChange   		int,
	ChangeType				varchar(10),
	Change_datetime			datetime
);

insert into items values
('A0013', 278,   99 ,   'out', '2020-05-25 0:25'), 
('A0012', 377,   31 ,   'in',  '2020-05-24 22:00'),
('A0011', 346,   1  ,   'out', '2020-05-24 15:01'),
('A0010', 347,   1  ,   'out', '2020-05-23 5:00'),
('A009',  348,   102,   'in',  '2020-04-25 18:00'),
('A008',  246,   43 ,   'in',  '2020-04-25 2:00'),
('A007',  203,   2  ,   'out', '2020-02-25 9:00'),
('A006',  205,   129,   'out', '2020-02-18 7:00'),
('A005',  334,   1  ,   'out', '2020-02-18 6:00'),
('A004',  335,   27 ,   'out', '2020-01-29 5:00'),
('A003',  362,   120,   'in',  '2019-12-31 2:00'),
('A002',  242,   8  ,   'out', '2019-05-22 0:50'),
('A001',  250,   250,   'in',  '2019-05-20 0:45');


;with income as (
    select * from items where ChangeType = 'in'
), 
outcome as (
    select * from items where ChangeType = 'out'
),
products_in_warehouse as (
    select 
		i.ID,
        i.Change_datetime as InDate,
        o.Change_datetime as OutDate,
        datediff(day, i.Change_datetime, o.Change_datetime) as DateDifference,
		i.QuantityChange - coalesce(
			sum(o.QuantityChange) over (
				partition by i.ID 
				order by o.Change_datetime 
				rows between unbounded preceding and current row
			), 
			0
		) as RemainingProduct,
		o.QuantityChange as QuantityChange
    from income i
    cross join outcome o
    where o.Change_datetime > i.Change_datetime
) 
select
    sum(case when DateDifference between 1 and 90 then QuantityChange else 0 end) as "1-90 days old",
    sum(case when DateDifference between 91 and 180 then QuantityChange else 0 end) as "91-180 days old",
    sum(case when DateDifference between 181 and 270 then QuantityChange else 0 end) as "181-270 days old",
    sum(case when DateDifference between 271 and 360 then QuantityChange else 0 end) as "271-360 days old",
    sum(case when DateDifference between 361 and 450 then QuantityChange else 0 end) as "361-450 days old"
from products_in_warehouse
where RemainingProduct > 0
--order by cast(substring(ID, 2, len(ID)) as int)




