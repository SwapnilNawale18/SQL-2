--Day 14

--Alias
select BusinessEntityID 'Employee ID',
Gender,
JobTitle as 'Designation',
'Total Leave' = VacationHours
from HumanResources.Employee;

--unique touples
select distinct JobTitle
from HumanResources.Employee;

--not null
select *
from Sales.SalesOrderHeader
where PurchaseOrderNumber is not null

--AND | ORDER BY
select BusinessEntityID,
Gender,
JobTitle,
VacationHours
from HumanResources.Employee
where VacationHours>=50 and VacationHours <=70
order by VacationHours asc;--asc is default so no need to specify

-- ORDER BY DESC
select BusinessEntityID,
Gender,
JobTitle,
VacationHours
from HumanResources.Employee
where VacationHours>=50 and VacationHours <=70
order by 4 desc;--POSITION NUMBER CAN BE USED WITH ORDER BY

--ALIAS CAN ALSO BE USED WITH ORDER BY
select BusinessEntityID,
Gender,
JobTitle,
VacationHours 'Designation'
from HumanResources.Employee
where VacationHours>=50 and VacationHours <=70
order by Designation desc;

--OR
select BusinessEntityID,
Gender,
JobTitle,
VacationHours
from HumanResources.Employee
where JobTitle = 'Tool Designer' or JobTitle = 'Design Engineer'

--AGGRIGATE FUNCTIONS
select SUM(VacationHours),
AVG(VacationHours),
MAX(VacationHours),
MIN(VacationHours),
COUNT(*)--Any Column name can be specified here instead of *
from HumanResources.Employee;

--FETCH ONLY TOP/INITIAL 3 RECORDS
select top 3 *
from HumanResources.Employee;

--FETCH ONLY TOP/INITIAL 3 RECORDS WITH ORDER BY
select top 3 *
from HumanResources.Employee
order by VacationHours;

--FETCH ONLY TOP/INITIAL 3 RECORDS WITH ORDER BY DESC
select top 6 *
from HumanResources.EmployeePayHistory
order by Rate desc;
--Fetches top 6 vacation hours

--TIES
select top 6 with ties *--ties tie the last repeted value
from HumanResources.EmployeePayHistory
order by Rate desc;

--RANGE OPERATOR: BETWEEN | NOT BETWEEN
select BusinessEntityID,
Gender,
JobTitle,
VacationHours
from HumanResources.Employee
where VacationHours between 50 and 70;--not between | will give vacation hours other than range between 50 & 70

--IN | NOT IN
select BusinessEntityID,
Gender,
JobTitle,
VacationHours
from HumanResources.Employee
where JobTitle in('Tool Designer','Design Engineer')--not in | will give JobTitle other than 'Tool Designer' or 'Design Engineer'
order by JobTitle;

-- like | pattern matching | search | %
select BusinessEntityID,
JobTitle,
BirthDate
from HumanResources.Employee
where JobTitle like 'C%r';-- % | represents 1 or more harecters | _ | represents only 1 charecters

--long cut of previous query
select BusinessEntityID,
JobTitle,
BirthDate
from HumanResources.Employee
where JobTitle like 'C%' and JobTitle like '%r';

--[-] | Range of charecters
select BusinessEntityID,
JobTitle,
BirthDate
from HumanResources.Employee
where JobTitle like '[H-Z]%'--range of Job titles starting from H to Z
order by JobTitle desc;

-- Jobtitle ends with ion
select *
from HumanResources.Employee
where JobTitle like '%ion'

--Jobtitle containing cru(any position)
select *
from HumanResources.Employee
where JobTitle like '%cru%'

-- jobtitle first letter S , fifth letter k (2,3,4 and 6th onwards are missing)
select *
from HumanResources.Employee
where JobTitle like 'S___k%'

--UPPER()
select UPPER(JobTitle)
from HumanResources.Employee;

--LOWER()
select LOWER(JobTitle)
from HumanResources.Employee;

--SUBSTRING()
select SUBSTRING('Richard', 4, 4);-- RETURNS PART OF STRING IT ACCEPTS STRING, Starting from, Num of Chars

--RIGHT()
select RIGHT('Richard', 4); --RIGHT | RETURNS NUM OF CHARECTERS (here 4) FROM RIGHT

--LEFT()| LEN() | +
select UPPER(LEFT(JobTitle,1)) + LOWER(SUBSTRING(JobTitle, 2, len(JobTitle)))
from HumanResources.Employee;
--LEFT()| RETURNS NUM OF CHARECTERS (here 1) FROM LEFT
--LEN() | RETURNS LENGTH OF STRING
-- + | USED TO CONCAT 2 STRINGS

-- SPACE()
select 'Swapnil'+SPACE(1)+'Nawale';--Gives Number of spaces depending on parameter

--SET COMPATIBILITY
alter database AdventureWorks2012 set compatibility_level=110;--alters database compatibility_level
--Valid values of the database compatibility level are 90, 100, or 110.

--OFFSET | retriving records form perticular position
select *
from HumanResources.Employee
order by BusinessEntityID
offset 7 rows--ignores first rows(here 7)
fetch next 5 rows only;-- fetch fatches next (here 5) rows

--CONCAT() | DATENAME() | YEAR()
select BusinessEntityID,
BirthDate,
Gender,
HireDate,
CONCAT(--CONCATINATES 2 or more strings or values irrespective of data tye
	DATENAME(mm, HireDate),--CAN EXTRACT DATE OR MONTH OR YEAR (here MONTH)
	', ',
	YEAR(HireDate))--Extracts year from date
from HumanResources.Employee;
-- + |Conversion failed when converting the nvarchar value 'February' to data type int.

--DAY()MONTH() | same example using convert
select BusinessEntityID,
BirthDate,
Gender,
HireDate,
DAY(HireDate),--EXTRACTS DAY FROM PERTICULAR DATE
MONTH(HireDate),--EXTRACTS MONTH FROM PERTICULAR DATE
DATENAME(YYYY, HireDate)--CAN EXTRACT DATE OR MONTH OR YEAR (here YEAR)
from HumanResources.Employee;

--CONVERT() | same example using convert
select BusinessEntityID,
BirthDate,
Gender,
HireDate,
DATENAME(mm, HireDate) +
', '+
CONVERT(varchar(4) ,YEAR(HireDate))--CONVERT() | Converts data to specified data type
from HumanResources.Employee;


--DB_ID()
select DB_ID('AdventureWorks2012');--SHOWS DATABASE ID

--OBJECT_ID()
select OBJECT_ID('HumanResources.Employee');--SHOWS OBJECT ID

--HOST_ID()
select HOST_ID();--SHOWS HOST ID

--GETDATE()
select GETDATE()--RETURNS SYSTEM DATE & TIME

--DATEDIFF()
select BusinessEntityID,
HireDate,
DATEDIFF(yy,HireDate, GETDATE()) 'Number of Years'--CALCULATES DIFFERENCE BETWEEN DATES
from HumanResources.Employee;
--here we've calculated number of years from joining till date

--ROUND() | FLOOR() | CEILING()
select Rate,
ROUND(Rate,2) 'Round',--ROUND() | Round off to perticular value(here 2)
FLOOR(Rate) 'smallest integer',--FLOOR() | Round off to lower Int
CEILING(Rate) 'Largest integer'--CEILING() | Round off to upper Int
from HumanResources.EmployeePayHistory;

-- GROUP BY
select JobTitle,--NON-AGGRIGATE fn()
COUNT(JobTitle)--AGGRIGATE fn()
from HumanResources.Employee--AGGRIGATE fn() cannont be used with NON-AGGRIGATE fn()
group by JobTitle;--but group by allows 1 aggrigate & 1 non aggrigate fn() --GROUP BY | groups the similar data in touple
--we can mention the only columns in the select clause which is present in the group by field.
--calculates number of number of each job titles

--GROUP BY with WHERE | EXECUTION SEQUENCE
select PayFrequency,						--3
SUM(Rate) 'Sum'								--3.5
from HumanResources.EmployeePayHistory		--1
where Rate > 10								--2
group by PayFrequency;						--4
--calculates sum of rate of each pay frequency