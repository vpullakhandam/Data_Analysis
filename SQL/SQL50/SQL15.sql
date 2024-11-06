-- Not Boring Movies

-- https://leetcode.com/problems/not-boring-movies/description/?envType=study-plan-v2&envId=top-sql-50


select * from Cinema
where id%2!=0 AND description <> "boring"
order by rating DESC

