SELECT
    frequency_category,
    COUNT(id) AS customer_count,
    ROUND(AVG(avg_transactions_per_month), 1) AS avg_transactions_per_month
FROM
(
    SELECT
        id,
        AVG(transactions_count) AS avg_transactions_per_month,
        CASE
            WHEN AVG(transactions_count) >= 10 THEN 'High Frequency'
            WHEN AVG(transactions_count) BETWEEN 3 AND 9 THEN 'Medium Frequency'
            ELSE 'Low Frequency'
        END AS frequency_category
    FROM
    (
        SELECT
            a.id,
            DATE_FORMAT(b.transaction_date, '%Y-%m'),
            COUNT(*) AS transactions_count
        FROM
            users_customuser a
        JOIN
            savings_savingsaccount b
            ON a.id = b.owner_id
        GROUP BY
            a.id,
            DATE_FORMAT(b.transaction_date, '%Y-%m')
    ) AS monthly_txns
    GROUP BY
        id
) AS avg_txns
GROUP BY
    frequency_category
ORDER BY
    CASE frequency_category
        WHEN 'High Frequency' THEN 1
        WHEN 'Medium Frequency' THEN 2
        WHEN 'Low Frequency' THEN 3
    END