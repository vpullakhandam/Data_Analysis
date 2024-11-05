-- Customer Who Visited but Did Not Make Any Transactions


-- https://leetcode.com/problems/customer-who-visited-but-did-not-make-any-transactions/description/?envType=study-plan-v2&envId=top-sql-50

select customer_id, count(v.visit_id) as count_no_trans
from Visits v LEFT JOIN Transactions t
using(visit_id)
where t.visit_id IS NULL -- or use t.transaction_id IS NULL
group by customer_id
