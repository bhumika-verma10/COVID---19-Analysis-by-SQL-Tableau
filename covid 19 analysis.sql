CREATE DATABASE virus ;
USE virus;
SELECT * FROM covid_19;
-- chechking the null values;
SELECT * FROM covid_19 
WHERE Province IS NULL 
OR `Country/Region` IS NULL
 OR Confirmed IS NULL 
 OR Deaths IS NULL
 OR Recovered IS NULL 
 OR Latitude IS NULL 
 OR Longitude IS NULL 
 OR Date IS NULL;
-- Checking No. of rows;
SELECT COUNT(*) as `No. of rows` FROM covid_19;
-- checking starting date & end date;
SELECT MIN(Date) as `starting date` ,
       MAX(Date) as `end date` FROM covid_19;
-- Number of month present in dataset;
SELECT COUNT(DISTINCT MONTH(Date)) as Num_months FROM covid_19;
-- Monthly Average for confirmed cases , deaths & recovered;
SELECT YEAR(Date) AS year ,
	 MONTH(Date) AS month,
       AVG(Confirmed) AS Avg_confirmed,
       AVG(Deaths) AS Avg_Death,
       AVG(Recovered) AS Avg_recovered FROM covid_19
GROUP BY year , month
ORDER BY year , month;
-- find MIN value for confirmed cases , deaths & recovered for each year;
SELECT YEAR(Date) AS year ,
	MIN(Confirmed) AS Min_confirmed,
    MIN(Deaths) AS Min_death,
    Min(Recovered) AS Min_recovered FROM covid_19
    GROUP BY year;
-- find MIN value for confirmed , deaths & recovered case for each year;
SELECT YEAR(Date) AS year ,
	MAX(Confirmed) AS Max_confirmed,
    MAX(Deaths) AS Max_death,
    MAX(Recovered) AS Max_recovered FROM covid_19
    GROUP BY year;
-- find the total values for confirmed , deaths & recovered case for each Month;
SELECT YEAR(Date) AS year, MONTH(Date) AS Month,
	SUM(Confirmed) AS Total_confirmed,
    SUM(Deaths) AS Total_deaths,
    SUM(Recovered) AS Total_recovered FROM covid_19
    GROUP BY year , Month;
-- find country having highest number of confirmed cases;
SELECT `Country/Region`,
        SUM(Confirmed) AS confirmed_cases FROM covid_19
        GROUP BY `Country/Region`
        ORDER BY confirmed_cases DESC
        LIMIT 1;
-- find country having lowest number of confirmed cases ; 
SELECT `Country/Region`,
       SUM(Confirmed) AS confirmed_cases FROM covid_19
        GROUP BY `Country/Region`
        ORDER BY confirmed_cases ASC
        LIMIT 1;
-- Check how corona virus spread out with respect to confirmed case (STDEV , variance , avg)  
SELECT 
      SUM(Confirmed) AS total_confirmed_cases,
      AVG(Confirmed) AS Avg_confirmed_cases,
      VARIANCE(Confirmed) AS Variance_confirmed_cases,
      STDDEV(Confirmed) AS stddev_confirmed_cases
FROM covid_19;
-- find the month which is having maximum total confirmed cases;
SELECT YEAR(Date) AS year ,
       MONTH(Date) AS month ,
       SUM(Confirmed) AS total_confirmed_cases
FROM covid_19
GROUP BY year , month
ORDER BY total_confirmed_cases DESC;
-- find covid 19 spread with respect to death for each month (sum, avg, stddev,variance)
SELECT YEAR(Date) AS year , MONTH(Date) AS month,
SUM(Deaths) AS Total_Deaths,
     ROUND (AVG(Deaths),2) AS avg_deaths,
     ROUND (STDDEV(Deaths),2) AS stddev_deaths,
      ROUND(VARIANCE(Deaths),2) AS variance_deaths
FROM covid_19
GROUP BY year , month;
-- FIND the top 5 country having highest no. of recovered cases;
SELECT `Country/Region`, 
        SUM(Recovered) AS recovered_cases
FROM covid_19
GROUP BY `Country/Region`
ORDER BY recovered_cases DESC
LIMIT 5;
-- Find country having lowest number of death cases;
SELECT  `Country/Region`,
      SUM(Deaths) AS Total_deaths
FROM covid_19
GROUP BY  `Country/Region`
ORDER BY Total_deaths ASC
LIMIT 4;
-- other soluntion;
WITH ranking_country AS ( 
SELECT  `Country/Region`,
       SUM(Deaths) AS Total_deaths,
       RANK() OVER (ORDER BY SUM(Deaths) ASC) AS rank_no
FROM covid_19
GROUP BY  `Country/Region`)
SELECT `Country/Region` , Total_deaths
FROM ranking_country
WHERE rank_no = 1;
-- Find the recovery % for each country (recovered_cases/total_cases*100);
SELECT `Country/Region`,Total_case ,Total_recovered ,ROUND((Total_recovered/Total_case)*100,2) AS recovery_percentage FROM 
(SELECT `Country/Region`,
       SUM(Confirmed) AS Total_case,
       SUM(Recovered) AS Total_recovered
FROM covid_19
GROUP BY `Country/Region`) AS total_values
WHERE Total_case >=10000
GROUP BY `Country/Region`
ORDER BY recovery_percentage DESC;



