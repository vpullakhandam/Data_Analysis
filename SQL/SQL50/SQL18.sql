-- Percentage of Users Attended a Contest


-- https://leetcode.com/problems/percentage-of-users-attended-a-contest/description/?envType=study-plan-v2&envId=top-sql-50

select contest_id, round(count(DISTINCT r.user_id)*100/(select count(*) from Users),2) as percentage
from Users as u left join Register as r
using (user_id)
group by contest_id
order by percentage DESC, contest_id