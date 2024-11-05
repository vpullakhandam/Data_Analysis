-- Managers with at Least 5 Direct Reports

-- https://leetcode.com/problems/managers-with-at-least-5-direct-reports/description/?envType=study-plan-v2&envId=top-sql-50

select name
from Employee
where id IN ( select managerId from Employee group by managerId having count(*)>=5)