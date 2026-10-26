-- 1. Crea el esquema de la BBDD.
-- Esto ya está resuelto por el propio script que se nos dió: al ejecutarlo entero (CREATE TABLE + INSERT de cada tabla) es
-- literalmente "crear el esquema".

-- 2. Muestra los nombres de todas las películas con clasificación 'R'.
select title from film where rating = 'R' limit 5;

-- 3. Nombres de los actores con actor_id entre 30 y 40.
select first_name, last_name from actor where actor_id between 30 and 40;  

-- 4. Películas cuyo idioma coincide con el idioma original.
select * from film where language_id = original_language_id;

-- 5. Ordena las películas por duración de forma ascendente.
select title, length from film order by length asc;

-- 6. Nombre y apellido de actores con 'Allen' en el apellido.
select first_name, last_name from actor where last_name like 'Allen';

-- 7. Cantidad total de películas por clasificación.
select rating, count(*) as total from film group by rating;

-- 8. Título de películas 'PG-13' o con duración mayor a 3 horas.
select title FROM film WHERE rating = 'PG-13' OR length > 180;

-- 9. Variabilidad del coste de reemplazo de las películas.
SELECT VARIANCE(replacement_cost) AS varianza_replacement_cost FROM film;

-- 10. Mayor y menor duración de una película.
SELECT MAX(length) AS duracion_maxima, MIN(length) AS duracion_minima FROM film;

-- 11. Coste del antepenúltimo alquiler, ordenado por día.
SELECT p.amount FROM rental r JOIN payment p ON p.rental_id = r.rental_id ORDER BY r.rental_date desc OFFSET 2 LIMIT 1;

-- 12. Título de películas que no sean ni 'NC-17' ni 'G'.
SELECT title FROM film WHERE rating NOT IN ('NC-17', 'G');

-- 13. Promedio de duración por clasificación.
SELECT rating, AVG(length) AS promedio_duracion FROM film GROUP BY rating;

-- 14. Título de películas con duración mayor a 180 minutos.
SELECT title FROM film WHERE length > 180;

-- 15. Dinero total generado por la empresa.
SELECT SUM(amount) AS total_generado FROM payment;

-- 16. Los 10 clientes con mayor valor de id.
SELECT * FROM customer ORDER BY customer_id desc LIMIT 10;

-- 17. Nombre y apellido de actores en la película 'Egg Igby'.
SELECT a.first_name, a.last_name FROM actor a JOIN film_actor fa ON fa.actor_id = a.actor_id JOIN film f ON f.film_id = fa.film_id WHERE f.title = 'Egg Igby';

-- 18. Nombres de películas únicos.
SELECT DISTINCT title FROM film;

-- 19. Título de películas de comedia con duración > 180 min.
SELECT f.title FROM film f JOIN film_category fc ON fc.film_id = f.film_id JOIN category c ON c.category_id = fc.category_id WHERE c.name = 'Comedy' AND f.length > 180;

-- 20. Categorías con promedio de duración > 110 min.
SELECT c.name, AVG(f.length) AS promedio_duracion
FROM category c
JOIN film_category fc ON fc.category_id = c.category_id
JOIN film f ON f.film_id = fc.film_id
GROUP BY c.name
HAVING AVG(f.length) > 110;

-- 21. Media de duración del alquiler de las películas.
SELECT AVG(rental_duration) AS media_duracion_alquiler FROM film;

-- 22. Columna con nombre y apellido de todos los actores/actrices.
SELECT first_name || ' ' || last_name AS nombre_completo FROM actor;

-- 23. Número de alquileres por día, ordenados descendente.
SELECT rental_date::date AS dia, COUNT(*) AS num_alquileres
FROM rental
GROUP BY rental_date::date
ORDER BY num_alquileres DESC;

-- 24. Películas con duración superior al promedio.
SELECT title, length
FROM film
WHERE length > (SELECT AVG(length) FROM film);

-- 25. Número de alquileres registrados por mes.
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

SELECT f.title, a.first_name, a.last_name
FROM film f
LEFT JOIN film_actor fa ON fa.film_id = f.film_id
LEFT JOIN actor a ON a.actor_id = fa.actor_id;

SELECT a.first_name, a.last_name, f.title
FROM actor a
LEFT JOIN film_actor fa ON fa.actor_id = a.actor_id
LEFT JOIN film f ON f.film_id = fa.film_id;

SELECT f.title, r.rental_id, r.rental_date
FROM film f
FULL OUTER JOIN inventory i ON i.film_id = f.film_id
FULL OUTER JOIN rental r ON r.inventory_id = i.inventory_id;

SELECT c.customer_id, c.first_name, c.last_name, SUM(p.amount) AS total_gastado
FROM customer c
JOIN payment p ON p.customer_id = c.customer_id
GROUP BY c.customer_id, c.first_name, c.last_name
ORDER BY total_gastado DESC
LIMIT 5;

SELECT *
FROM actor
WHERE first_name = 'Johnny';

SELECT first_name AS "Nombre", last_name AS "Apellido"
FROM actor;

SELECT MIN(actor_id) AS id_minimo, MAX(actor_id) AS id_maximo
FROM actor;

SELECT COUNT(*) AS total_actores
FROM actor;

SELECT *
FROM actor
ORDER BY last_name ASC;

SELECT *
FROM film
ORDER BY film_id
LIMIT 5;

SELECT first_name, COUNT(*) AS cantidad
FROM actor
GROUP BY first_name
ORDER BY cantidad DESC;

SELECT first_name, COUNT(*) AS cantidad
FROM actor
GROUP BY first_name
ORDER BY cantidad DESC
LIMIT 1;

SELECT r.rental_id, r.rental_date, c.first_name, c.last_name
FROM rental r
JOIN customer c ON c.customer_id = r.customer_id;

SELECT c.customer_id, c.first_name, c.last_name, r.rental_id, r.rental_date
FROM customer c
LEFT JOIN rental r ON r.customer_id = c.customer_id;

SELECT f.title, c.name
FROM film f
CROSS JOIN category c;
-- Respuesta: No, no aporta valor real. Un CROSS JOIN combina cada fila de "film" con cada fila de "category" sin ninguna condición de
-- relación entre ambas tablas (todas-con-todas), generando num_películas × num_categorías filas que no reflejan la categoría real de cada película. Para saber la categoría real de cada película
-- hace falta un INNER JOIN pasando por la tabla intermedia film_category (como en el ejercicio 19 o 61), que sí respeta la relación real de los datos.

FROM actor a
JOIN film_actor fa ON fa.actor_id = a.actor_id
JOIN film_category fc ON fc.film_id = fa.film_id
JOIN category c ON c.category_id = fc.category_id
WHERE c.name = 'Action';


SELECT a.first_name, a.last_name
FROM actor a
LEFT JOIN film_actor fa ON fa.actor_id = a.actor_id
WHERE fa.film_id IS NULL;

SELECT a.first_name, a.last_name, COUNT(fa.film_id) AS num_peliculas
FROM actor a
JOIN film_actor fa ON fa.actor_id = a.actor_id
GROUP BY a.actor_id, a.first_name, a.last_name;

CREATE VIEW actor_num_peliculas AS
SELECT a.actor_id, a.first_name, a.last_name, COUNT(fa.film_id) AS num_peliculas
FROM actor a
JOIN film_actor fa ON fa.actor_id = a.actor_id
GROUP BY a.actor_id, a.first_name, a.last_name;

SELECT customer_id, COUNT(*) AS total_alquileres
FROM rental
GROUP BY customer_id;

SELECT SUM(f.length) AS duracion_total
FROM film f
JOIN film_category fc ON fc.film_id = f.film_id
JOIN category c ON c.category_id = fc.category_id
WHERE c.name = 'Action';

CREATE TEMP TABLE cliente_rentas_temporal AS
SELECT customer_id, COUNT(*) AS total_alquileres
FROM rental
GROUP BY customer_id;

CREATE TEMP TABLE peliculas_alquiladas AS
SELECT f.film_id, f.title, COUNT(r.rental_id) AS veces_alquilada
FROM film f
JOIN inventory i ON i.film_id = f.film_id
JOIN rental r ON r.inventory_id = i.inventory_id
GROUP BY f.film_id, f.title
HAVING COUNT(r.rental_id) >= 10;

SELECT f.title
FROM film f
JOIN inventory i ON i.film_id = f.film_id
JOIN rental r ON r.inventory_id = i.inventory_id
JOIN customer c ON c.customer_id = r.customer_id
WHERE c.first_name = 'Tammy' AND c.last_name = 'Sanders'
  AND r.return_date IS NULL
ORDER BY f.title;

SELECT DISTINCT a.first_name, a.last_name
FROM actor a
JOIN film_actor fa ON fa.actor_id = a.actor_id
JOIN film_category fc ON fc.film_id = fa.film_id
JOIN category c ON c.category_id = fc.category_id
WHERE c.name = 'Sci-Fi'
ORDER BY a.last_name;

SELECT DISTINCT a.first_name, a.last_name
FROM actor a
JOIN film_actor fa ON fa.actor_id = a.actor_id
JOIN film f ON f.film_id = fa.film_id
JOIN inventory i ON i.film_id = f.film_id
JOIN rental r ON r.inventory_id = i.inventory_id
WHERE r.rental_date > (
    SELECT MIN(r2.rental_date)
    FROM rental r2
    JOIN inventory i2 ON i2.inventory_id = r2.inventory_id
    JOIN film f2 ON f2.film_id = i2.film_id
    WHERE f2.title = 'Spartacus Cheaper'
)
ORDER BY a.last_name;

SELECT a.first_name, a.last_name
FROM actor a
WHERE a.actor_id NOT IN (
    SELECT fa.actor_id
    FROM film_actor fa
    JOIN film_category fc ON fc.film_id = fa.film_id
    JOIN category c ON c.category_id = fc.category_id
    WHERE c.name = 'Music');

SELECT DISTINCT f.title
FROM film f
JOIN inventory i ON i.film_id = f.film_id
JOIN rental r ON r.inventory_id = i.inventory_id
WHERE r.return_date IS NOT NULL
  AND (r.return_date - r.rental_date) > INTERVAL '8 days';

SELECT f.title
FROM film f
JOIN film_category fc ON fc.film_id = f.film_id
JOIN category c ON c.category_id = fc.category_id
WHERE c.name = 'Animation';

SELECT title
FROM film
WHERE length = (SELECT length FROM film WHERE title = 'Dancing Fever')
  AND title <> 'Dancing Fever'
ORDER BY title;

SELECT c.first_name, c.last_name
FROM customer c
JOIN rental r ON r.customer_id = c.customer_id
JOIN inventory i ON i.inventory_id = r.inventory_id
GROUP BY c.customer_id, c.first_name, c.last_name
HAVING COUNT(DISTINCT i.film_id) >= 7
ORDER BY c.last_name;

SELECT c.name, COUNT(r.rental_id) AS total_alquileres
FROM category c
JOIN film_category fc ON fc.category_id = c.category_id
JOIN film f ON f.film_id = fc.film_id
JOIN inventory i ON i.film_id = f.film_id
JOIN rental r ON r.inventory_id = i.inventory_id
GROUP BY c.name;

SELECT c.name, COUNT(*) AS num_peliculas
FROM category c
JOIN film_category fc ON fc.category_id = c.category_id
JOIN film f ON f.film_id = fc.film_id
WHERE f.release_year = 2006
GROUP BY c.name;

SELECT s.first_name, s.last_name, st.store_id
FROM staff s
CROSS JOIN store st;

SELECT c.customer_id, c.first_name, c.last_name, COUNT(r.rental_id) AS peliculas_alquiladas
FROM customer c
JOIN rental r ON r.customer_id = c.customer_id
GROUP BY c.customer_id, c.first_name, c.last_name;




