/* Udemy The Complete SQL Bootcamp: Go from Zero to Hero
 */

/* SELECT statement */
SELECT * FROM tableName;
SELECT columnName FROM tableName;
SELECT first_name, last_name FROM tableName;
SELECT first_name, last_name, email FROM customer


/* SELECT DISTINCT */
SELECT DISTINCT (release_year) FROM film;
SELECT DISTINCT (rating, rental_rate) FROM film;


/* COUNT (return the number of rows in a table) */
SELECT COUNT(rating) FROM film;
SELECT COUNT(*) FROM film;
SELECT COUNT(DISTINCT rating) FROM film;
SELECT COUNT(DISTINCT(rental_rate)) FROM film;
SELECT COUNT(DISTINCT(amount)) FROM payment;


/* SELECT WHERE */
SELECT * FROM film WHERE rental_rate > 2.00
SELECT * FROM film WHERE rental_rate > 2.00 AND rental_rate < 3.00
SELECT * FROM customer 
	WHERE last_name = 'Ely';
SELECT * FROM film 
	WHERE rental_rate > 4 
	AND replacement_cost >= 19.99
	AND rating = 'R';
SELECT COUNT(*) FROM film 
	WHERE rental_rate > 4 
	AND replacement_cost >= 19.99
	AND rating = 'R';    
SELECT COUNT(*) FROM film 
	WHERE rating = 'R' 
	OR rating = 'PG'
SELECT COUNT(*) FROM film 
	WHERE rating != 'R' 
SELECT email FROM customer 
    WHERE first_name = 'Nancy'
    AND last_name = 'Thomas';
SELECT description FROM film
	WHERE title = 'Outlaw Hanky';
SELECT phone FROM address
	WHERE address = '259 Ipoh Drive';
SELECT COUNT(title) FROM film
	WHERE length <= 50


/* ORDER BY */
SELECT * FROM film
	ORDER BY title DESC;
SELECT store_id, first_name, last_name 
	FROM customer
	ORDER BY store_id, first_name;
SELECT store_id, first_name, last_name 
	FROM customer
	ORDER BY store_id DESC, first_name ASC   


/* LIMIT (limit the number of rows) */
SELECT store_id, first_name, last_name 
	FROM customer
	ORDER BY store_id, first_name
	LIMIT 10;
SELECT * FROM payment
	WHERE amount >= 7
	ORDER BY rental_id DESC
	LIMIT 15;
SELECT * FROM payment
	LIMIT 1;
SELECT customer_id FROM payment
	ORDER BY payment_date ASC
	LIMIT 10;
SELECT title FROM film
	ORDER BY length ASC
	LIMIT 5;


/* BETWEEN / NOT BETWEEN */
SELECT COUNT(*) FROM payment 
	WHERE amount
	BETWEEN 8 AND 9
SELECT COUNT(*) FROM payment 
	WHERE amount
	NOT BETWEEN 8 AND 9
SELECT * FROM payment 
	WHERE payment_date
	BETWEEN '2007-02-14' AND '2007-02-28'


/* IN (array) / NOT IN */
SELECT * FROM payment 
	WHERE amount IN (0.99, 1.98, 1.99)
	ORDER BY amount
SELECT COUNT(*) FROM payment 
	WHERE amount NOT IN (0.99, 1.98, 1.99);
SELECT * FROM customer 
	WHERE first_name IN ('John', 'Jade', 'Julie');


/* LIKE (case sensitive) and ILIKE (case insensitive) */
SELECT * FROM customer 
	WHERE first_name LIKE 'J%'
SELECT * FROM customer 
	WHERE first_name LIKE 'J%' 
	AND last_name LIKE 'S%'
SELECT * FROM customer 
	WHERE first_name LIKE '%fa%';
SELECT * FROM customer 
	WHERE first_name LIKE '_her%';
SELECT * FROM customer 
	WHERE first_name NOT LIKE '_her%';
SELECT * FROM customer 
	WHERE first_name LIKE 'A%'
	AND last_name NOT LIKE 'B%'
	ORDER BY last_name;


/* General Challenge 1 */
SELECT COUNT(*) FROM payment
	WHERE amount > 5;
SELECT COUNT(*) FROM actor
	WHERE first_name LIKE 'P%';
SELECT COUNT(DISTINCT(district)) FROM address;
SELECT DISTINCT(district) FROM address;
SELECT COUNT(*) FROM film
	WHERE rating = 'R'
	AND replacement_cost
	BETWEEN 5 AND 15;
SELECT COUNT(*) FROM film
	WHERE title
	ILIKE '%truman%';


/* GROUP BY */
SELECT MIN(replacement_cost) FROM film;
SELECT MAX(replacement_cost) FROM film;
SELECT MAX(replacement_cost), 
	ROUND(AVG(replacement_cost), 2)
	FROM film;
SELECT SUM(replacement_cost) FROM film;
SELECT customer_id FROM payment
	GROUP BY customer_id
	ORDER BY customer_id DESC;
SELECT customer_id, SUM(amount) FROM payment
	GROUP BY customer_id
	ORDER BY SUM(amount) DESC;
SELECT customer_id, COUNT(amount) FROM payment
	GROUP BY customer_id
	ORDER BY COUNT(amount) DESC;
SELECT customer_id, staff_id, SUM(amount) 
	FROM payment
	GROUP BY customer_id, staff_id
	ORDER BY customer_id;
SELECT DATE(payment_date), SUM(amount) FROM payment
	GROUP BY DATE(payment_date)
	ORDER BY SUM(amount);
SELECT staff_id, COUNT(amount) FROM payment
	GROUP BY staff_id
	ORDER BY COUNT(amount);
SELECT rating, ROUND(AVG(replacement_cost), 2) 
	FROM film
	GROUP BY rating;
SELECT customer_id, SUM(amount) FROM payment
	GROUP BY customer_id
	ORDER BY SUM(amount) DESC
	LIMIT 5;


/* HAVING */
SELECT customer_id, SUM(amount) FROM payment
	GROUP BY customer_id
	HAVING SUM(amount) > 50
	ORDER BY SUM(amount);
SELECT store_id, COUNT(customer_id) FROM customer
	GROUP BY store_id
	HAVING COUNT(customer_id) > 300;
SELECT customer_id, COUNT(amount) 
	FROM payment
	GROUP BY customer_id
	HAVING COUNT(amount) >= 40;
SELECT customer_id, SUM(amount) 
	FROM payment
	WHERE staff_id = 2
	GROUP BY customer_id
	HAVING SUM(amount) > 100;


/* Assessment test */
SELECT customer_id, SUM(amount) 
	FROM payment
	WHERE staff_id = 2
	GROUP BY customer_id
	HAVING SUM(amount) >= 110;
SELECT COUNT(*) FROM film
	WHERE title
	LIKE 'J%'
SELECT first_name, last_name FROM customer 
	WHERE address_id < 500
	AND first_name LIKE 'E%'
	ORDER BY customer_id DESC
	LIMIT 1


/* AS */
SELECT first_name AS fn 
	FROM customer
	LIMIT 5;
SELECT SUM(amount) AS total_revenue
	FROM payment;
SELECT customer_id, SUM(amount) AS total_spend
	FROM payment
	GROUP BY customer_id
	HAVING SUM(amount) > 99


/* INNER  JOIN */
SELECT * FROM payment
	INNER JOIN customer
	ON payment.customer_id = customer.customer_id
	LIMIT 5;
SELECT customer.email 
	FROM payment
	INNER JOIN customer
	ON payment.customer_id = customer.customer_id
	LIMIT 5;
SELECT customer.email, payment_id, first_name 
	FROM payment
	INNER JOIN customer
	ON payment.customer_id = customer.customer_id
	LIMIT 5;


/* OUTER JOIN */
SELECT * FROM customer
	FULL OUTER JOIN payment
	ON customer.customer_id = payment.customer_id
	WHERE customer.customer_id IS null
	OR payment.payment_id IS null;


/* LEFT OUTER JOIN / LEFT JOIN */
SELECT DISTINCT(email), payment.customer_id 
	FROM customer
	LEFT OUTER JOIN payment
	ON customer.customer_id = payment.customer_id;
SELECT language.name, film.title
	FROM language
	LEFT JOIN film;
	ON film.language_id = language.language_id;
SELECT film.film_id, title, inventory_id
	FROM film
	LEFT JOIN inventory
	ON inventory.film_id = film.film_id
	WHERE inventory.film_id IS null;


/* RIGHT OUTER JOIN / RIGHT JOIN */
SELECT film.film_id, title, inventory_id
	FROM film
	RIGHT JOIN inventory
	ON inventory.film_id = film.film_id;



/* JOIN CHALLENGED */
SELECT email, district
	FROM customer
	INNER JOIN address
	ON customer.address_id = address.address_id
	WHERE district = 'California';
SELECT title, first_name, last_name
	FROM film_actor
	INNER JOIN film 
	ON film.film_id = film_actor.film_id
	INNER JOIN actor 
	ON film_actor.actor_id = actor.actor_id
	WHERE first_name = 'Nick'
	AND last_name = 'Wahlberg'


/* SHOW */
SHOW ALL
SHOW TIMEZONE


/* Time */
SELECT NOW();
SELECT TIMEOFDAY();
SELECT CURRENT_DATE;


/* EXTRACT */
SELECT EXTRACT(YEAR FROM payment_date) AS year
	FROM payment
SELECT COUNT(*)
	FROM payment
	WHERE EXTRACT(dow FROM payment_date) = 1


/* AGE */
SELECT AGE(payment_date) AS age
	FROM payment


/* TO_CHAR() */
SELECT TO_CHAR(payment_date, 'dd-mm-yyyy') 
	FROM payment;
SELECT TO_CHAR(payment_date, 'dd Mon YYYY') 
	FROM payment;
SELECT DISTINCT(TO_CHAR(payment_date, 'dd Mon YYYY')) 
	FROM payment;
SELECT DISTINCT(TO_CHAR(payment_date, 'Month'))
	FROM payment;
SELECT COUNT(*)
	FROM payment
	WHERE TO_CHAR(payment_date, 'Day') = 'Monday   ';


/* Mathematical Operators */
SELECT rental_rate/replacement_cost FROM film;
SELECT ROUND(rental_rate/replacement_cost, 2) FROM film;
SELECT ROUND(rental_rate/replacement_cost, 4) * 100 FROM film;
	

/* String Function */
SELECT first_name, LENGTH(first_name) FROM customer;
SELECT first_name || ' ' || UPPER((last_name) AS customer 
	FROM customer
SELECT LOWER(LEFT(first_name, 1)) 
	|| '.' || 
	LOWER(last_name)
	|| '@gmail.com'
	AS customer_email 
	FROM customer


/* SubQuery */
SELECT title, rental_rate
	FROM film
	WHERE rental_rate > (SELECT AVG(rental_rate) FROM film);
SELECT title, film_id FROM film
WHERE film_id IN
(SELECT inventory.film_id
	FROM rental
	INNER JOIN inventory
	ON rental.inventory_id = inventory.inventory_id
	WHERE return_date BETWEEN '2005-05-29' AND '2005-05-30')
	ORDER BY film_id;
SELECT first_name, last_name FROM customer AS c
	WHERE EXISTS(SELECT * FROM payment as p 
					WHERE p.customer_id = c.customer_id
					AND amount > 11
				);
SELECT first_name, last_name FROM customer AS c
	WHERE NOT EXISTS(SELECT * FROM payment as p 
					WHERE p.customer_id = c.customer_id
					AND amount > 11
				);


/* SELF JOIN */
SELECT f1.title,f2.title, f1.length length 
	FROM film AS f1
	INNER JOIN film as f2
	ON f1.film_id != f2.film_id
	AND f1.length = f2.length
	ORDER BY f1.length


/* Assessment 2 */
/* How can you retrieve all the information from the cd.facilities table? */
SELECT * FROM cd.facilities;
/* You want to print out a list of all of the facilities and their cost to members. How would you retrieve a list of only facility names and costs? */
SELECT name, membercost FROM cd.facilities;
/* How can you produce a list of facilities that charge a fee to members? */
SELECT * FROM cd.facilities
	WHERE membercost > 0;
/* How can you produce a list of facilities that charge a fee to members, and that fee is less than 1/50th of the monthly maintenance cost? Return the facid, facility name, member cost, and monthly maintenance of the facilities in question. */
SELECT facid, name, membercost, monthlymaintenance 
	FROM cd.facilities
	WHERE membercost > 0 AND
	membercost < monthlymaintenance/50.0;
/* How can you produce a list of all facilities with the word 'Tennis' in their name? */
SELECT * 
	FROM cd.facilities
	WHERE name LIKE '%Tennis%';
/* How can you retrieve the details of facilities with ID 1 and 5? Try to do it without using the OR operator.*/
SELECT * FROM cd.facilities
	WHERE facid IN (1,5);
/* How can you produce a list of members who joined after the start of September 2012? Return the memid, surname, firstname, and joindate of the members in question. */
SELECT memid, surname, firstname, joindate 
	FROM cd.members 
	WHERE joindate >= '2012-09-01';
/* How can you produce an ordered list of the first 10 surnames in the members table? The list must not contain duplicates. */
SELECT DISTINCT surname 
	FROM cd.members
	ORDER BY  surname 
	LIMIT 10;
/* You'd like to get the signup date of your last member. How can you retrieve this information? */
SELECT MAX(joindate) AS latest_signup 
	FROM cd.members;
/* Produce a count of the number of facilities that have a cost to guests of 10 or more. */	
SELECT COUNT(*) 
	FROM cd.facilities 
	WHERE guestcost >= 10;
/* Produce a list of the total number of slots booked per facility in the month of September 2012. Produce an output table consisting of facility id and slots, sorted by the number of slots. */
SELECT facid, sum(slots) AS "Total Slots" 
	FROM cd.bookings 
	WHERE starttime >= '2012-09-01' 
	AND starttime < '2012-10-01' 
	GROUP BY facid 
	ORDER BY SUM(slots);
/* Produce a list of facilities with more than 1000 slots booked. Produce an output table consisting of facility id and total slots, sorted by facility id. */
SELECT facid, sum(slots) AS total_slots 
	FROM cd.bookings 
	GROUP BY facid 
	HAVING SUM(slots) > 1000 
	ORDER BY facid;	
/* How can you produce a list of the start times for bookings for tennis courts, for the date '2012-09-21'? Return a list of start time and facility name pairings, ordered by the time. */
SELECT cd.bookings.starttime AS start, cd.facilities.name 
	AS name 
	FROM cd.facilities 
	INNER JOIN cd.bookings
	ON cd.facilities.facid = cd.bookings.facid 
	WHERE cd.facilities.facid IN (0,1) 
	AND cd.bookings.starttime >= '2012-09-21' 
	AND cd.bookings.starttime < '2012-09-22' 
	ORDER BY cd.bookings.starttime;
/* How can you produce a list of the start times for bookings by members named 'David Farrell'? */
SELECT cd.bookings.starttime 
	FROM cd.bookings 
	INNER JOIN cd.members 
	ON cd.members.memid = cd.bookings.memid 
	WHERE cd.members.firstname='David' 
	AND cd.members.surname='Farrell';


/* Creating Databases and Table */

/* Primary keys = unique to each table */
/* Foreign keys = Is the primary key that is also available in another table */

/* CREATE TABLE */
CREATE TABLE account(
	user_id SERIAL PRIMARY KEY,
	username VARCHAR(50) UNIQUE NOT NULL,
	password VARCHAR(50) NOT NULL,
	email VARCHAR(250) UNIQUE NOT NULL,
	created_on TIMESTAMP NOT NULL,
	last_login TIMESTAMP
);

CREATE TABLE job(
	job_id SERIAL PRIMARY KEY,
	job_name VARCHAR(200) UNIQUE NOT NULL
);

CREATE TABLE account_job(
	user_id INTEGER REFERENCES account(user_id),
	job_id INTEGER REFERENCES job(job_id),
	hire_date TIMESTAMP
);

CREATE TABLE information(
	info_id SERIAL PRIMARY KEY,
	title VARCHAR(500) NOT NULL,
	person VARCHAR(50) NOT NULL UNIQUE
);

/* INSERT */
INSERT INTO account(
		username, 
		password,
		email,
		created_on
	) VALUES(
		'Jose',
		'password',
		'jose@gmail.com',
		CURRENT_TIMESTAMP
);

INSERT INTO job(job_name) VALUES ('Dev Fullstack');

INSERT INTO account_job(user_id, job_id, hire_date)
VALUES(1, 1, CURRENT_TIMESTAMP);


/* UPDATE */
UPDATE account 
	SET last_login = CURRENT_TIMESTAMP

UPDATE account 
	SET last_login = created_on

UPDATE account_job
	SET hire_date = account.created_on
	FROM account
	WHERE account_job.user_id = account.user_id;

UPDATE account
SET last_login = CURRENT_TIMESTAMP,
	username = 'Ashifu'
	RETURNING email, username, last_login, created_on


/* DELETE */
DELETE FROM job
	WHERE job_id = 3
	RETURNING *


/* ALTER TABLE */
ALTER TABLE information
	RENAME TO new_info

ALTER TABLE new_info
	RENAME COLUMN person TO people

ALTER TABLE new_info
	ALTER COLUMN people
	SET NOT NULL

ALTER TABLE new_info
	ALTER COLUMN people
	DROP NOT NULL


/* DROP TABLE */
ALTER TABLE new_info
	DROP COLUMN IF EXISTS people


/* CHECK constraint */
CREATE TABLE employees(
	emp_id SERIAL PRIMARY KEY,
	last_name VARCHAR(50) NOT NULL,
	first_name VARCHAR(50) NOT NULL,
	birthdate DATE CHECK (birthdate > '1900-01-01'),
	hire_date DATE CHECK (hire_date > birthdate),
	salary INTEGER CHECK (salary > 0)
);

INSERT INTO employees(
	last_name, 
	first_name,
	birthdate,
	hire_date,
	salary 
) VALUES (
	'Asif',
	'Kassam Ali',
	'1990-02-07',
	'2019-02-07',
	100000
)


/* CASE */
SELECT customer_id, 
	CASE
		WHEN (customer_id <= 100) THEN 'Premium'
		WHEN (customer_id BETWEEN 100 AND 200) THEN 'Plus'
		ELSE 'Standard'
	END AS customer_class
	FROM customer;

SELECT customer_id, 
	CASE customer_id
		WHEN 2 THEN 'Winner'
		WHEN 5 THEN 'Second winner'
		ELSE 'Standard'
	END AS winner_list
	FROM customer;

SELECT
	SUM(CASE rental_rate 
			WHEN 0.99 THEN 1
			ELSE 0
		END) AS number_of_cheap_rentals
	FROM film;

SELECT
	SUM(CASE rental_rate 
			WHEN 0.99 THEN 1
			ELSE 0
		END) AS cheap_rentals,
	SUM(CASE rental_rate 
			WHEN 2.99 THEN 1
			ELSE 0
		END) AS regular_rentals,
	SUM(CASE rental_rate 
			WHEN 4.99 THEN 1
			ELSE 0
		END) AS premium_rentals
	FROM film;

SELECT
	SUM(CASE rating
			WHEN 'R' THEN 1
			ELSE 0
	   	END) AS r,
	SUM(CASE rating
			WHEN 'PG' THEN 1
			ELSE 0
	   	END) AS pg,
	SUM(CASE rating
			WHEN 'PG-13' THEN 1
			ELSE 0
	   	END) AS pg13
	FROM film;


/* COALESCE */ 
SELECT item, (price - COALESCE(discount, 0)) 
	AS final_price
	FROM tableName;


/* CAST */
SELECT CAST('5' AS INTEGER);
SELECT SUM(CAST('5' AS INTEGER) + CAST('5' AS INTEGER));
SELECT '5'::INTEGER
SELECT 
	MAX(
		CHAR_LENGTH(
			CAST(inventory_id AS VARCHAR)
		)
	)
	FROM rental;


/* NULLIF */
SELECT 
	SUM(CASE 
			WHEN department = 'A'
			THEN 1
			ELSE 0
	   	END) /
	SUM(CASE 
			WHEN department = 'B'
			THEN 1
			ELSE 0
	   	END) AS department_ratio
FROM departments;

SELECT 
	SUM(CASE 
			WHEN department = 'A'
			THEN 1
			ELSE 0
	   	END) /
	NULLIF(SUM(CASE 
			WHEN department = 'B'
			THEN 1
			ELSE 0
	   	END), 0) AS department_ratio
FROM departments;


/* Views */
CREATE VIEW customer_info AS
	SELECT first_name, last_name, address
		FROM customer
		INNER JOIN address
		ON customer.address_id = address.address_id

SELECT * FROM customer_info

CREATE OR REPLACE VIEW customer_info AS
SELECT first_name, last_name, address, district
		FROM customer
		INNER JOIN address
		ON customer.address_id = address.address_id

SELECT * FROM customer_info

DROP VIEW IF EXISTS customer_info
ALTER VIEW customer_info RENAME TO c_info
SELECT * FROM c_info


/* Import / Export */
/* https://stackoverflow.com/questions/2987433/how-to-import-csv-file-data-into-a-postgresql-table */
/* https://stackoverflow.com/questions/21018256/can-i-automatically-create-a-table-in-postgresql-from-a-csv-file-with-headers */



