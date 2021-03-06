use msdb
go
declare @jobname sysname, @jobid uniqueidentifier
declare acursor cursor for 
select j.job_id , j.name from sysjobs j left join sysjobschedules s on j.job_id = s.job_id where s.job_id is null
open acursor
fetch acursor into @jobid, @jobname
while @@fetch_status = 0
begin 
	exec sp_add_jobschedule @job_id = @jobid, @name = @jobname
	, @enabled = 0
	, @freq_type = 8
	, @freq_interval = 1
	, @freq_recurrence_factor =1 

	fetch acursor into @jobid, @jobname
end
close acursor
deallocate acursor
