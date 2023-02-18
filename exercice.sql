-- Fetch the last 2 customers in alphabetical order (A-Z) – exclude ‘id’ from the results.
SELECT first_name,
    last_name
FROM customers
ORDER BY last_name DESC
LIMIT 2;
-- Use SQL to delete all purchases made by Scott.
DELETE FROM purchases
WHERE customer_id = (
        SELECT customer_id
        FROM customers
        WHERE first_name = 'Scott'
            AND last_name = 'Scott'
    );
-- Does Scott still exist in the customers table, even though he has been deleted? Try and find him.
SELECT *
FROM customers
WHERE first_name = 'Scott'
    AND last_name = 'Scott';
-- To find all purchases and join with the customers table so that Scott's order appears with empty/blank values for the customer's first and last name, you can use a LEFT JOIN as follows:
SELECT purchases.quantity_purchased,
    items.item_name,
    customers.first_name,
    customers.last_name
FROM purchases
    LEFT JOIN customers ON purchases.customer_id = customers.customer_id
    JOIN items ON purchases.item_id = items.item_id;
-- To find all purchases and join with the customers table so that Scott's order does NOT appear, you can use an INNER JOIN as follows:
SELECT purchases.quantity_purchased,
    items.item_name,
    customers.first_name,
    customers.last_name
FROM purchases
    JOIN customers ON purchases.customer_id = customers.customer_id
    JOIN items ON purchases.item_id = items.item_id
WHERE NOT (
        customers.first_name = 'Scott'
        AND customers.last_name = 'Scott'
    );