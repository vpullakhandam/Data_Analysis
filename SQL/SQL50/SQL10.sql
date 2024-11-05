
-- Average Time of Process per Machine

-- https://leetcode.com/problems/average-time-of-process-per-machine/description/?envType=study-plan-v2&envId=top-sql-50

select a1.machine_id, round(avg(a2.timestamp-a1.timestamp),3) processing_time
from Activity a1 JOIN Activity a2
where 
a1.machine_id = a2.machine_id
AND 
a1.process_id = a2.process_id
AND 
a1.activity_type="start"
AND 
a2.activity_type="end"
group by a1.machine_id