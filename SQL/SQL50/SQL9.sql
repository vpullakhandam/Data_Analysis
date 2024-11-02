-- Rising Temperature


-- https://leetcode.com/problems/rising-temperature/description/?envType=study-plan-v2&envId=top-sql-50


SELECT w1.id
FROM Weather AS w1 , Weather AS w2
WHERE w1.Temperature > w2.Temperature AND DATEDIFF(w1.recordDate , w2.recordDate) = 1