--  Replace Employee ID With The Unique Identifier


-- https://leetcode.com/problems/replace-employee-id-with-the-unique-identifier/description/?envType=study-plan-v2&envId=top-sql-50

SELECT e1.unique_id,e.name
FROM Employees e LEFT JOIN
EmployeeUNI e1 using (id)