-- Customer Who Visited but Did Not Make Any Transactions


-- https://leetcode.com/problems/customer-who-visited-but-did-not-make-any-transactions/description/?envType=study-plan-v2&envId=top-sql-50

-- Solution 1
SELECT 
    v.customer_id, 
    COUNT(v.visit_id) AS count_no_trans
FROM 
    Visits v
LEFT JOIN 
    Transactions t 
ON 
    v.visit_id = t.visit_id  
WHERE 
    t.transaction_id IS NULL
GROUP BY 
    v.customer_id;

-- Solution 2
select customer_id , count(visit_id) as count_no_trans from Visits
where 
visit_id not in (select  visit_id from Transactions)
group by customer_id;
