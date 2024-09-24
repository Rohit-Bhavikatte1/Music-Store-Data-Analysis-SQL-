--- Who is the Senior most Employee ?

SELECT * 
FROM employee 
WHERE title LIKE '%Senior%';



--- Which contries have the most Invoices ?

SELECT 
	billing_country,
	COUNT(invoice_id) AS Total_Invoices
FROM invoice
GROUP BY billing_country
ORDER BY Total_Invoices DESC;

--- What are top 3 values of Total Invoices

 SELECT * 
 FROM invoice
 ORDER BY total DESC



 --- Which city has the best customers ? Query that returns one city thas has the highest sum of invoice totals
 --- Return Both city name and sum of all invoice totals.

SELECT 
	billing_city, 
	SUM(total) AS Total_invoices
FROM invoice
GROUP BY billing_city
ORDER BY Total_invoices DESC


--- Who is the best customers ? Write a query to return the person who has spent the more money


SELECT 
cus.customer_id,
cus.first_name,
cus.last_name,
sum(inv.total) AS Total_money_spent
FROM customer AS cus
JOIN invoice  AS inv
ON cus.customer_id = inv.customer_id
GROUP BY 
cus.customer_id,
cus.first_name,
cus.last_name
ORDER BY Total_money_spent DESC;


--- Write the query to return the email,first_name,last_name and Genre,of All Rock music Listeners 
--- Return your list ordered alphabetically by email starting with A

SELECT DISTINCT
first_name,
last_name,
email
FROM customer AS cus
JOIN invoice AS inv
ON cus.customer_id = inv.customer_id
JOIN invoice_line AS invl
ON inv.invoice_id = invl.invoice_id
JOIN track AS tra
ON invl.track_id = tra.track_id
WHERE tra.track_id IN (SELECT tra.track_id
				FROM track
				JOIN genre AS gen
				ON tra.genre_id = gen.genre_id
				WHERE gen.name LIKE 'Rock')
ORDER BY cus.email ASC;


--- Write a query that returns the artist name and total count of top 10 rock bands

SELECT TOP 10
	art.artist_id,
	art.name,
	COUNT(art.name) AS TotalSongs,
	gen.name AS GenreName
FROM artist AS art
JOIN album AS alb
ON art.artist_id = alb.artist_id
JOIN track AS tra
ON alb.album_id = tra.album_id
JOIN genre AS gen
ON tra.genre_id = gen.genre_id
WHERE gen.name LIKE 'Rock'
GROUP BY 
	art.artist_id,
	art.name,
	gen.name
ORDER BY TotalSongs DESC


--- Return the all the track names that hava a song length longer than the average song length 
--- return the name and miliseconds of each track
--- Order by the song length with the longest song listed first

SELECT 
name,
milliseconds
FROM track
WHERE milliseconds > (SELECT AVG(milliseconds) FROM track) 
ORDER BY milliseconds DESC

--- Find how much amount spent by each customer on Artist 
--- Write a Query to return customer name , artist name and total spent money.

SELECT
	CONCAT(cus.first_name,' ',cus.last_name) AS CustomerName,
	art.name,
	SUM(inv.total) OVER(PARTITION BY art.name) AS TotalMoneySpent
FROM customer cus
JOIN invoice AS inv
ON cus.customer_id = inv.customer_id
JOIN invoice_line AS invl
ON inv.invoice_id = invl.invoice_id
JOIN track AS trak
ON invl.track_id = trak.track_id
JOIN album AS alb
ON trak.album_id = alb.album_id
JOIN artist AS art
ON alb.artist_id = art.artist_id 
ORDER BY TotalMoneySpent DESC


SELECT
	CONCAT(cus.first_name,' ',cus.last_name) AS CustomerName,
	art.name,
	SUM(inv.total) AS TotalMoneySpent
FROM customer cus
JOIN invoice AS inv
ON cus.customer_id = inv.customer_id
JOIN invoice_line AS invl
ON inv.invoice_id = invl.invoice_id
JOIN track AS trak
ON invl.track_id = trak.track_id
JOIN album AS alb
ON trak.album_id = alb.album_id
JOIN artist AS art
ON alb.artist_id = art.artist_id 
GROUP BY 2
ORDER BY TotalMoneySpent DESC



