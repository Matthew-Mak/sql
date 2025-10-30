CREATE TABLE sales (
                       id SERIAL PRIMARY KEY,
                       region VARCHAR(20),
                       amount BIGINT,
                       sale_date DATE
);

INSERT INTO sales (region, amount, sale_date) VALUES
                                                  ('North', 1000, '2024-01-01'),
                                                  ('South', 700, '2024-01-02'),
                                                  ('North', 500, '2024-01-03'),
                                                  ('West', NULL, '2024-01-04'),
                                                  ('South', 900, '2024-01-05'),
                                                  ('North', 1500, '2024-01-06');

-- Задание 1
SELECT region, SUM(amount) as total_sales
FROM sales
WHERE amount IS NOT NULL
GROUP BY region
ORDER BY total_sales DESC;

-- ------------------------------------

SELECT region, AVG(amount) as avg_sales, COUNT(*) as sales_count
FROM sales
WHERE amount IS NOT NULL
GROUP BY region
HAVING COUNT(*) > 1
ORDER BY avg_sales DESC;

-- ------------------------------------

SELECT region, SUM(amount) as total_sales
FROM sales
WHERE amount IS NOT NULL
GROUP BY region
ORDER BY total_sales DESC
LIMIT 1;

-- ------------------------------------

SELECT
    COUNT(*) as total_sales,
    COUNT(CASE WHEN amount IS NOT NULL AND amount > 0 THEN 1 END) as non_zero_sales,
    COUNT(CASE WHEN amount IS NULL THEN 1 END) as null_sales
FROM sales;

-- ------------------------------------

WITH avg_all AS (
    SELECT AVG(amount) as avg_amount
    FROM sales
    WHERE amount IS NOT NULL
)
SELECT region, SUM(amount) as total_sales,
       (SELECT avg_amount FROM avg_all) as average_all_regions
FROM sales
WHERE amount IS NOT NULL
GROUP BY region
HAVING SUM(amount) > (SELECT avg_amount FROM avg_all)
ORDER BY total_sales DESC;

