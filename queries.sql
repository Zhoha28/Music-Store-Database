-- Create queries to answer the following questions: **talk with your instructor to adapt it according to the specific scenario you received.


-- ASSIGNED SCENARIO --
-- Query 1 - Display a list of clients that spent more than the average spent by client in the past month.

select * from orders;
select * from order_item;

select 
orders.client_id,
 orders.order_total as client_order_total,
 CONCAT(clients.first_name,' ', clients.last_name) as client_name
 from orders
 INNER JOIN clients ON clients.client_id = orders.client_id
WHERE orders.order_total >= (select 
CAST(AVG(order_total)as decimal(20,2)) as average_spent from orders
where order_date between '2021-03-01 00:00:00.000' AND '2021-03-30 00:00:00.000'
GROUP by orders.client_id 
ORDER by average_spent DESC
LIMIT 1);



-- ASSIGNED SCENARIO --
-- Query 2 - The top sold products and least sold products over a week.

select * from order_item;
select * from orders;
-- highest
SELECT 
 album.album_name,
 order_item.quantity as quantity_sold
FROM order_item
INNER JOIN album ON  album.album_id = order_item.album_id
INNER JOIN orders ON  orders.order_id = order_item.order_id
where order_date between '2021-03-20 00:00:00.000' AND '2021-03-27 00:00:00.000'
ORDER BY quantity_sold DESC 
LIMIT 1;

-- Lowest
SELECT 
 album.album_name,
 order_item.quantity as quantity_sold
FROM order_item
INNER JOIN album ON  album.album_id = order_item.album_id
INNER JOIN orders ON  orders.order_id = order_item.order_id
where order_date between '2021-03-20 00:00:00.000' AND '2021-03-27 00:00:00.000'
ORDER BY quantity_sold LIMIT 1;

-- ASSIGNED SCENARIO --
-- Query 3 - The maximum price of products in the same genre (for example, rock, pop, country, hip-hop). Use GROUP BY to list all the genres and their maximum price.

select * from album;
select * from genre;

SELECT 
 genre.genre_name,
 MAX(album.album_price) as maximum_price_of_album_for_genre
FROM album
INNER JOIN genre ON album.genre_id = genre.genre_id
Group BY  genre.genre_name
ORDER BY maximum_price_of_album_for_genre DESC;


-- ASSIGNED SCENARIO --
-- Query 4 - List how many customers the system has by location (Country, Province, and City), and then sort them.

SELECT cou.country_name as country_Name, p.province_name as province_Name, c.City_name ,count(c.city_name) as count_Clients
FROM (clients cl JOIN addresses ad ON cl.client_id = ad.client_id)
  JOIN City c ON ad.city_id = c.City_id
  JOIN province p ON ad.province_id = p.province_id
  JOIN country cou ON ad.country_id = cou.country_id
GROUP BY c.City_name, province_Name, country_Name;
  

-- ASSIGNED SCENARIO --
-- Query 5 - List how many products the store has sold for a particular month.

select * from orders;


select count(quantity) as product_sold_in_march_month
from order_item
INNER JOIN orders ON  orders.order_id = order_item.order_id
where order_date between '2021-03-01 00:00:00.000' AND '2021-03-30 00:00:00.000';

-- ASSIGNED SCENARIO --
-- Query 6 - List how many distinct albums each singer has.

-- CHECKING
select * from album;
select * from singer;
-- QUERY
SELECT DISTINCT
singer.singer_name as Singer_Name,
COUNT(album.singer_id) as count_of_albums
FROM album
INNER JOIN singer ON  singer.singer_id = album.singer_id
GROUP BY album.singer_id, singer.singer_name
ORDER BY Singer_Name;

-- ASSIGNED SCENARIO --
-- Query 7 - List how many copies of an album are available of a particular singer.

-- CHECKING
select * from album;
select * from singer;
select * from order_item;

-- Query
SELECT
singer.singer_name,
 album.album_name,
 (CASE WHEN order_item.quantity > 0 
 then (album.num_of_copies_available - order_item.quantity ) 
	else  (album.num_of_copies_available)
    END)
    as copies_available
FROM album
INNER JOIN singer ON  singer.singer_id = album.singer_id
left JOIN order_item ON  album.album_id = order_item.album_id;




-- CUSTOM SCENARIO --
-- Query 8 - 
-- find out whether delivery is on time or late, and display number of days taken to ship product from the time of order

SELECT
    order_id, 
   CAST(orders.order_date AS DATE) as ordered_date, 
   CAST(orders.ship_date AS DATE) as shipped_date,
   DATEDIFF(ship_date,order_date) as days_taken_to_deliver,
    CASE
        WHEN DATEDIFF(ship_date,order_date) <  8
        THEN 'DELIVERY IS ON TIME'
        ELSE 'DELIVERY IS LATE'
    END shipment
FROM 
    orders
WHERE 
    ship_date IS NOT NULL
ORDER BY 
    order_date;


-- CUSTOM SCENARIO --
-- Query 9 -
-- Find the trend of music by the genre sold till now.

select * from orders;

select max(order_item.quantity),
 genre.genre_name
 from order_item
INNER JOIN album on order_item.album_id = album.album_id
INNER JOIN genre on album.album_id = genre.genre_id;











