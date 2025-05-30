use sakila;
# 1. Display 10 rows of customer id, rental id, amount, and payment date data in the payment table!
SELECT customer_id, rental_id, amount, payment_date
FROM payment
LIMIT 10;

# 2. From the “film” table, display 10 film titles, release years, and rental durations where the film titles displayed start with the letter “S”!
SELECT title, release_year, rental_duration
FROM film
WHERE title LIKE 'S%'
ORDER BY title
LIMIT 10;

# 3. From the “film” table, display the rental duration, the number of films for each rental duration, and the average film duration!
# Group the number of films and the average film duration based on the rental duration!
# Because the average film duration is a decimal, round it to 2 digits after the decimal point!
SELECT rental_duration, 
       COUNT(rental_duration) AS film_count, 
       ROUND(AVG(length), 2) AS avg_film_duration
FROM film
GROUP BY rental_duration;

# 4. From the film table, display the title, film duration, and also the rating whose film duration is more than the average total film duration!
SELECT title, length, rating
FROM film
WHERE length > (SELECT AVG(length) FROM film)
ORDER BY length DESC
LIMIT 25;

# 5. From the “film” table, display the rating, Highest Replacement Cost, Lowest Rental Rate, and Average Duration and group them based on the film rating!
SELECT rating,
       MAX(replacement_cost) AS replacement_cost_highest,
       MIN(rental_rate) AS rental_rate_lowest,
       ROUND(AVG(length), 2) AS average_duration
FROM film
GROUP BY rating;

# 6. Display 15 lists of movies that have the letter "K" at the end of the title, then display the title, duration, and language of the movie! 
# do a join first from the "film" table and the "language" table!
SELECT f.title, f.length AS duration, l.name AS language
FROM film f
JOIN language l ON f.language_id = l.language_id
WHERE f.title LIKE '%K'
LIMIT 15;

# 7. Display the Movie Title (from the "film" table), First Name (from the "actor" table), and Last Name (From the "actor" table) of actors who have "actor_id" = 14!
# As a note, do a join table first between the "film", "film_actor", and "actor" tables!
SELECT f.title AS Film_title, a.first_name AS First_Name, a.last_name AS Last_Name
FROM film f
JOIN film_actor fa ON f.film_id = fa.film_id
JOIN actor a ON fa.actor_id = a.actor_id
WHERE a.actor_id = 14;

# 8. From the "city" table, display the city and country id!
# Display only cities whose names have the letter "d" in any position and end with the letter "a"!
# Display 15 data sorted by city in ascending order!
SELECT city, country_id
FROM city
WHERE city LIKE '%d%' AND city LIKE '%a'
ORDER BY city ASC
LIMIT 15;

# 9. Display the genre name (name from the "category" table) and the number of films in each genre!
# First join the “film”, “film_category”, and “category” tables!
# Sort by the number of films in each category in ascending order!
SELECT cat.name AS genre, COUNT(f.film_id) AS amount_film
FROM film f
JOIN film_category fc ON f.film_id = fc.film_id
JOIN category cat ON fc.category_id = cat.category_id
GROUP BY cat.name
ORDER BY amount_film ASC;

# 10. From the “film” table, display the title, description, length, and rating!
# Display 10 film titles that end with the letter ‘h’ and have a duration above the average duration!
# Sort by title in ascending order!
SELECT title, description, length, rating
FROM film
WHERE LOWER(title) LIKE '%h'
  AND length > (SELECT AVG(length) FROM film)
ORDER BY title ASC
LIMIT 10;