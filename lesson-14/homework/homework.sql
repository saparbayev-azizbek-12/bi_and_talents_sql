use msdb;

declare @table_body nvarchar(max) = '';
select @table_body = isnull(@table_body, '') +  '<tr><td>' + o.name + '</td><td>' + i.name + '</td><td>' + cast(i.type as varchar) + '</td><td>' + c.name + '</td></tr>'
from sys.indexes as i
join sys.objects as o
	on i.object_id = o.object_id
join sys.columns as c
	on i.object_id = c.object_id

declare @table nvarchar(max) = '
	<style>
			body {
				font-family: Arial, sans-serif;
				display: flex;
				justify-content: center;
				align-items: center;
				height: 100vh;
				background-color: #f4f4f4;
			}
			table {
				width: 60%;
				border-collapse: collapse;
				background: white;
				box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.1);
			}
			th, td {
				padding: 12px;
				text-align: center;
				border: 1px solid #ddd;
			}
			th {
				background: #007BFF;
				color: white;
			}
			tr:nth-child(even) {
				background: #f2f2f2;
			}
			tr:hover {
				background: #ddd;
			}
		</style>
	</head>
	<body>
		<table>
			<thead>
				<tr>
					<th>TableName</th>
					<th>IndexName</th>
					<th>IndexType</th>
					<th>ColumnName</th>
				</tr>
			</thead>
			<tbody>
				' + @table_body + '
			</tbody>
		</table>
	</body>

'


exec msdb.dbo.sp_send_dbmail
	@profile_name = 'SQLServerPractice',
	@recipients = 'qodirashirquliyev0@gmail.com',
	@subject = 'This message is sended from SQLServer',
	@body = @table,
	@body_format = 'HTML'

select sent_status,*
from msdb.dbo.sysmail_allitems
order by send_request_date

select * from msdb.dbo.sysmail_event_log