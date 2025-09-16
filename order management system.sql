CREATE DATABASE ORDERS_MANAGEMENT_SYSTEM;
use ORDERS_MANAGEMENT_SYSTEM;

CREATE TABLE customers (
    customer_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE,
    phone VARCHAR(15),
    city VARCHAR(50)
);

INSERT INTO customers (customer_name, email, phone, city) VALUES
('Rohan Mehta', 'rohan@gmail.com', '9876543210', 'Mumbai'),
('Ananya Sharma', 'ananya@gmail.com', '9123456780', 'Delhi'),
('Amit Verma', 'amit@gmail.com', '9988776655', 'Bangalore'),
('Priya Singh', 'priya@gmail.com', '9876123450', 'Chennai'),
('Karan Gupta', 'karan@gmail.com', '9765432109', 'Pune');

CREATE TABLE restaurants (
    restaurant_id INT PRIMARY KEY AUTO_INCREMENT,
    restaurant_name VARCHAR(100) NOT NULL,
    city VARCHAR(50),
    cuisine_type VARCHAR(50)
);

INSERT INTO restaurants (restaurant_name, city, cuisine_type) VALUES
('Spice Hub', 'Mumbai', 'Indian'),
('Dragon Wok', 'Delhi', 'Chinese'),
('Pizza Mania', 'Bangalore', 'Italian'),
('Tandoori Tales', 'Chennai', 'North Indian'),
('Burger World', 'Pune', 'Fast Food');

CREATE TABLE menu_items (
    menu_item_id INT PRIMARY KEY AUTO_INCREMENT,
    restaurant_id INT,
    item_name VARCHAR(100) NOT NULL,
    price DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (restaurant_id) REFERENCES restaurants(restaurant_id)
        ON DELETE CASCADE
);

INSERT INTO menu_items (restaurant_id, item_name, price) VALUES
(1, 'Paneer Butter Masala', 250.00),
(1, 'Chicken Biryani', 300.00),
(2, 'Veg Hakka Noodles', 180.00),
(2, 'Chilli Chicken', 220.00),
(3, 'Margherita Pizza', 350.00),
(3, 'Pepperoni Pizza', 450.00),
(4, 'Butter Naan', 50.00),
(4, 'Tandoori Chicken', 400.00),
(5, 'Veg Burger', 120.00),
(5, 'Cheese Burger', 150.00);

CREATE TABLE delivery_agent (
    delivery_agent_id INT PRIMARY KEY AUTO_INCREMENT,
    agent_name VARCHAR(100) NOT NULL,
    phone VARCHAR(15),
    vehicle_type VARCHAR(50),
    city VARCHAR(50)
);

INSERT INTO delivery_agent (agent_name, phone, vehicle_type, city) VALUES
('Suresh Kumar', '9871112233', 'Bike', 'Mumbai'),
('Ravi Yadav', '9872223344', 'Scooter', 'Delhi'),
('Arun Nair', '9873334455', 'Bike', 'Bangalore'),
('Vikram Iyer', '9874445566', 'Car', 'Chennai'),
('Mohit Jain', '9875556677', 'Scooter', 'Pune');

CREATE TABLE payments (
    payment_id INT PRIMARY KEY AUTO_INCREMENT,
    method VARCHAR(50),  -- e.g., UPI, Credit Card, COD
    status VARCHAR(20),  -- Completed, Pending, Failed
    amount DECIMAL(10,2) NOT NULL
);

INSERT INTO payments (method, status, amount) VALUES
('UPI', 'Completed', 250.00),
('Credit Card', 'Completed', 300.00),
('Cash on Delivery', 'Pending', 180.00),
('Debit Card', 'Completed', 220.00),
('UPI', 'Completed', 350.00),
('Wallet', 'Failed', 450.00),
('Credit Card', 'Completed', 50.00),
('UPI', 'Completed', 400.00),
('Cash on Delivery', 'Pending', 120.00),
('Debit Card', 'Completed', 150.00);

-- 6. Orders Table
CREATE TABLE orders (
    order_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT,
    restaurant_id INT,
    menu_item_id INT,
    delivery_agent_id INT,
    payment_id INT,
    quantity INT DEFAULT 1,
    total_amount DECIMAL(10,2),
    order_date DATETIME DEFAULT CURRENT_TIMESTAMP,

    FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
    FOREIGN KEY (restaurant_id) REFERENCES restaurants(restaurant_id),
    FOREIGN KEY (menu_item_id) REFERENCES menu_items(menu_item_id),
    FOREIGN KEY (delivery_agent_id) REFERENCES delivery_agent(delivery_agent_id),
    FOREIGN KEY (payment_id) REFERENCES payments(payment_id)
);

INSERT INTO orders (customer_id, restaurant_id, menu_item_id, delivery_agent_id, payment_id, quantity, total_amount) VALUES
(1, 1, 1, 1, 1, 1, 250.00),
(2, 1, 2, 2, 2, 1, 300.00),
(3, 2, 3, 3, 3, 2, 360.00),
(4, 2, 4, 4, 4, 1, 220.00),
(5, 3, 5, 5, 5, 1, 350.00),
(1, 3, 6, 1, 6, 1, 450.00),
(2, 4, 7, 2, 7, 4, 200.00),
(3, 4, 8, 3, 8, 1, 400.00),
(4, 5, 9, 4, 9, 2, 240.00),
(5, 5, 10, 5, 10, 1, 150.00),
(1, 1, 2, 1, 2, 2, 600.00),
(2, 2, 3, 2, 3, 1, 180.00),
(3, 3, 5, 3, 5, 2, 700.00),
(4, 4, 7, 4, 7, 3, 150.00),
(5, 5, 9, 5, 9, 5, 600.00),
(1, 2, 4, 1, 4, 2, 440.00),
(2, 3, 6, 2, 6, 1, 450.00),
(3, 4, 8, 3, 8, 2, 800.00),
(4, 5, 10, 4, 10, 2, 300.00),
(5, 1, 1, 5, 1, 3, 750.00);