# World SQL

USE world;
SHOW FULL TABLES;
SELECT * FROM country
;

# 1. How many countries are there in the world database?
SELECT name FROM country;
SELECT count(name) FROM country
;

# 2. Show the average life expectancy in the continent of Asia!
SELECT avg(LifeExpectancy) FROM country
WHERE continent = 'Asia'
;

# 3. Show the total population in Southeast Asia!
SELECT sum(Population) FROM country
WHERE region = 'SouthEast Asia'
;

# 4. Show the average GNP in the Eastern Africa region of the African continent. Use the 'Average_GNP' for the average GNP!
SELECT avg(GNP) as 'Average_GNP' 
FROM country
WHERE region = 'Eastern Africa'
;

# 5. Show the average Population of countries with an area of ​​more than 5 million km^2!
SELECT avg(Population) FROM country
WHERE SurfaceArea > 5000000
;

# 6. How many (unique) languages ​​are there in the world?
SELECT * FROM countrylanguage;
SELECT count(DISTINCT language) FROM countrylanguage
;

# 7. Show the GNP of 5 countries in Asia with a population of over 100 million people!
SELECT Name, GNP FROM country
WHERE continent = 'Asia' AND population > 10e7
LIMIT 5
;

# 8. Show the countries in Africa that have a Surface Area above 1,200,000!
SELECT Name, SurfaceArea FROM country 
WHERE continent = 'Africa' AND SurfaceArea > 1200000
;

# 9. Show the countries in Asia that have a republican system of government. How many countries are there?
SELECT Name, continent, GovernmentForm  FROM country
WHERE continent = 'Asia' AND GovernmentForm = 'Republic'
;

SELECT count(Name)  FROM country
WHERE continent = 'Asia' AND GovernmentForm = 'Republic'
;

# 10. Show the number of countries in Europe that were independent before 1940!
SELECT count(Name) FROM country
WHERE continent = 'Europe' AND IndepYear < 1940
;

#11. How many regions are there in the world database? Change the header to 'Number_of_Regions'!
SELECT count(DISTINCT region) AS Number_of_Regions
FROM country
;

#12. How many countries are there in Africa? Change the header to 'Number_of_Countries'!
SELECT continent, count(Name)  as Number_of_Countries
FROM country
GROUP BY continent
HAVING continent = 'Africa';

SELECT continent, count(name) as Number_of_Countries
FROM country
WHERE continent = 'Africa'
;

#13. Show the 5 countries with the largest population! Change the headers to 'Country_Name' and 'Population'!
SELECT Name as 'Country_Name', Population as 'Population'
FROM country
ORDER BY population DESC
LIMIT 5
;

SELECT Name as 'Country_Name', format(Population, 0) as 'Population'
FROM country
ORDER BY population DESC
LIMIT 5
;

#14. Display the average life expectancy of each continent and sort it from lowest to highest!
SELECT Continent_Name, AVG(LifeExpectancy) AS Average_Life_Expectancy
FROM country
GROUP BY Continent_Name
ORDER BY Average_Life_Expectancy ASC
;


#15. Show the number of regions for each continent with more than 3 regions!
SELECT continent, COUNT(DISTINCT region) AS num_regions
FROM country
GROUP BY continent
HAVING COUNT(DISTINCT region) > 3
;


#16. Show the average GNP in Africa by region and sort it by the largest average GNP!
SELECT region, AVG(GNP) AS avg_GNP
FROM country
WHERE continent = 'Africa'
GROUP BY region
ORDER BY avg_GNP DESC
;


#17. Show countries in Europe that have names starting with the letter I.
SELECT name, continent 
FROM country
WHERE continent = 'Europe'
AND name LIKE 'i%'
;

#18. Show the number of languages ​​per country! Sort by the most!
SELECT countrycode, COUNT(DISTINCT language) AS num_languages
FROM countrylanguage
GROUP BY countrycode
ORDER BY num_languages DESC
;

#19. Show country names that are 6 letters long and end with 'O'
SELECT name FROM country
WHERE name LIKE '_____o'
;

#20. Show the 7 largest languages ​​in Indonesia (in percentage, with rounded percentages)!
SELECT countrycode, language, ROUND(percentage, 0) AS Percentage
FROM countrylanguage
WHERE countrycode = 'IDN'
ORDER BY Percentage DESC
LIMIT 7
;

#21. Show Continents that have less than 10 GovernmentForms
SELECT continent, count(DISTINCT GovernmentForm)
FROM country
GROUP BY continent
HAVING count(DISTINCT GovernmentForm) < 10
;

#22. Which regions have increased their Total GNP from the previous Total GNP (GNPOld)? Sort from the highest!
SELECT region, SUM(GNP) - SUM(GNPOld) AS GNP_difference
FROM country
GROUP BY region
HAVING GNP_difference > 0
ORDER BY GNP_difference DESC
;

#23. Show the 10 most populous cities. (show city name, country of origin, and population)
SELECT 
    city.Name AS City_Name, 
    country.Name AS Country_Name, 
    city.Population
FROM city
JOIN country ON city.CountryCode = country.Code
ORDER BY city.Population DESC
LIMIT 10
;

#24. Show countries in Asia with life expectancy higher than the average life expectancy
SELECT Name, LifeExpectancy
FROM country
WHERE Continent = 'Asia'
  AND LifeExpectancy > (
      SELECT AVG(LifeExpectancy)
      FROM country
  )
ORDER BY LifeExpectancy DESC
;

#25. Countries in Europe. Sort 10 data from the highest life expectancy. (show, country name, continent, life expectancy, and GNP).
SELECT 
    Name AS Country_Name, 
    Continent, 
    LifeExpectancy, 
    GNP
FROM country
WHERE Continent = 'Europe'
ORDER BY LifeExpectancy DESC
LIMIT 10
;

#26. Show the 10 countries with the highest percentage that use English as their official language.
# (Show country code, country name, language, Official (T/F), percentage).
SELECT 
    cl.CountryCode, 
    c.Name AS Country_Name, 
    cl.Language, 
    cl.IsOfficial, 
    cl.Percentage
FROM countrylanguage cl
JOIN country c ON cl.CountryCode = c.Code
WHERE cl.Language = 'English' 
  AND cl.IsOfficial = 'T'
ORDER BY cl.Percentage DESC
LIMIT 10
;

#27. Show countries, country population, GNP, capital, and capital population. IN ASEAN and sort alphabetically by country name.
SELECT 
    c.Name AS Country_Name,
    c.Population AS Country_Population,
    c.GNP,
    ci.Name AS Capital_Name,
    ci.Population AS Capital_Population
FROM country c
JOIN city ci ON c.Capital = ci.ID
WHERE c.Name IN (
    'Brunei', 'Cambodia', 'Indonesia', 'Laos', 'Malaysia', 
    'Myanmar', 'Philippines', 'Singapore', 'Thailand', 'Vietnam'
)
ORDER BY c.Name ASC
;

#28. Same as no.4 For G-20 countries.
SELECT 
    c.Name AS Country_Name,
    c.Population AS Country_Population,
    c.GNP,
    ci.Name AS Capital_Name,
    ci.Population AS Capital_Population
FROM country c
JOIN city ci ON c.Capital = ci.ID
WHERE c.Name IN (
    'Argentina', 'Australia', 'Brazil', 'Canada', 'China', 'France', 
    'Germany', 'India', 'Indonesia', 'Italy', 'Japan', 'Mexico', 'Russia', 
    'Saudi Arabia', 'South Africa', 'South Korea', 'Turkey', 
    'United Kingdom', 'United States'
)
ORDER BY c.Name ASC
;
