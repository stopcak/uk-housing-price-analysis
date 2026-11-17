
create database Uk_Housing

use Uk_Housing


create table Data (
    Transaction_ID varchar(255),
    Price varchar(255),
    Date varchar(255),
    Postcode varchar(255),
    Property_Type varchar(255),
    Old_New varchar(255),
    Duration varchar(255), 
    PAON varchar(255),
    SAON varchar(255),
    Street varchar(255),
    Locality varchar(255),
    Town varchar(255),
    District varchar(255),
    County varchar(255),
    PPD_Type varchar(255),
    Record_Status varchar(255)
)

BULK INSERT Data
FROM '/var/opt/mssql/data/pp-2018.csv'
WITH (FIELDTERMINATOR = ',', ROWTERMINATOR = '0x0a', FIELDQUOTE = '"', FIRSTROW = 1)

BULK INSERT Data
FROM '/var/opt/mssql/data/pp-2019.csv'
WITH (FIELDTERMINATOR = ',', ROWTERMINATOR = '0x0a', FIELDQUOTE = '"', FIRSTROW = 1)

BULK INSERT Data
FROM '/var/opt/mssql/data/pp-2020.csv'
WITH (FIELDTERMINATOR = ',', ROWTERMINATOR = '0x0a', FIELDQUOTE = '"', FIRSTROW = 1)

BULK INSERT Data
FROM '/var/opt/mssql/data/pp-2021.csv'
WITH (FIELDTERMINATOR = ',', ROWTERMINATOR = '0x0a', FIELDQUOTE = '"', FIRSTROW = 1)

BULK INSERT Data
FROM '/var/opt/mssql/data/pp-2022.csv'
WITH (FIELDTERMINATOR = ',', ROWTERMINATOR = '0x0a', FIELDQUOTE = '"', FIRSTROW = 1)

BULK INSERT Data
FROM '/var/opt/mssql/data/pp-2023.csv'
WITH (FIELDTERMINATOR = ',', ROWTERMINATOR = '0x0a', FIELDQUOTE = '"', FIRSTROW = 1)

BULK INSERT Data
FROM '/var/opt/mssql/data/pp-2024.csv'
WITH (FIELDTERMINATOR = ',', ROWTERMINATOR = '0x0a', FIELDQUOTE = '"', FIRSTROW = 1)

BULK INSERT Data
FROM '/var/opt/mssql/data/pp-2025.csv'
WITH (FIELDTERMINATOR = ',', ROWTERMINATOR = '0x0a', FIELDQUOTE = '"', FIRSTROW = 1)

BULK INSERT Data
FROM '/var/opt/mssql/data/pp-2026.csv'
WITH (FIELDTERMINATOR = ',', ROWTERMINATOR = '0x0a', FIELDQUOTE = '"', FIRSTROW = 1)

UPDATE Data SET Price = REPLACE(Price, '"', '')
UPDATE Data SET Date = REPLACE(Date, '"', '')
UPDATE Data SET County = REPLACE(County, '"', '')
UPDATE Data Set Property_Type = Replace(Property_Type, '"', '')

select top 5 *
from data


-- What is the average property price per year?
select avg(CAST(price AS bigint)) as price, year(CAST(date AS datetime)) as years
from data
group by year(CAST(date AS datetime))

--Which counties have the highest average property price? (top 10)
select top 10 county, avg(cast(price as bigint)) as Average_Price
from data
group by county
having count(*) > 100
order by Average_Price desc

-- What is the average price by property type? (excluding type O)
select Property_Type, avg(cast(price as bigint)) Average_Price
from data
where not Property_Type = 'O'
group by Property_Type

-- Which month has the most property sales?
select MONTH(cast(date as datetime)) Month, count(date) as number_of_sales
from data
group by MONTH(cast(date as datetime)) 
order by number_of_sales desc

--How does average price in Greater London compare to the rest of the UK?
select avg(cast(price as bigint)) as LONDON
from data
where county = 'GREATER LONDON'

select avg(cast(price as bigint)) as REST_OF_UK
from data
where not county = 'GREATER LONDON'


