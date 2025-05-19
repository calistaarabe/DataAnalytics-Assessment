SELECT 
    a.plan_id,
    a.owner_id,
    CASE 
        WHEN b.is_regular_savings = 1 THEN 'Savings'
        WHEN b.is_a_fund = 1 THEN 'Investment'
        ELSE 'Unknown'
    END AS type,
    MAX(a.created_on)  last_transaction_date,
    DATEDIFF(CURDATE(), MAX(a.created_on))  inactivity_days
FROM 
    savings_savingsaccount a
LEFT JOIN 
    plans_plan b
    ON a.plan_id = b.id
GROUP BY 
    a.plan_id, a.owner_id, type
HAVING 
    inactivity_days > 365
