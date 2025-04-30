create database blinkit_Sales_db;


select * from blinkit_grocery_data;


-- EDA

alter table blinkit_grocery_data
change column `ï»¿Item Fat Content` Item_Fat_Content text ;

alter table blinkit_grocery_data
change column `Item Identifier`  Item_Identifier text ;

alter table blinkit_grocery_data
change column `Item Type`  Item_Type text ;

alter table blinkit_grocery_data
change column `Item Weight`  Item_Weight double ;

alter table blinkit_grocery_data
modify column Outlet_Establishment_Year int;

alter table blinkit_grocery_data
change column `Outlet Location Type`  Outlet_Location_Type text ;

describe blinkit_grocery_data;

-- KPI's

-- Total Sales/Avg sales/ No of items/ Avg Ratings

select * from blinkit_grocery_data;


select Concat("$ " ,round(sum(Sales),2)) as Total_Sales, 
	   round(avg(Sales),2) as Avg_Sales, 
       count(*) as No_of_Items,
       round(avg(Rating),2) as Avg_Rating from blinkit_grocery_data;
       
       
-- Fat content by Revnue

select Item_Fat_Content, sum(Sales) as Total_Sales from blinkit_grocery_data
				group by Item_Fat_Content;
                
                
-- Total revenue by item type
select Item_Type, sum(Sales) as Total_Sales from blinkit_grocery_data
				group by Item_Type;
                
-- Total revenue by outlet size
select Outlet_Size, sum(Sales) as Total_Sales from blinkit_grocery_data
				group by Outlet_Size;

-- Total revenue by outlet location

select Outlet_Location_Type, sum(Sales) as Total_Sales from blinkit_grocery_data
				group by Outlet_Location_Type;

-- Total revenue by outlet establishment year

select Outlet_Establishment_Year, sum(Sales) as Total_Sales from blinkit_grocery_data
				group by Outlet_Establishment_Year;
                
                
--  Get high-rated products (Rating ≥ 4):
SELECT * FROM blinkit_grocery_data
WHERE Rating >= 4;

--  Get items with visibility above 0.2:
SELECT * FROM blinkit_grocery_data
WHERE Item_Visibility > 0.2;


--  Top Selling Products

SELECT Item_Identifier, SUM(Sales) AS Total_Sales
FROM blinkit_grocery_data
GROUP BY Item_Identifier
ORDER BY Total_Sales DESC
LIMIT 10;


--  Best Performing Outlets

SELECT Outlet_Identifier, SUM(Sales) AS Total_Sales
FROM blinkit_grocery_data
GROUP BY Outlet_Identifier
ORDER BY Total_Sales DESC
LIMIT 5;

-- Product Type Demand
SELECT Item_Type, SUM(Sales) AS Total_Sales
FROM blinkit_grocery_data
GROUP BY Item_Type
ORDER BY Total_Sales DESC;


-- Fat Content Preference

SELECT Item_Fat_Content, COUNT(*) AS Num_Items, SUM(Sales) AS Total_Sales
FROM blinkit_grocery_data
GROUP BY Item_Fat_Content;


-- Rating vs Sales
SELECT Item_Type,Rating, AVG(Sales) AS Avg_Sales
FROM blinkit_grocery_data
GROUP BY Item_Type, Rating
ORDER BY Rating DESC;

--  Visibility and Weight Effect on Sales (basic correlation view)
SELECT 
  CASE 
    WHEN Item_Visibility < 0.05 THEN 'Low'
    WHEN Item_Visibility < 0.15 THEN 'Medium'
    ELSE 'High'
  END AS Visibility_Level,
  AVG(Sales) AS Avg_Sales
FROM blinkit_grocery_data
GROUP BY Visibility_Level;


