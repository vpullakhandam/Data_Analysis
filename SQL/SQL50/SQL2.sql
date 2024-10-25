-- Find Customer Referee


-- https://leetcode.com/problems/find-customer-referee/description/?envType=study-plan-v2&envId=top-sql-50

SELECT name
FROM Customer
where referee_id is NULL or referee_id <>2 