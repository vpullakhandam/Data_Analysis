-- Average Selling Price

-- https://leetcode.com/problems/average-selling-price/description/?envType=study-plan-v2&envId=top-sql-50


select p.product_id, IFNULL(round(SUM(price*units)/SUM(units),2),0) as average_price
FROM Prices p
LEFT JOIN UnitsSold u
ON p.product_id = u.product_id
AND u.purchase_date BETWEEN p.start_date AND p.end_date
GROUP BY p.product_id;