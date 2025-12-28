-- 1
SELECT e.id, e.name,
       COALESCE(d.name, 'No Department') AS department_name
FROM employees e
         LEFT JOIN departments d ON e.department_id = d.id;

-- 2
SELECT e.name AS employee_name, m.name AS manager_name
FROM employees e
         INNER JOIN employees m ON e.manager_id = m.id;

-- 3
SELECT *
FROM departments d
         LEFT JOIN employees e ON d.id = e.department_id
WHERE e.id IS NULL;

-- 4
SELECT o.id AS order_id, o.order_date, o.amount,
       COALESCE(e.name, 'No Employee') AS employee_name,
       COALESCE(c.name, 'No Customer') AS customer_name
FROM orders o
         LEFT JOIN employees e ON o.employee_id = e.id
         LEFT JOIN customers c ON o.customer_id = c.id;

-- 5
SELECT o.id AS order_id, p.name AS product_name, oi.quantity
FROM orders o
         LEFT JOIN order_items oi ON o.id = oi.order_id
         LEFT JOIN products p ON oi.product_id = p.id;

-- 6
SELECT d.id AS department_id, d.name AS department_name,
       o.id AS order_id, o.order_date, o.amount
FROM departments d
         LEFT JOIN employees e ON d.id = e.department_id
         LEFT JOIN orders o ON e.id = o.employee_id;

-- 7
SELECT
    c.id AS customer_id,
    c.name AS customer_name,
    p.id AS product_id,
    p.name AS product_name
FROM customers c
         CROSS JOIN products p
WHERE NOT EXISTS (
    SELECT 1
    FROM orders o
             INNER JOIN order_items oi ON o.id = oi.order_id
    WHERE o.customer_id = c.id
      AND oi.product_id = p.id
);

-- 8
SELECT p.*
FROM products p
         LEFT JOIN order_items oi ON p.id = oi.product_id
WHERE oi.id IS NULL;

-- 9
SELECT
    m.id AS manager_id,
    m.name AS manager_name,
    COALESCE(SUM(o.amount), 0) AS total_orders_amount
FROM employees m
         LEFT JOIN employees e ON m.id = e.manager_id
         LEFT JOIN orders o ON e.id = o.employee_id
GROUP BY m.id, m.name;

-- 10
SELECT
    COUNT(*) AS total_orders,
    COALESCE(SUM(amount), 0) AS total_revenue
FROM orders;

-- 11
SELECT
    d.id AS department_id,
    d.name AS department_name,
    AVG(e.salary) AS avg_salary,
    MAX(e.salary) AS max_salary
FROM departments d
         LEFT JOIN employees e ON d.id = e.department_id
GROUP BY d.id, d.name;

-- 12
SELECT
    o.id AS order_id,
    COALESCE(SUM(oi.quantity), 0) AS total_quantity,
    COUNT(DISTINCT oi.product_id) AS unique_products
FROM orders o
         LEFT JOIN order_items oi ON o.id = oi.order_id
GROUP BY o.id;

-- 13
SELECT
    p.id AS product_id,
    p.name AS product_name,
    SUM(p.price * oi.quantity) AS total_revenue
FROM products p
         INNER JOIN order_items oi ON p.id = oi.product_id
GROUP BY p.id, p.name
ORDER BY total_revenue DESC
LIMIT 3;

-- 14
SELECT COUNT(DISTINCT customer_id) AS customers_with_orders
FROM orders
WHERE customer_id IS NOT NULL;

-- 15
SELECT
    d.id AS department_id,
    d.name AS department_name,
    COUNT(DISTINCT e.id) AS employee_count,
    AVG(e.salary) AS avg_salary,
    COALESCE(SUM(o.amount), 0) AS total_orders_amount
FROM departments d
         LEFT JOIN employees e ON d.id = e.department_id
         LEFT JOIN orders o ON e.id = o.employee_id
GROUP BY d.id, d.name;

-- 16
SELECT
    c.id AS customer_id,
    c.name AS customer_name,
    AVG(o.amount) AS avg_order_amount
FROM customers c
         INNER JOIN orders o ON c.id = o.customer_id
GROUP BY c.id, c.name
HAVING AVG(o.amount) > (SELECT AVG(amount) FROM orders WHERE amount IS NOT NULL);

-- 17
SELECT
    id,
    name AS full_name,
    UPPER(name) AS full_name_upper,
    CONCAT('Mr./Ms. ', name) AS formatted_name
FROM employees;

-- 18
SELECT
    id AS order_id,
    order_date,
    TO_CHAR(order_date, 'DD.MM.YYYY') AS formatted_date,
    -- Если order_date содержит время:
    TO_CHAR(order_date, 'DD.MM.YYYY HH24:MI') AS formatted_datetime
FROM orders;

-- 19
SELECT *
FROM orders
WHERE order_date < CURRENT_DATE - INTERVAL '30 days';

-- 20
SELECT
    id,
    name,
    position,
    salary,
    COALESCE(salary, 0) AS salary_no_null,
    CASE
        WHEN position = 'Manager' THEN COALESCE(salary, 0) * 0.10
        ELSE 0
        END AS bonus,
    COALESCE(salary, 0) +
    CASE
        WHEN position = 'Manager' THEN COALESCE(salary, 0) * 0.10
        ELSE 0
        END AS total_compensation
FROM employees;