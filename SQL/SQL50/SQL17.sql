-- Project Employees I

-- https://leetcode.com/problems/project-employees-i/description/?envType=study-plan-v2&envId=top-sql-50

select project_id,round(avg(experience_years),2) as average_years
from Project left join Employee
using (employee_id)
group by project_id

