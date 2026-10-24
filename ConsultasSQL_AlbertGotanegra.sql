select title from film where rating = 'R' limit 5;

select first_name, last_name from actor where actor_id between 30 and 40;  

select * from film where language_id = original_language_id;

select title, length from film order by length asc;

select first_name, last_name from actor where last_name like 'Allen';

select rating, count(*) as total from film group by rating;

select title FROM film WHERE rating = 'PG-13' OR length > 180;

SELECT VARIANCE(replacement_cost) AS varianza_replacement_cost FROM film;

SELECT MAX(length) AS duracion_maxima, MIN(length) AS duracion_minima FROM film;

SELECT p.amount FROM rental r JOIN payment p ON p.rental_id = r.rental_id ORDER BY r.rental_date desc OFFSET 2 LIMIT 1;

SELECT title FROM film WHERE rating NOT IN ('NC-17', 'G');

SELECT rating, AVG(length) AS promedio_duracion FROM film GROUP BY rating;

SELECT title FROM film WHERE length > 180;

SELECT SUM(amount) AS total_generado FROM payment;

SELECT * FROM customer ORDER BY customer_id desc LIMIT 10;

SELECT a.first_name, a.last_name FROM actor a JOIN film_actor fa ON fa.actor_id = a.actor_id JOIN film f ON f.film_id = fa.film_id WHERE f.title = 'Egg Igby';

SELECT DISTINCT title FROM film;

SELECT f.title FROM film f JOIN film_category fc ON fc.film_id = f.film_id JOIN category c ON c.category_id = fc.category_id WHERE c.name = 'Comedy' AND f.length > 180;

SELECT c.name, AVG(f.length) AS promedio_duracion
FROM category c
JOIN film_category fc ON fc.category_id = c.category_id
JOIN film f ON f.film_id = fc.film_id
GROUP BY c.name
HAVING AVG(f.length) > 110;

SELECT AVG(rental_duration) AS media_duracion_alquiler FROM film;

SELECT AVG(return_date - rental_date) AS media_duracion_real FROM rental WHERE return_date IS NOT NULL;

SELECT first_name || ' ' || last_name AS nombre_completo FROM actor;

SELECT rental_date::date AS dia, COUNT(*) AS num_alquileres
FROM rental
GROUP BY rental_date::date
ORDER BY num_alquileres DESC;

SELECT title, length
FROM film
WHERE length > (SELECT AVG(length) FROM film);

SELECT DATE_TRUNC('month', rental_date) AS mes, COUNT(*) AS num_alquileres
FROM rental
GROUP BY DATE_TRUNC('month', rental_date)
ORDER BY mes;

SELECT AVG(amount) AS promedio,
       STDDEV(amount) AS desviacion_estandar,
       VARIANCE(amount) AS varianza
FROM payment;

SELECT title, rental_rate
FROM film
WHERE rental_rate > (SELECT AVG(rental_rate) FROM film);

SELECT actor_id
FROM film_actor
GROUP BY actor_id
HAVING COUNT(*) > 40;

SELECT f.title, COUNT(i.inventory_id) AS cantidad_en_inventario
FROM film f
LEFT JOIN inventory i ON i.film_id = f.film_id
GROUP BY f.title;

SELECT a.actor_id, a.first_name, a.last_name, COUNT(fa.film_id) AS num_peliculas
FROM actor a
JOIN film_actor fa ON fa.actor_id = a.actor_id
GROUP BY a.actor_id, a.first_name, a.last_name;



