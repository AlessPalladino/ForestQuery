--Create a View called “forestation” by joining all three tables - forest_area, land_area and regions in the workspace.
--The forest_area and land_area tables join on both country_code AND year.
--The regions table joins these based on only country_code.
--In the ‘forestation’ View, include the following:

--All of the columns of the origin tables
--A new column that provides the percent of the land area that is designated as forest.
--Keep in mind that the column forest_area_sqkm in the forest_area table and the land_area_sqmi in the land_area table are in different units (square kilometers and square miles, respectively),
--so an adjustment will need to be made in the calculation you write (1 sq mi = 2.59 sq km).

CREATE VIEW forestation AS (
SELECT sub.country_code AS country_code,
       sub.country_name AS country_name,
       sub.year AS year,
       sub.forest_area_sqkm AS forest_area_sqkm,
  	   sub.forest_percent_of_land AS forest_percent_of_land,
       sub.total_area_sq_mi AS total_area_sq_mi,
       sub.total_area_sqkm AS total_area_sqkm,
  	   r.region AS region,
       r.income_group AS income_group
FROM (
       SELECT f_a.country_code AS country_code,
       f_a.country_name AS country_name,
       f_a.year AS year,
       f_a.forest_area_sqkm AS forest_area_sqkm,
       l_a.total_area_sq_mi AS total_area_sq_mi,
       (f_a.forest_area_sqkm / (2.59 * l_a.total_area_sq_mi)) * 100 AS forest_percent_of_land,
       (2.59 * l_a.total_area_sq_mi) AS total_area_sqkm
       FROM forest_area AS f_a
       JOIN land_area AS l_a
       ON f_a.country_code = l_a.country_code 
       AND f_a.year = l_a.year) AS sub
JOIN regions AS r
ON sub.country_code = r.country_code)


-- regions contains a country code that isn't in forest_area (TWN)
SELECT  DISTINCT country_code 
FROM regions
EXCEPT 
SELECT  DISTINCT country_code 
FROM forest_area

SELECT *
FROM forest_area
WHERE country_code = 'TWN'
-- since there are no data about TWN in both forest_area and land_area tables we can proceed using a inner join and drop the row

-- Global Situation
-- What was the total forest area (in sq km) of the world in 1990?
-- Please keep in mind that you can use the country record denoted as “World" in the region table.
SELECT *
FROM forestation
WHERE country_name = 'World' AND year = '1990';
-- What was the total forest area (in sq km) of the world in 2016?
-- Please keep in mind that you can use the country record in the table is denoted as “World.”
SELECT *
FROM forestation
WHERE country_name = 'World' AND year = '2016';
-- What was the change (in sq km) in the forest area of the world from 1990 to 2016?
WITH world_1990 AS (
    SELECT forest_area_sqkm AS forest_area_sqkm_1990
    FROM forestation
    WHERE country_name = 'World' AND year = '1990'),
world_2016 AS (
    SELECT forest_area_sqkm AS forest_area_sqkm_2016
    FROM forestation
    WHERE country_name = 'World' AND year = '2016')
SELECT forest_area_sqkm_2016 - forest_area_sqkm_1990 AS forest_area_change
FROM world_1990, world_2016 ;
-- What was the percent change in forest area of the world between 1990 and 2016?
WITH world_1990 AS (
    SELECT forest_area_sqkm AS forest_area_sqkm_1990
    FROM forestation
    WHERE country_name = 'World' AND year = '1990'),
world_2016 AS (
    SELECT forest_area_sqkm AS forest_area_sqkm_2016
    FROM forestation
    WHERE country_name = 'World' AND year = '2016')
SELECT ((forest_area_sqkm_2016 - forest_area_sqkm_1990)/forest_area_sqkm_1990) * 100 AS forest_area_percent_change
FROM world_1990, world_2016 ;
-- If you compare the amount of forest area lost between 1990 and 2016, to which country's total area in 2016 is it closest to?
WITH world_1990 AS (
    SELECT forest_area_sqkm AS forest_area_sqkm_1990
    FROM forestation
    WHERE country_name = 'World' AND year = '1990'),
world_2016 AS (
    SELECT forest_area_sqkm AS forest_area_sqkm_2016
    FROM forestation
    WHERE country_name = 'World' AND year = '2016'),
t3 AS (
    SELECT ABS(world_2016.forest_area_sqkm_2016 - world_1990.forest_area_sqkm_1990) AS abs_forest_area_change
    FROM world_1990, world_2016)
SELECT *, t3.abs_forest_area_change
FROM forestation, t3
WHERE forestation.total_area_sqkm <= t3.abs_forest_area_change AND forestation.year = '2016'
ORDER BY forestation.total_area_sqkm DESC
LIMIT 1
-- Create a table that shows the Regions and their percent forest area (sum of forest area divided by sum of land area) in 1990 and 2016. (Note that 1 sq mi = 2.59 sq km).
-- Based on the table you created, ....
CREATE view forestation_percent AS (
SELECT region, year, (sum(forest_area_sqkm)/sum(2.59 * total_area_sq_mi)) * 100 AS forest_percent_total_land,
       sum(forest_area_sqkm) AS forest_area_sqkm_region
FROM forestation
WHERE year = '1990' OR year = '2016'
GROUP BY 1,2
ORDER BY 1);
--  What was the percent forest of the entire world in 2016? Which region had the HIGHEST percent forest in 2016, and which had the LOWEST, to 2 decimal places?
SELECT region, forest_percent_total_land
FROM forestation_percent
WHERE region = 'World' AND year = '2016';

SELECT region, ROUND((forest_percent_total_land::numeric),2)
FROM forestation_percent
WHERE year = '2016'
ORDER BY forest_percent_total_land DESC
LIMIT 1;
SELECT region, ROUND((forest_percent_total_land::numeric),2)
FROM forestation_percent
WHERE year = '2016'
ORDER BY forest_percent_total_land ASC
LIMIT 1;

SELECT region, forest_percent_total_land
FROM forestation_percent
WHERE region = 'World' AND year = '1990';

SELECT region, ROUND((forest_percent_total_land::numeric),2)
FROM forestation_percent
WHERE year = '1990'
ORDER BY forest_percent_total_land desc
limit 1;
SELECT region, ROUND((forest_percent_total_land::numeric),2)
FROM forestation_percent
WHERE year = '1990'
ORDER BY forest_percent_total_land ASC
LIMIT 1;
-- Based on the table you created, which regions of the world DECREASED in forest area from 1990 to 2016?
WITH sub AS (
    SELECT region, forest_area_sqkm_region AS forest_area_1990
    FROM forestation_percent
    WHERE year = '1990'),
t2 AS (
    SELECT forestation_percent.region, sub.forest_area_1990,
    CASE 
    WHEN forestation_percent.forest_area_sqkm_region - sub.forest_area_1990 < 0 THEN 'decreased'
    WHEN forestation_percent.forest_area_sqkm_region - sub.forest_area_1990 = 0 THEN 'equal' 
    ELSE 'increased' END AS forest_area_change,
    ((forestation_percent.forest_area_sqkm_region - sub.forest_area_1990)/sub.forest_area_1990) * 100 as change
    FROM forestation_percent
    JOIN sub
    ON forestation_percent.region = sub.region
    WHERE forestation_percent.year = '2016')
SELECT region, change
FROM t2
WHERE forest_area_change = 'decreased';

SELECT *
FROM forestation_percent
WHERE region = 'Latin America & Caribbean' OR region = 'Sub-Saharan Africa' OR region = 'World'
-- 
WITH t1 AS (
    SELECT country_name, region, forest_area_sqkm AS forest_area_sqkm_1990
    FROM forestation
    WHERE year = '1990'),
t2 AS (
    SELECT forestation.country_name, forestation.region, forest_area_sqkm AS forest_area_sqkm_2016, t1.forest_area_sqkm_1990
    FROM forestation
    JOIN t1
    ON forestation.country_name = t1.country_name
    WHERE year = '2016')
SELECT country_name,
       region,forest_area_sqkm_2016,
       forest_area_sqkm_1990, forest_area_sqkm_2016 - forest_area_sqkm_1990 AS change,
       ABS(forest_area_sqkm_2016 - forest_area_sqkm_1990) AS absolute_change,
       ((forest_area_sqkm_2016 - forest_area_sqkm_1990)/forest_area_sqkm_1990) * 100 AS percent_change
FROM t2
WHERE forest_area_sqkm_2016 IS NOT NULL AND forest_area_sqkm_1990 IS NOT NULL AND country_name != 'World'
ORDER BY 5 desc
LIMIT 1;

WITH t1 AS (
    SELECT country_name, region, forest_area_sqkm AS forest_area_sqkm_1990
    FROM forestation
    WHERE year = '1990'),
t2 AS (
    SELECT forestation.country_name, forestation.region, forest_area_sqkm AS forest_area_sqkm_2016, t1.forest_area_sqkm_1990
    FROM forestation
    JOIN t1
    ON forestation.country_name = t1.country_name
    WHERE year = '2016')
SELECT country_name, 
       region,forest_area_sqkm_2016,
       forest_area_sqkm_1990, forest_area_sqkm_2016 - forest_area_sqkm_1990 AS change,
       ABS(forest_area_sqkm_2016 - forest_area_sqkm_1990) AS absolute_change,
       ((forest_area_sqkm_2016 - forest_area_sqkm_1990)/forest_area_sqkm_1990) * 100 AS percent_change
FROM t2
WHERE forest_area_sqkm_2016 IS NOT NULL AND forest_area_sqkm_1990 IS NOT NULL
ORDER BY 7 desc
LIMIT 1;
-- Which 5 countries saw the largest amount decrease in forest area from 1990 to 2016? What was the difference in forest area for each?
WITH t1 AS (
    SELECT country_name, region, forest_area_sqkm AS forest_area_sqkm_1990
    FROM forestation
    WHERE year = '1990'),
t2 AS (
    SELECT forestation.country_name, forestation.region, forest_area_sqkm AS forest_area_sqkm_2016, t1.forest_area_sqkm_1990
    FROM forestation
    JOIN t1
    ON forestation.country_name = t1.country_name
    WHERE year = '2016')
SELECT country_name,
       region,forest_area_sqkm_2016,
       forest_area_sqkm_1990,
       forest_area_sqkm_2016 - forest_area_sqkm_1990 AS change,
       ABS(forest_area_sqkm_2016 - forest_area_sqkm_1990) AS absolute_change
FROM t2
WHERE country_name != 'World'
ORDER BY 5 asc
LIMIT 5;


-- Which 5 countries saw the largest percent decrease in forest area from 1990 to 2016? What was the percent change to 2 decimal places for each?
WITH t1 AS (
    SELECT country_name, region, forest_area_sqkm AS forest_area_sqkm_1990
    FROM forestation
    WHERE year = '1990'),
t2 AS (
    SELECT forestation.country_name, forestation.region, forest_area_sqkm AS forest_area_sqkm_2016, t1.forest_area_sqkm_1990
    FROM forestation
    JOIN t1
    ON forestation.country_name = t1.country_name
    WHERE year = '2016')
SELECT country_name,
       region,forest_area_sqkm_2016,
       forest_area_sqkm_1990,
       ROUND(((((forest_area_sqkm_2016 - forest_area_sqkm_1990)/ forest_area_sqkm_1990) * 100)::numeric),2) AS percent_change
FROM t2
WHERE country_name != 'World'
ORDER BY 5 ASC
LIMIT 5
--  If countries were grouped by percent forestation in quartiles, which group had the most countries in it in 2016?
SELECT sub.quartiles, COUNT(*)
FROM (
    SELECT country_name, region, year, forest_percent_of_land,
    NTILE(4) OVER (ORDER BY forest_percent_of_land) AS quartiles
FROM forestation
WHERE year = '2016' AND forest_percent_of_land IS NOT NULL) AS sub
GROUP BY 1
ORDER BY 2 DESC
-- using case statement (in my opinion this is wrong because the following is not a quartile in statistical sense)
SELECT sub.quartile, COUNT(*)
FROM (
    SELECT country_name, region, year, forest_percent_of_land,
    CASE
    WHEN forest_percent_of_land >= 0 AND forest_percent_of_land < 25 THEN 1
    WHEN forest_percent_of_land >= 25 AND forest_percent_of_land < 50 THEN 2
    WHEN forest_percent_of_land >= 50 AND forest_percent_of_land < 75 THEN 3
    ELSE 4 END AS quartile
    FROM forestation
    WHERE  year = '2016' AND forest_percent_of_land IS NOT NULL) AS sub
GROUP BY 1
ORDER BY 2 DESC
-- . List all of the countries that were in the 4th quartile (percent forest > 75%) in 2016.
SELECT country_name, forest_percent_of_land, quartiles, region
FROM (
    SELECT country_name, region, year, forest_percent_of_land,
    ntile(4) OVER (ORDER BY forest_percent_of_land) AS quartiles
FROM forestation
WHERE year = '2016' AND forest_percent_of_land IS NOT NULL) AS sub
WHERE quartiles = 4
ORDER BY 2 DESC
-- same as before, wrong in my opinion
SELECT country_name, forest_percent_of_land, quartile, region
FROM (
    SELECT country_name, region, year, forest_percent_of_land,
    CASE
    WHEN forest_percent_of_land >= 0 AND forest_percent_of_land < 25 THEN 1
    WHEN forest_percent_of_land >= 25 AND forest_percent_of_land < 50 THEN 2
    WHEN forest_percent_of_land >= 50 AND forest_percent_of_land < 75 THEN 3
    ELSE 4 END AS quartile
    FROM forestation
    WHERE  year = '2016' AND forest_percent_of_land IS NOT NULL) AS sub
WHERE quartile = 4
ORDER BY 2 DESC
-- How many countries had a percent forestation higher than the United States in 2016?
SELECT country_name, year, forest_percent_of_land
FROM forestation
WHERE forest_percent_of_land > (SELECT forest_percent_of_land FROM forestation WHERE country_name = 'United States' AND year = '2016')
ORDER BY 3 DESC





