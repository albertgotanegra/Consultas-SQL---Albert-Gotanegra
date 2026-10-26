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

-- 26. Promedio, desviación estándar y varianza del total pagado.
SELECT AVG(amount) AS promedio,
       STDDEV(amount) AS desviacion_estandar,
       VARIANCE(amount) AS varianza
FROM payment;

-- 27. Películas que se alquilan por encima del precio medio.
SELECT title, rental_rate
FROM film
WHERE rental_rate > (SELECT AVG(rental_rate) FROM film);

-- 28. Id de actores que han participado en más de 40 películas.
SELECT actor_id
FROM film_actor
GROUP BY actor_id
HAVING COUNT(*) > 40;

-- 29. Todas las películas y, si están en inventario, la cantidad.
SELECT f.title, COUNT(i.inventory_id) AS cantidad_en_inventario
FROM film f
LEFT JOIN inventory i ON i.film_id = f.film_id
GROUP BY f.title;

-- 30. Actores y número de películas en las que han actuado.
SELECT a.actor_id, a.first_name, a.last_name, COUNT(fa.film_id) AS num_peliculas
FROM actor a
JOIN film_actor fa ON fa.actor_id = a.actor_id
GROUP BY a.actor_id, a.first_name, a.last_name;

-- 31. Todas las películas y los actores que han actuado en ellas, incluso películas sin actores asociados.
SELECT f.title, a.first_name, a.last_name
FROM film f
LEFT JOIN film_actor fa ON fa.film_id = f.film_id
LEFT JOIN actor a ON a.actor_id = fa.actor_id;

-- 32. Todos los actores y las películas en las que han actuado, incluso actores sin ninguna película.
SELECT a.first_name, a.last_name, f.title
FROM actor a
LEFT JOIN film_actor fa ON fa.actor_id = a.actor_id
LEFT JOIN film f ON f.film_id = fa.film_id;

-- 33. Todas las películas y todos los registros de alquiler.
SELECT f.title, r.rental_id, r.rental_date
FROM film f
FULL OUTER JOIN inventory i ON i.film_id = f.film_id
FULL OUTER JOIN rental r ON r.inventory_id = i.inventory_id;

-- 34. Los 5 clientes que más dinero se han gastado.
SELECT c.customer_id, c.first_name, c.last_name, SUM(p.amount) AS total_gastado
FROM customer c
JOIN payment p ON p.customer_id = c.customer_id
GROUP BY c.customer_id, c.first_name, c.last_name
ORDER BY total_gastado DESC
LIMIT 5;

-- 35. Actores cuyo primer nombre es 'Johnny'.
SELECT *
FROM actor
WHERE first_name = 'Johnny';

-- 36. Renombra la columna "first_name" como Nombre y "last_name" como Apellido.
SELECT first_name AS "Nombre", last_name AS "Apellido"
FROM actor;

-- 37. ID del actor más bajo y más alto.
SELECT MIN(actor_id) AS id_minimo, MAX(actor_id) AS id_maximo
FROM actor;

-- 38. Cuántos actores hay en la tabla "actor".
SELECT COUNT(*) AS total_actores
FROM actor;

-- 39. Todos los actores ordenados por apellido ascendente.
SELECT *
FROM actor
ORDER BY last_name ASC;

-- 40. Primeras 5 películas de la tabla "film".
SELECT *
FROM film
ORDER BY film_id
LIMIT 5;

-- 41. Actores agrupados por nombre; ¿cuál es el más repetido?
-- En primer lugar sacamos el listado completo:
SELECT first_name, COUNT(*) AS cantidad
FROM actor
GROUP BY first_name
ORDER BY cantidad DESC;
--A continuación el nombre más repetido, en este caso Penelope.
SELECT first_name, COUNT(*) AS cantidad
FROM actor
GROUP BY first_name
ORDER BY cantidad DESC
LIMIT 1;

-- 42. Todos los alquileres y los nombres de los clientes que los hicieron.
SELECT r.rental_id, r.rental_date, c.first_name, c.last_name
FROM rental r
JOIN customer c ON c.customer_id = r.customer_id;

-- 43. Todos los clientes y sus alquileres si existen (incluyendo los que no tienen ninguno).
SELECT c.customer_id, c.first_name, c.last_name, r.rental_id, r.rental_date
FROM customer c
LEFT JOIN rental r ON r.customer_id = c.customer_id;

-- 44. CROSS JOIN entre film y category. ¿Aporta valor? ¿Por qué?
SELECT f.title, c.name
FROM film f
CROSS JOIN category c;
-- Respuesta: No, no aporta valor real. Un CROSS JOIN combina cada fila de "film" con cada fila de "category" sin ninguna condición de
-- relación entre ambas tablas (todas-con-todas), generando num_películas × num_categorías filas que no reflejan la categoría real de cada película. Para saber la categoría real de cada película
-- hace falta un INNER JOIN pasando por la tabla intermedia film_category (como en el ejercicio 19 o 61), que sí respeta la relación real de los datos.

-- 45. Actores que han participado en películas de categoría 'Action'.
SELECT DISTINCT a.first_name, a.last_name
FROM actor a
JOIN film_actor fa ON fa.actor_id = a.actor_id
JOIN film_category fc ON fc.film_id = fa.film_id
JOIN category c ON c.category_id = fc.category_id
WHERE c.name = 'Action';

-- 46. Actores que no han participado en ninguna película.
SELECT a.first_name, a.last_name
FROM actor a
LEFT JOIN film_actor fa ON fa.actor_id = a.actor_id
WHERE fa.film_id IS NULL;

-- 47. Nombre de actores y cantidad de películas en las que han participado.
SELECT a.first_name, a.last_name, COUNT(fa.film_id) AS num_peliculas
FROM actor a
JOIN film_actor fa ON fa.actor_id = a.actor_id
GROUP BY a.actor_id, a.first_name, a.last_name;

-- 48. Vista "actor_num_peliculas" con nombres de actores y número de películas en las que han participado.
CREATE VIEW actor_num_peliculas AS
SELECT a.actor_id, a.first_name, a.last_name, COUNT(fa.film_id) AS num_peliculas
FROM actor a
JOIN film_actor fa ON fa.actor_id = a.actor_id
GROUP BY a.actor_id, a.first_name, a.last_name;

-- 49. Número total de alquileres realizados por cada cliente.
SELECT customer_id, COUNT(*) AS total_alquileres
FROM rental
GROUP BY customer_id;

-- 50. Duración total de las películas en la categoría 'Action'.
SELECT SUM(f.length) AS duracion_total
FROM film f
JOIN film_category fc ON fc.film_id = f.film_id
JOIN category c ON c.category_id = fc.category_id
WHERE c.name = 'Action';

-- 51. Tabla temporal "cliente_rentas_temporal" con el total de alquileres por cliente.
CREATE TEMP TABLE cliente_rentas_temporal AS
SELECT customer_id, COUNT(*) AS total_alquileres
FROM rental
GROUP BY customer_id;

-- 52. Tabla temporal "peliculas_alquiladas" con las películas alquiladas al menos 10 veces.
CREATE TEMP TABLE peliculas_alquiladas AS
SELECT f.film_id, f.title, COUNT(r.rental_id) AS veces_alquilada
FROM film f
JOIN inventory i ON i.film_id = f.film_id
JOIN rental r ON r.inventory_id = i.inventory_id
GROUP BY f.film_id, f.title
HAVING COUNT(r.rental_id) >= 10;

-- 53. Título de películas alquiladas por 'Tammy Sanders' y aún no devueltas, ordenadas alfabéticamente.
SELECT f.title
FROM film f
JOIN inventory i ON i.film_id = f.film_id
JOIN rental r ON r.inventory_id = i.inventory_id
JOIN customer c ON c.customer_id = r.customer_id
WHERE c.first_name = 'Tammy' AND c.last_name = 'Sanders'
  AND r.return_date IS NULL
ORDER BY f.title;

-- 54. Actores que han actuado en al menos una película de la categoría 'Sci-Fi', ordenados por apellido.
SELECT DISTINCT a.first_name, a.last_name
FROM actor a
JOIN film_actor fa ON fa.actor_id = a.actor_id
JOIN film_category fc ON fc.film_id = fa.film_id
JOIN category c ON c.category_id = fc.category_id
WHERE c.name = 'Sci-Fi'
ORDER BY a.last_name;

-- 55. Actores en películas alquiladas después de que 'Spartacus Cheaper' se alquilara por primera vez, ordenados por apellido.
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

-- 56. Actores que no han actuado en ninguna película de categoría 'Music'.
SELECT a.first_name, a.last_name
FROM actor a
WHERE a.actor_id NOT IN (
    SELECT fa.actor_id
    FROM film_actor fa
    JOIN film_category fc ON fc.film_id = fa.film_id
    JOIN category c ON c.category_id = fc.category_id
    WHERE c.name = 'Music');

-- 57. Título de películas alquiladas por más de 8 días.
SELECT DISTINCT f.title
FROM film f
JOIN inventory i ON i.film_id = f.film_id
JOIN rental r ON r.inventory_id = i.inventory_id
WHERE r.return_date IS NOT NULL
  AND (r.return_date - r.rental_date) > INTERVAL '8 days';

-- 58. Título de películas de la misma categoría que 'Animation'.
SELECT f.title
FROM film f
JOIN film_category fc ON fc.film_id = f.film_id
JOIN category c ON c.category_id = fc.category_id
WHERE c.name = 'Animation';

-- 59. Películas con la misma duración que 'Dancing Fever', ordenadas alfabéticamente (se excluye la propia 'Dancing Fever').
SELECT title
FROM film f
WHERE length = (SELECT length FROM film WHERE title = 'Dancing Fever')
  AND title <> 'Dancing Fever'
ORDER BY title;

-- 60. Clientes que han alquilado al menos 7 películas distintas, ordenados por apellido.
SELECT c.first_name, c.last_name
FROM customer c
JOIN rental r ON r.customer_id = c.customer_id
JOIN inventory i ON i.inventory_id = r.inventory_id
GROUP BY c.customer_id, c.first_name, c.last_name
HAVING COUNT(DISTINCT i.film_id) >= 7
ORDER BY c.last_name;

-- 61. Cantidad total de películas alquiladas por categoría.
SELECT c.name, COUNT(r.rental_id) AS total_alquileres
FROM category c
JOIN film_category fc ON fc.category_id = c.category_id
JOIN film f ON f.film_id = fc.film_id
JOIN inventory i ON i.film_id = f.film_id
JOIN rental r ON r.inventory_id = i.inventory_id
GROUP BY c.name;

-- 62. Número de películas por categoría estrenadas en 2006.
SELECT c.name, COUNT(*) AS num_peliculas
FROM category c
JOIN film_category fc ON fc.category_id = c.category_id
JOIN film f ON f.film_id = fc.film_id
WHERE f.release_year = 2006
GROUP BY c.name;

-- 63. Todas las combinaciones posibles de trabajadores con las tiendas.
SELECT s.first_name, s.last_name, st.store_id
FROM staff s
CROSS JOIN store st;

-- 64. Cantidad total de películas alquiladas por cada cliente, mostrando ID, nombre, apellido y cantidad.
SELECT c.customer_id, c.first_name, c.last_name, COUNT(r.rental_id) AS peliculas_alquiladas
FROM customer c
JOIN rental r ON r.customer_id = c.customer_id
GROUP BY c.customer_id, c.first_name, c.last_name;




