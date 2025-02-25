use lesson_4;

CREATE TABLE TestMaxo
(
    Year1 INT
    ,Max1 INT
    ,Max2 INT
    ,Max3 INT
);
GO
 
INSERT INTO TestMax 
VALUES
    (2001,10,101,87)
    ,(2002,103,19,88)
    ,(2003,21,23,89)
    ,(2004,27,28,91);


-- method 1
select Year1,
	iif(max1>max2 and max1>max3, max1,
		iif(max2>max3, max2, max3)
		) as MaxValue
from TestMax

-- method 2
select Year1,
case
	when max1 >= max2 and max1 >= max3 then max1
	when max2 >= max3 then max2
	else max3 
end as MaxValue
from TestMax

-- method 3
select Year1, greatest(Max1, Max2, Max3) as MaxValue
from TestMax;

-- method 4
select Year1, max(Max1) as MaxValue from (select Year1, Max1 from TestMax
union all
select Year1, Max2 from TestMax
union all
select Year1, Max3 from TestMax) as newtable
group by Year1



