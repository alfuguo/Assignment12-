CREATE DATABASE IF NOT EXISTS pizza_restaurant;
USE pizza_restaurant;


-- Create tables:

CREATE TABLE IF NOT EXISTS `pizza` (
    `pizza_id` INT NOT NULL AUTO_INCREMENT,
    `pizza_name` VARCHAR(100) NULL,
    `pizza_price` DECIMAL(5 , 2 ) NULL,
    PRIMARY KEY (`pizza_id`)
);
CREATE TABLE IF NOT EXISTS `customer` (
    `customer_id` INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    `customer_name` VARCHAR(100) NULL,
    `phone_number` VARCHAR(100) NULL
);
CREATE TABLE IF NOT EXISTS `order` (
    `order_id` INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    `customer_id` INT NOT NULL,
    `order_amount` DECIMAL(5 , 2 ) NULL,
    `order_date` DATETIME NULL,
    FOREIGN KEY (customer_id)
        REFERENCES customer (customer_id)
);

CREATE TABLE IF NOT EXISTS `pizza_order` (
    `order_id` INT NOT NULL,
    `pizza_id` INT NOT NULL,
    `quantity` INT NOT NULL,
    FOREIGN KEY (`order_id`)
        REFERENCES `order` (`order_id`),
    FOREIGN KEY (`pizza_id`)
        REFERENCES `pizza` (`pizza_id`)
);


-- Insert data:
  
INSERT INTO `pizza` (`pizza_name`, `pizza_price`) VALUES ('Pepperoni & Cheese', '7.99');
INSERT INTO `pizza` (`pizza_name`, `pizza_price`) VALUES ('Vegetarian', '9.99');
INSERT INTO `pizza` (`pizza_name`, `pizza_price`) VALUES ('Meat Lovers', '14.99');
INSERT INTO `pizza` (`pizza_name`, `pizza_price`) VALUES ('Hawaiian', '12.99');
SELECT 
    *
FROM
    `pizza`;
    
INSERT INTO `customer` (`customer_name`, `phone_number`) VALUES('Trevor Page', '226-555-4982');
INSERT INTO `customer` (`customer_name`, `phone_number`) VALUES('John Doe', '555-555-9498');
SELECT 
    *
FROM
    `customer`;    

INSERT INTO `order` (`customer_id`, `order_date`) VALUES (1, '2023-09-10 09:47:00');
INSERT INTO `order` (`customer_id`, `order_date`) VALUES(2, '2023-09-10 13:20:00');
INSERT INTO `order` (`customer_id`, `order_date`) VALUES(1, '2023-09-10 09:47:00');
INSERT INTO `order` (`customer_id`, `order_date`) VALUES(2, '2023-10-10 10:37:00');
SELECT 
    *
FROM
    `order`;

INSERT INTO `pizza_order` (`order_id`, `pizza_id`, `quantity`) VALUES (1,1,1);
INSERT INTO `pizza_order` (`order_id`, `pizza_id`, `quantity`) VALUES (1,3,1);
INSERT INTO `pizza_order` (`order_id`, `pizza_id`, `quantity`) VALUES (2,2,1);
INSERT INTO `pizza_order` (`order_id`, `pizza_id`, `quantity`) VALUES (2,3,2);
INSERT INTO `pizza_order` (`order_id`, `pizza_id`, `quantity`) VALUES (3,3,1);
INSERT INTO `pizza_order` (`order_id`, `pizza_id`, `quantity`) VALUES (3,4,1);
INSERT INTO `pizza_order` (`order_id`, `pizza_id`, `quantity`) VALUES (4,2,3);
INSERT INTO `pizza_order` (`order_id`, `pizza_id`, `quantity`) VALUES (4,4,1);
SELECT 
    *
FROM
    `pizza_order`;

-- How much money each individual customer has spent

SELECT 
    c.customer_id,
    c.customer_name,
    SUM(p.pizza_price * po.quantity) AS total_spent
FROM
    `customer` c
        JOIN
    `order` o ON c.customer_id = o.customer_id
        JOIN
    `pizza_order` po ON o.order_id = po.order_id
        JOIN
    `pizza` p ON po.pizza_id = p.pizza_id
GROUP BY c.customer_id , c.customer_name;


-- How much each customer is ordering on which date.

SELECT 
    c.customer_name,
    o.order_date,
    SUM(p.pizza_price * po.quantity) AS total_cost
FROM
    customer c
        JOIN
    `order` o ON c.customer_id = o.customer_id
        JOIN
    pizza_order po ON o.order_id = po.order_id
        JOIN
    pizza p ON po.pizza_id = p.pizza_id
GROUP BY c.customer_name , o.order_date;

