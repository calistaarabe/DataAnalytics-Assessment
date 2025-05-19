SELECT 
    A.id AS customer_id,
    CONCAT(A.first_name, ' ', A.last_name) AS name,
    GREATEST(PERIOD_DIFF(DATE_FORMAT(CURDATE(), '%Y%m'), DATE_FORMAT(A.date_joined, '%Y%m')), 1) AS tenure_months,
    COUNT(B.id) AS total_transactions,
    -- GREATEST(1) is to remove any  division by zero.
    ROUND(
        (COUNT(B.id) / GREATEST(PERIOD_DIFF(DATE_FORMAT(CURDATE(), '%Y%m'), DATE_FORMAT(A.date_joined, '%Y%m')), 1)) 
        * 12 
        * (0.001 * AVG(B.amount)),
        2
    ) AS estimated_clv
FROM 
    users_customuser A
LEFT JOIN 
    savings_savingsaccount B ON A.id = B.owner_id
GROUP BY 
    A.id, name
ORDER BY 
    estimated_clv DESC 