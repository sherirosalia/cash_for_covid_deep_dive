
----------------------------------------------------------------------
-- loans over 150 union of non profit with for profit businesses
----------------------------------------------------------------------

SELECT * FROM over_150 LIMIT 10;
SELECT * FROM np_over LIMIT 10;
SELECT COUNT(*) FROM over_150;
-- 653108
SELECT COUNT(*) FROM np_over;
-- 42074

-- add category column to non profit table
ALTER TABLE np_over
ADD COLUMN n_cat VARCHAR;
UPDATE np_over 
SET n_cat =SUBSTRING(naics_code, 1,2)

-- add category column to over150 table
ALTER TABLE over_150
ADD COLUMN n_cat VARCHAR;
UPDATE over_150 
SET n_cat =SUBSTRING(naics_code, 1,2)


SELECT DISTINCT race FROM np_over;

SELECT DISTINCT race FROM over_150;

SELECT * FROM under_150 LIMIT 10;

DROP TABLE IF EXISTS lgl;
CREATE TABLE lgl
AS
SELECT loan_range, name, address, city, state, zip, 
naics_code, race, gender, veteran, jobs_saved, date, bank, naics_category, n_cat
FROM over_150
UNION ALL
SELECT loan_range, name, address, city, state, zip, 
naics_code, race, gender, veteran, jobs_saved, date, bank, naics_category, n_cat
FROM np_over



-- add value counts to verify no data loss
select * from lgl limit 10;
SELECT COUNT(*) FROM lgl;
-- 695182

SELECT DISTINCT race FROM lgl;
SELECT DISTINCT veteran FROM lgl;
SELECT DISTINCT gender FROM lgl;
UPDATE lgl SET race ='Eskimo' where race= 'Eskimo Aleut';
UPDATE lgl SET race ='Black' where race= 'Black or African American';
UPDATE lgl SET veteran ='Veteran' where veteran='Veteran-Owned';
UPDATE lgl SET veteran ='Not Veteran' where veteran='Non-Veteran';
UPDATE lgl SET gender ='Female' where gender= 'Female Owned';
UPDATE lgl SET gender ='Male' where gender= 'Male Owned';

select * from lgl where gender = 'Female' limit 10;

----------------------------------------------------------------------
-- loans under 150 union of non profit with for profit businesses
----------------------------------------------------------------------

SELECT * FROM np_under LIMIT 10;
UPDATE np_under 
SET n_cat =SUBSTRING(naics_code, 1,2)

SELECT DISTINCT race FROM np_under;

select distinct race FROM under_150;

SELECT * FROM under_150 LIMIT 10;

DROP TABLE IF EXISTS sml;
CREATE TABLE sml
AS
SELECT loan_amount, city, state, zip, naics_code, race, gender, veteran, jobs_saved, date, bank, naics_category
FROM under_150
UNION ALL
SELECT loan_amount, city, state, zip, naics_code, race, gender, veteran, jobs_saved, date, bank, n_cat
FROM np_under



-- add value counts to verify no data loss
select * from sml limit 10;
-- 4093088
SELECT COUNT(*) FROM under_150;
-- 139179
SELECT COUNT(*) FROM np_under;
-- 4232267
SELECT COUNT(*) FROM sml;

SELECT DISTINCT race FROM sml;
SELECT DISTINCT veteran FROM sml;
SELECT DISTINCT gender FROM sml;
UPDATE sml SET race ='Eskimo' where race= 'Eskimo Aleut';
UPDATE sml SET race ='Black' where race= 'Black or African American';
UPDATE sml SET veteran ='Veteran' where veteran='Veteran-Owned';
UPDATE sml SET veteran ='Not Veteran' where veteran='Non-Veteran';
UPDATE sml SET gender ='Female' where gender= 'Female Owned';
UPDATE sml SET gender ='Male' where gender= 'Male Owned'

select * from sml where gender = 'Female' limit 10;

----------------------------------------------------------------------
-- union of loans under 150 and over 150 
-- filtered for responses in the race, veteran and gender columns
-- no loan info 
-- produces csv file called "filtered_people.csv"
----------------------------------------------------------------------

-- take a look at table structures
SELECT * FROM lgl LIMIT 10;
SELECT * FROM sml LIMIT 10;
SELECT * FROM naics_cat;


DROP TABLE IF EXISTS  people;
--add category descriptions
CREATE TABLE people
AS
SELECT l.jobs_saved, l.date, l.bank, l.gender, l.veteran, l.race, l.city, l.state, l.n_cat 
	FROM lgl as l
UNION ALL
SELECT s.jobs_saved, s.date, s.bank, s.gender, s.veteran, s.race, s.city, s.state, s.naics_category
	FROM sml as s;
	
DROP TABLE IF EXISTS  filtered_people;
--add category descriptions
SELECT f.jobs_saved, f.date, f.bank, f.gender, f.veteran, f.race, f.city, f.state, f.n_cat 
INTO filtered_people
FROM people as f
 	LEFT JOIN naics_cat as c
	  ON(f.n_cat=c.cat)
WHERE race != 'Unanswered'
OR veteran != 'Unanswered'
OR gender != 'Unanswered';

SELECT * FROM filtered_people LIMIT 10;
SELECT COUNT (*) FROM filtered_people;




