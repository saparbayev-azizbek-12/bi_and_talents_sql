create database lesson_12;
go
use lesson_12;

select 
	TABLE_CATALOG as DatabaseName,
	TABLE_SCHEMA as SchemaName,
	TABLE_NAME as TableName,
	COLUMN_NAME as ColumnName,
	CONCAT(DATA_TYPE, '(' + 
		case 
			when cast(CHARACTER_MAXIMUM_LENGTH as varchar) = '-1' then 'max' 
			else cast(CHARACTER_MAXIMUM_LENGTH as varchar)
		end + ')') as DataType
from lesson_11.Information_schema.columns


select name from sys.databases where name not in ('master', 'tempdb', 'model', 'msdb')

create table #temp
(
	databasename varchar(255),
	tableschema varchar(255),
	tablename varchar(255),
	columnname varchar(255),
	datatype varchar(255)
);

--------------------------------------------------------------

drop table if exists databases_names
create table databases_names (
	id int,
	name varchar(255)
);

insert into databases_names(name, id)
select name, row_number() over(order by name) as rnk 
from sys.databases 
where name not in ('master', 'tempdb', 'model', 'msdb', 'AdventureWorks2022', 'TSQLV6')

select * from databases_names
------------------------------------------------------------------

declare @query NVARCHAR(MAX);
declare @i int = 1
declare @databases_cnt int = (select count(1) from databases_names)
select @databases_cnt

while @i <= @databases_cnt
begin
	declare @database_name varchar(255) = (select name from databases_names where id = @i)
	set @i = @i + 1

	set @query = '
	select 
		TABLE_CATALOG as DatabaseName,
		TABLE_SCHEMA as SchemaName,
		TABLE_NAME as TableName,
		COLUMN_NAME as ColumnName,
		CONCAT(DATA_TYPE, ''('' + 
			case 
				when cast(CHARACTER_MAXIMUM_LENGTH as varchar(255)) = ''-1'' then ''max'' 
				else cast(CHARACTER_MAXIMUM_LENGTH as varchar(255))
			end + '')'') as DataType
	from ' + @database_name + '.Information_schema.columns';

	insert into #temp
	exec sp_executesql @query
end

select * from #temp

