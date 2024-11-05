-- Rising Temperature


-- https://leetcode.com/problems/rising-temperature/description/?envType=study-plan-v2&envId=top-sql-50


select w1.id 
from Weather w1 join Weather w2
on w1.recordDate = w2.recordDate+INTERVAL 1 DAY
where w1.temperature > w2.temperature