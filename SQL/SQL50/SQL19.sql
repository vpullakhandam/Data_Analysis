-- Queries Quality and Percentage

-- https://leetcode.com/problems/queries-quality-and-percentage/description/?envType=study-plan-v2&envId=top-sql-50

select query_name,round(avg(rating/position),2) as quality, 
ROUND(COUNT(CASE WHEN rating < 3 THEN 1 END) * 100.0 / COUNT(*), 2)
as poor_query_percentage
from Queries 
where query_name IS NOT NULL
group by query_name