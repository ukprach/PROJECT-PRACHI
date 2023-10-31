-- Database: Sales Data 

-- DROP DATABASE IF EXISTS "Sales Data ";

CREATE DATABASE "Sales Data "
    WITH
    OWNER = postgres
    ENCODING = 'UTF8'
    LC_COLLATE = 'English_United States.1252'
    LC_CTYPE = 'English_United States.1252'
    TABLESPACE = pg_default
    CONNECTION LIMIT = -1
    IS_TEMPLATE = False;

--1) Database creation 
Create table Sales_sample (Product_Id Int, Region Varchar(50), On_date Date, 
Sales_Amount Numeric);

--2) Data Creation
Insert into Sales_sample (Product_Id, Region, On_date, Sales_Amount) values 
('1', 'East', '2023-11-10', '20000'),
('2', 'West', '2023-08-19', '50000'),
('2', 'East', '2023-11-21', '40000'),
('3', 'North', '2023-07-20', '15000'),
('4', 'North', '2023-08-07', '45000'),
('2', 'South', '2023-08-24', '45000'),
('5', 'North', '2023-11-22', '20000'),
('5', 'West', '2023-11-11', '60000'),
('3', 'East', '2023-09-19', '50000'),
('1', 'West', '2023-09-29', '70000')
;
Select * from Sales_Sample;

--3) OLAP operations 
--a) Drill down 
Select Region, Product_Id, Sum(Sales_Amount) as Sales_Amount
From Sales_Sample
Group By 1,2
Order By Region, Product_Id, Sales_Amount;

--b) Roll Up
Select Region, Product_Id, Sum(Sales_Amount) as Sales_Amount
From Sales_Sample
Group By Rollup (1,2)
Order By Region;

--c) Cube 
Select Region, Product_Id, On_Date, Sum(Sales_Amount) as Sales_Amount
From Sales_Sample
Group By Cube (1,2,3)
Order By Region, Product_Id, On_Date, Sales_Amount;

--d) Slice 
Select Region, Product_Id, On_Date, Sum(Sales_Amount) as Sales_Amount
From Sales_Sample
Where Region in('North', 'South') OR On_Date between To_date('2023-08-20','YYYY-MM-DD') And To_Date('2023-10-20','YYYY-MM-DD') 
Group By 1,2,3
Order By Region, Product_Id, On_Date, Sales_Amount;

--e) Dice 
Select Region, Product_Id, On_Date, Sum(Sales_Amount) as Sales_Amount
From Sales_Sample
Where Region in('North', 'South') AND Product_Id IN (1,2) AND On_Date between To_date('2023-08-20','YYYY-MM-DD') And To_Date('2023-10-20','YYYY-MM-DD') 
Group By 1,2,3
Order By Region, Product_Id, On_Date, Sales_Amount;