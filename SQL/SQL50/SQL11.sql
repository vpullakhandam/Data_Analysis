-- Employee Bonus

-- https://leetcode.com/problems/employee-bonus/?envType=study-plan-v2&envId=top-sql-50

select name, bonus
from Employee LEFT JOIN Bonus
using (empId)
where bonus IS NULL or bonus <1000 