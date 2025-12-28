-- Задание 1
CREATE TABLE customers (
                           id SERIAL PRIMARY KEY,
                           name TEXT NOT NULL,
                           email TEXT UNIQUE NOT NULL
);

CREATE TABLE orders (
                        id SERIAL PRIMARY KEY,
                        amount NUMERIC(10,2) NOT NULL,
                        order_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                        customer_id INT NOT NULL,
                        FOREIGN KEY (customer_id) REFERENCES customers(id)
);


-- Задание 2
CREATE TABLE departments (
                             id SERIAL PRIMARY KEY,
                             name TEXT NOT NULL
);

CREATE TABLE employees (
                           id SERIAL PRIMARY KEY,
                           name TEXT NOT NULL,
                           position TEXT NOT NULL,
                           department_id INT NULL,
                           FOREIGN KEY (department_id) REFERENCES departments(id) ON DELETE SET NULL
);


-- Задане 3
CREATE TABLE categories (
                            id SERIAL PRIMARY KEY,
                            name TEXT NOT NULL
);

CREATE TABLE products (
                          id SERIAL PRIMARY KEY,
                          name TEXT NOT NULL,
                          price NUMERIC(10,2) NOT NULL CHECK (price >= 0),
                          category_id INT NOT NULL,
                          FOREIGN KEY (category_id) REFERENCES categories(id)
);


-- Задание 4
CREATE TABLE customers_shop (
                                id SERIAL PRIMARY KEY,
                                name TEXT NOT NULL,
                                email TEXT UNIQUE NOT NULL
);

CREATE TABLE products_shop (
                               id SERIAL PRIMARY KEY,
                               name TEXT NOT NULL,
                               price NUMERIC(10,2) NOT NULL CHECK (price >= 0)
);

CREATE TABLE orders_shop (
                             id SERIAL PRIMARY KEY,
                             customer_id INT NOT NULL,
                             order_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                             FOREIGN KEY (customer_id) REFERENCES customers_shop(id) ON DELETE CASCADE
);

CREATE TABLE order_items (
                             order_id INT NOT NULL,
                             product_id INT NOT NULL,
                             quantity INT NOT NULL DEFAULT 1 CHECK (quantity > 0),
                             PRIMARY KEY (order_id, product_id),
                             FOREIGN KEY (order_id) REFERENCES orders_shop(id) ON DELETE CASCADE,
                             FOREIGN KEY (product_id) REFERENCES products_shop(id)
);


-- Задание 5
CREATE TABLE faculties (
                           id SERIAL PRIMARY KEY,
                           name TEXT NOT NULL
);

CREATE TABLE groups (
                        id SERIAL PRIMARY KEY,
                        name TEXT NOT NULL,
                        faculty_id INT NOT NULL,
                        FOREIGN KEY (faculty_id) REFERENCES faculties(id)
);

CREATE TABLE students (
                          id SERIAL PRIMARY KEY,
                          name TEXT NOT NULL,
                          group_id INT NOT NULL,
                          FOREIGN KEY (group_id) REFERENCES groups(id)
);

CREATE TABLE teachers (
                          id SERIAL PRIMARY KEY,
                          name TEXT NOT NULL
);

CREATE TABLE courses (
                         id SERIAL PRIMARY KEY,
                         name TEXT NOT NULL,
                         teacher_id INT NOT NULL,
                         FOREIGN KEY (teacher_id) REFERENCES teachers(id)
);

CREATE TABLE student_courses (
                                 student_id INT NOT NULL,
                                 course_id INT NOT NULL,
                                 grade INT CHECK (grade >= 1 AND grade <= 5),
                                 PRIMARY KEY (student_id, course_id),
                                 FOREIGN KEY (student_id) REFERENCES students(id) ON DELETE CASCADE,
                                 FOREIGN KEY (course_id) REFERENCES courses(id) ON DELETE CASCADE
);


-- Задание 6
CREATE TABLE users (
                       id SERIAL PRIMARY KEY,
                       name TEXT NOT NULL,
                       email TEXT UNIQUE NOT NULL,
                       created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE posts (
                       id SERIAL PRIMARY KEY,
                       user_id INT NOT NULL,
                       text TEXT NOT NULL,
                       created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                       FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);

CREATE TABLE comments (
                          id SERIAL PRIMARY KEY,
                          post_id INT NOT NULL,
                          user_id INT NOT NULL,
                          text TEXT NOT NULL,
                          created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                          FOREIGN KEY (post_id) REFERENCES posts(id) ON DELETE CASCADE,
                          FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);

CREATE TABLE likes (
    
                       user_id INT NOT NULL,
                       post_id INT NOT NULL,
                       PRIMARY KEY (user_id, post_id),
                       FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
                       FOREIGN KEY (post_id) REFERENCES posts(id) ON DELETE CASCADE
);