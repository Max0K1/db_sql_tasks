--Частина 1: Запити на вибірку даних (SELECT)
--1. Отримання списку фільмів та їх категорій:
SELECT f.title AS "Назва фільму", 
       f.length AS "Тривалість (хвилин)", 
       c.name AS "Категорія"
FROM film f
JOIN film_category fc ON f.film_id = fc.film_id
JOIN category c ON fc.category_id = c.category_id;


--2.Фільми, орендовані певним клієнтом:
SELECT c.first_name || ' ' || c.last_name AS "Клієнт", 
       f.title AS "Назва фільму", 
       r.rental_period AS "Період оренди"
FROM rental r
JOIN inventory i ON r.inventory_id = i.inventory_id
JOIN film f ON i.film_id = f.film_id
JOIN customer c ON r.customer_id = c.customer_id
WHERE c.customer_id = 1
ORDER BY r.rental_period;
 

--3.Популярність фільмів:
SELECT f.title AS "Назва фільму", 
       COUNT(r.rental_id) AS "Кількість оренд"
FROM rental r
JOIN inventory i ON r.inventory_id = i.inventory_id
JOIN film f ON i.film_id = f.film_id
GROUP BY f.title
ORDER BY "Кількість оренд" DESC
LIMIT 5;


--Частина 2: Маніпуляції з даними (INSERT, UPDATE, DELETE)
--1.Додавання нового клієнта: 
INSERT INTO city (city, country_id, last_update)
VALUES ('San Francisco', 103, NOW())

SELECT city_id 
FROM city 
WHERE city = 'San Francisco';

INSERT INTO address (address, city_id, district, postal_code, phone, last_update)
VALUES ('123 Main St', 601, 'Central', '94101', '555-1234', NOW())
RETURNING address_id;

INSERT INTO customer (store_id, first_name, last_name, email, address_id, create_date, last_update)
VALUES (1, 'Alice', 'Cooper', 'alice.cooper@example.com', 610, NOW(), NOW())
RETURNING customer_id;


--2.Оновлення адреси клієнта
--Знайти address_id клієнта "Alice Cooper"
SELECT a.address_id
FROM customer c
JOIN address a ON c.address_id = a.address_id
WHERE c.first_name = 'Alice' AND c.last_name = 'Cooper';


UPDATE address
SET address = '456 Elm St', last_update = NOW()
WHERE address_id = 610;


--3.Видалення клієнта
SELECT customer_id, first_name, last_name, email 
FROM customer 
WHERE first_name = 'Alice' AND last_name = 'Cooper';

DELETE FROM customer 
WHERE customer_id = 609; 
