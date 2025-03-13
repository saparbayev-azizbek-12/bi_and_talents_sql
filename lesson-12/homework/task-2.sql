use lesson_12;
go
DROP PROCEDURE get_procedures_and_functions;
go
create procedure get_procedures_and_functions
    @database_name nvarchar(255) = null
as
begin
    set nocount on;

    declare @sql nvarchar(max);
    set @sql = '';

    if @database_name is not null
    begin
        set @sql = '
        select 
            ''' + @database_name + ''' as database_name,
            routines.specific_schema as schema_name,
            routines.specific_name as object_name,
            routines.routine_type as object_type,
            parameters.parameter_name as parameter_name,
            parameters.data_type as parameter_data_type,
            parameters.character_maximum_length as max_length
        from ' + quotename(@database_name) + '.information_schema.routines routines
        left join ' + quotename(@database_name) + '.information_schema.parameters parameters
        on routines.specific_name = parameters.specific_name
        and routines.specific_schema = parameters.specific_schema
        where routines.routine_type in (''procedure'', ''function'')
        order by schema_name, object_name, parameter_name;';
    end
    else
    begin
        declare @db_name nvarchar(255);

        declare db_cursor cursor for
        select name from sys.databases 
        where database_id > 4

        open db_cursor;
        fetch next from db_cursor into @db_name;

        while @@fetch_status = 0
        begin
            set @sql = @sql + '
            select 
                ''' + @db_name + ''' as database_name,
                routines.specific_schema as schema_name,
                routines.specific_name as object_name,
                routines.routine_type as object_type,
                parameters.parameter_name as parameter_name,
                parameters.data_type as parameter_data_type,
                parameters.character_maximum_length as max_length
            from ' + quotename(@db_name) + '.information_schema.routines routines
            left join ' + quotename(@db_name) + '.information_schema.parameters parameters
            on routines.specific_name = parameters.specific_name
            and routines.specific_schema = parameters.specific_schema
            where routines.routine_type in (''procedure'', ''function'')
            order by schema_name, object_name, parameter_name;
            ';

            fetch next from db_cursor into @db_name;
        end

        close db_cursor;
        deallocate db_cursor;
    end

    exec sp_executesql @sql;
end;

exec get_procedures_and_functions lesson_12