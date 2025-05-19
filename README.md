# DataAnalytics-Assessment
I did not have a challenge with asssessment 1 and 2, it was pretty straight forward

The challenge in assessment 3 was understanding the right column that reflects the "last transaction." For savings accounts, it was tricky to determine if transaction_date was the correct field, and for plans, I had to decide between last_charge_date and other options.

How I Solved It:
I examined the schema in detail and selected transaction_date and last_charge_date based on logical assumptions and data availability. I also had to ensure both halves of the UNION ALL query matched in structure and that I sorted the final output by inactivity days in descending order for readability.

The challenge with assessment 4 was I was worried about a customer joined in the current month, PERIOD_DIFF() will return 0, leading to a division by zero error when calculating tenure.

How you solved it:
You used GREATEST(., 1) to ensure tenure is never less than 1 month, preventing that error.

