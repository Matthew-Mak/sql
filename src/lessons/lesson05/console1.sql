-- 1
SELECT
    id,
    name,
    position,
    salary
FROM employees
WHERE salary > (SELECT AVG(salary) FROM employees WHERE salary IS NOT NULL);

-- 2
SELECT
    id,
    name,
    price
FROM products
WHERE price > (SELECT AVG(price) FROM products WHERE price IS NOT NULL);

-- 3
SELECT
    d.id,
    d.name,
    d.location
FROM departments d
WHERE EXISTS (
    SELECT 1
    FROM employees e
    WHERE e.department_id = d.id
      AND e.salary > 10000
);

-- 4
SELECT
    p.id,
    p.name,
    (SELECT COUNT(*)
     FROM order_items oi
     WHERE oi.product_id = p.id) AS order_count
FROM products p
WHERE (SELECT COUNT(*)
       FROM order_items oi
       WHERE oi.product_id = p.id) = (
          SELECT MAX(product_count)
          FROM (
                   SELECT COUNT(*) AS product_count
                   FROM order_items
                   GROUP BY product_id
               ) AS counts
      );

-- 5
SELECT
    c.id,
    c.name,
    c.city,
    (SELECT COUNT(*)
     FROM orders o
     WHERE o.customer_id = c.id) AS order_count
FROM customers c;

-- 6
SELECT
    d.id,
    d.name,
    (SELECT AVG(salary)
     FROM employees e
     WHERE e.department_id = d.id) AS avg_salary
FROM departments d
WHERE (SELECT COUNT(*)
       FROM employees e
       WHERE e.department_id = d.id) > 0
ORDER BY avg_salary DESC NULLS LAST
LIMIT 3;

-- 7
SELECT
    c.id,
    c.name,
    c.city
FROM customers c
WHERE NOT EXISTS (
    SELECT 1
    FROM orders o
    WHERE o.customer_id = c.id
);

-- 8
SELECT
    e.id,
    e.name,
    e.position,
    e.salary
FROM employees e
WHERE e.salary > (
    SELECT MAX(salary)
    FROM employees
    WHERE position = 'Manager'
      AND salary IS NOT NULL
);

-- 9
SELECT
    d.id,
    d.name,
    d.location
FROM departments d
WHERE EXISTS (
    SELECT 1
    FROM employees e
    WHERE e.department_id = d.id
)
  AND NOT EXISTS (
    SELECT 1
    FROM employees e
    WHERE e.department_id = d.id
      AND (e.salary <= 5000 OR e.salary IS NULL)
);