-- 1NF, 2NF, 3NF: Больше нету повторяющихся групп, нету транзитивных зависимостей
-- И отдельная таблица для регионов устраняет дублирование данных о регионах
CREATE TABLE regions (
                         id SERIAL PRIMARY KEY,
                         name TEXT NOT NULL UNIQUE
);

-- 1NF, 2NF, 3NF: Города связаны с регионами через FOREIGN KEY
-- Устраняет транзитивную зависимость городов и регионов
CREATE TABLE cities (
                        id SERIAL PRIMARY KEY,
                        name TEXT NOT NULL,
                        region_id INT NOT NULL,
                        FOREIGN KEY (region_id) REFERENCES regions(id)
);

-- 1NF, 2NF, 3NF: Клиенты ссылаются на Ттаблицу городов, а не хранят регион напрямую
-- Устраняет транзитивную зависимость и дублирование географических данных
CREATE TABLE customers (
                           id SERIAL PRIMARY KEY,
                           name TEXT NOT NULL,
                           city_id INT NOT NULL,
                           FOREIGN KEY (city_id) REFERENCES cities(id)
);

-- 1NF, 2NF, 3NF: Продукты вынесены в отдельную таблицу
-- Устраняет дублирование информации о продуктах в заказах
CREATE TABLE products (
                          id SERIAL PRIMARY KEY,
                          name TEXT NOT NULL,
                          price NUMERIC(10,2) NOT NULL
);

-- 1NF, 2NF, 3NF: Заказы связаны с клиентами через  FOREIGN KEY
-- Устраняет дублирование данных клиента (имя, email) в каждом заказе
CREATE TABLE orders (
                        id SERIAL PRIMARY KEY,
                        customer_id INT NOT NULL,
                        order_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                        FOREIGN KEY (customer_id) REFERENCES customers(id)
);

-- 1NF, 2NF: Здесь я мог ошибиться, указал PRIMARY KEY, удалил product_name
-- Так как его зависимость от product_id нарушала 2NF, далее добавил
-- many-to-many связь между продуктами
CREATE TABLE order_items (
                             order_id INT,
                             product_id INT,
                             quantity INT NOT NULL DEFAULT 1,
                             PRIMARY KEY (order_id, product_id),
                             FOREIGN KEY (order_id) REFERENCES orders(id) ON DELETE CASCADE,
                             FOREIGN KEY (product_id) REFERENCES products(id)
);