--1.Загальна кількість фільмів у кожній категорії.
SELECT
    c.name AS category_name,
    COUNT(f.film_id) AS film_count
FROM
    category c
JOIN
    film_category fc ON c.category_id = fc.category_id
JOIN
    film f ON fc.film_id = f.film_id
GROUP BY
    c.name
ORDER BY
    film_count DESC;


--2.Середня тривалість фільмів у кожній категорії.
SELECT
    c.name AS category_name,
    AVG(f.length) AS avg_film_length
FROM
    category c
JOIN
    film_category fc ON c.category_id = fc.category_id
JOIN
    film f ON fc.film_id = f.film_id
GROUP BY
    c.name
ORDER BY
    avg_film_length DESC;


--3.Мінімальна та максимальна тривалість фільмів.
SELECT
    MIN(length) AS min_film_length,
    MAX(length) AS max_film_length
FROM
    film;


--4.Загальна кількість клієнтів.
SELECT
    COUNT(customer_id) AS total_customers
FROM
    customer;


--5.Сума платежів по кожному клієнту.
SELECT
    c.first_name || ' ' || c.last_name AS customer_name,
    SUM(p.amount) AS total_payments
FROM
    customer c
JOIN
    payment p ON c.customer_id = p.customer_id
GROUP BY
    customer_name
ORDER BY
    total_payments DESC;


--6.П'ять клієнтів з найбільшою сумою платежів.
SELECT
    c.first_name || ' ' || c.last_name AS customer_name,
    SUM(p.amount) AS total_payments
FROM
    customer c
JOIN
    payment p ON c.customer_id = p.customer_id
GROUP BY
    customer_name
ORDER BY
    total_payments DESC
LIMIT 5;


--7.Загальна кількість орендованих фільмів кожним клієнтом.
SELECT
    c.first_name || ' ' || c.last_name AS customer_name,
    COUNT(r.rental_id) AS total_rentals
FROM
    customer c
JOIN
    rental r ON c.customer_id = r.customer_id
GROUP BY
    customer_name
ORDER BY
    total_rentals DESC;


--8.Середній вік фільмів у базі даних.
SELECT
    AVG(EXTRACT(YEAR FROM CURRENT_DATE) - f.release_year) AS avg_film_age
FROM
    film f;


--9.Кількість фільмів, орендованих за певний період.
SELECT
    COUNT(DISTINCT r.rental_id) AS total_unique_rentals
FROM
    rental r
WHERE
    r.rental_period && tsrange('2005-05-25', '2005-06-10');


--10.Сума платежів по кожному місяцю.
SELECT
    DATE_TRUNC('month', p.payment_date) AS payment_month,
    SUM(p.amount) AS total_payments
FROM
    payment p
GROUP BY
    payment_month
ORDER BY
    payment_month;


--11.Максимальна сума платежу, здійснена клієнтом.
SELECT
    p.customer_id,
    MAX(p.amount) AS max_payment
FROM
    payment p
GROUP BY
    p.customer_id
ORDER BY
    p.customer_id;


--12.Середня сума платежів для кожного клієнта.
SELECT
    c.first_name,
    c.last_name,
    AVG(p.amount) AS average_payment
FROM
    customer c
LEFT JOIN
    payment p ON c.customer_id = p.customer_id
GROUP BY
    c.customer_id
ORDER BY
    c.first_name, c.last_name;


--13.Кількість фільмів у кожному рейтингу (rating).
SELECT
    f.rating,
    COUNT(*) AS film_count
FROM
    film f
GROUP BY
    f.rating
ORDER BY
    f.rating;


--14.Середня сума платежів по кожному магазину (store).
SELECT
    store_id,
    AVG(p.amount) AS average_payment
FROM
    store
LEFT JOIN
    payment p ON store_id = store_id
GROUP BY
    store_id
ORDER BY
    store_id;