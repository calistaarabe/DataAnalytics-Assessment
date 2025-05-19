SELECT 
    owner_id,
    name,
    savings_count,
    investment_count,
    FORMAT(total_deposits, 0) AS total_deposits
FROM (
    SELECT 
        a.id AS owner_id,
        CONCAT(a.first_name, ' ', a.last_name) AS name,
        COUNT(DISTINCT b.id) AS savings_count,
        COUNT(DISTINCT c.id) AS investment_count,
        SUM(b.confirmed_amount + c.amount) AS total_deposits
    FROM users_customuser a
    JOIN savings_savingsaccount b
        ON a.id = b.owner_id 
        AND b.confirmed_amount > 0
    JOIN plans_plan c
        ON a.id  = c.owner_id 
        AND c.amount > 0
    GROUP BY a.id, name
) AS zz
ORDER BY zz.total_deposits DESC
