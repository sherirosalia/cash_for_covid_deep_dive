-- cast correct types non profit under 150 and largest table under 150
-- float
ALTER TABLE non_profit_under_150K ALTER COLUMN Loan_Amount TYPE float USING (trim(Loan_Amount)::double precision);
-- integer
ALTER TABLE non_profit_under_150K ALTER COLUMN Jobs_Saved  TYPE float USING Jobs_Saved::double precision;
ALTER TABLE non_profit_under_150K  ALTER COLUMN Jobs_Saved TYPE integer USING round(Jobs_Saved)::integer;
-- date
ALTER TABLE non_profit_under_150K ALTER COLUMN Date TYPE date USING TO_DATE(Date, 'MM/DD/YYYY');

-- cast correct types under 150 table
ALTER TABLE under_150 ALTER COLUMN Loan_Amount TYPE float USING (trim(Loan_Amount)::double precision);

ALTER TABLE under_150 ALTER COLUMN Jobs_Saved TYPE int USING (trim(Jobs_Saved)::integer);

ALTER TABLE under_150 ALTER COLUMN Date TYPE date USING TO_DATE(Date, 'YYYY/MM/DD');

-- make sure zipcode does not have leading zero characters
SELECT LENGTH(zip) FROM under_150 AS lengthofstring;
-- check that date is functioning properly
select jobs_saved, bank from non_profit_under_150K where date between '04/10/2020' AND '04/30/2020'

-- checking content
select * from banks_summary;

select * from category_summary;

select * from non_profit_under_150K limit 10;

--changing types in over 150k tables (no loan amounts)
-- non profit 
-- integer
ALTER TABLE non_profit_over_150K ALTER COLUMN Jobs_Saved  TYPE float USING Jobs_Saved::double precision;
ALTER TABLE non_profit_over_150K  ALTER COLUMN Jobs_Saved TYPE integer USING round(Jobs_Saved)::integer;
-- date
ALTER TABLE non_profit_over_150K ALTER COLUMN Date TYPE date USING TO_DATE(Date, 'YYYY/MM/DD');

-- check
select * from non_profit_over_150K limit 10;

-- for profit rename table
ALTER TABLE over_150_for_sql
RENAME TO over_150;

-- for profit rename table
ALTER TABLE non_profit_over_150K
RENAME TO np_over_150;
-- integer
ALTER TABLE over_150 ALTER COLUMN Jobs_Saved  TYPE float USING Jobs_Saved::double precision;
ALTER TABLE over_150  ALTER COLUMN Jobs_Saved TYPE integer USING round(Jobs_Saved)::integer;
-- date
ALTER TABLE over_150 ALTER COLUMN Date TYPE date USING TO_DATE(Date, 'YYYY/MM/DD');

-- check
select * from over_150 limit 10;

--ALTER TABLE over_150 ALTER COLUMN Date TYPE date USING (to_char(Date, 'YYYY/MM/DD'), 'MM/DD/YYYY');

SELECT to_char(over_150.Date,'MM/DD/YYYY') FROM over_150;


-- doing a few queries to make sure data looks good
-- check
select * from under_150 limit 10;

SELECT * FROM under_150
WHERE (date BETWEEN '2020-05-01' AND '2020-05-15')
AND race = 'Black or African American' 
AND gender = 'Female Owned'
AND loan_amount >= 100000.00
ORDER BY date ASC;

-- add index to tables as needed
ALTER TABLE under_150 ADD COLUMN id SERIAL PRIMARY KEY;

SELECT * FROM over_150 limit 15;


-- CREATE WASTE MANAGEMENT TABLE 
DROP TABLE IF EXISTS waste_management;
SELECT  city,  state, naics_code, naics_category
INTO waste_management
FROM over_150
WHERE naics_category ='56';

SELECT * FROM waste_management
WHERE state = 'NY'
limit 30;

-- waste management sliced from naics cat
SELECT * FROM naics_cat;
SELECT * 
FROM non_profit_under_150k 
AS nps 
WHERE LEFT(naics_code,2) = '56'

-- rename non profit tables, too long
ALTER TABLE non_profit_under_150k 
RENAME TO np_under

ALTER TABLE np_over_150
RENAME TO np_over;

-- new column
-- ALTER TABLE np_under DROP column n_cat;
-- UPDATE np_under
-- SET n_cat=substr(naics_code, 2, 2);

SELECT * FROM np_under LIMIT 5;

SELECT * FROM naics_desc;
SELECT * FROM naics_cat;

select * from under_150 limit 10;
select * from np_under limit 10;

-- find out racial values
SELECT DISTINCT race
FROM np_under;

-- set transaction for rollback
-- Transaction set
SELECT loan_amount, city, state, zip, bank, naics_code,  race, gender, veteran, date, naics_category  FROM under_150
WHERE state = 'AK' AND race = 'American Indian or Alaska Native'
UNION ALL
SELECT loan_amount, city, state, zip, bank, naics_code,  race, gender, veteran, date, n_cat FROM np_under
WHERE state = 'AK' AND race = 'American Indian or Alaska Native'
ORDER BY City DESC;

-- End transaction


-- Joining under150 and naics_cat tables
-- SELECT under_150.naics_category,
--      naics_cat.cat,
--      naics_cat.description
-- FROM naics_cat
-- FULL JOIN under_150
-- ON under_150.naics_category = naics_cat.cat;

-- CREATE TABLE u150_desc AS
-- (SELECT under_150.naics_category,
--      naics_cat.cat,
--      naics_cat.description
-- FROM naics_cat
-- LEFT JOIN under_150
-- ON under_150.naics_category = naics_cat.cat);

-- select * from  u150_desc limit 10;














