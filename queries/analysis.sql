-------------------
-- people analysis
-------------------

-----------------
-- gender 
-- women approximately 30%
-----------------

select count (*) from filtered_people;
-- results 1185708

select count (*) from filtered_people
where
gender='Female';
-- results: 253002

select count (*) from filtered_people
where
gender='Male';

-- results: 845968
------------------
-- race
------------------
-- value counts
select race, count(race)
from filtered_people
group by race;

-- race, combine some groups
select count (*) from filtered_people;
-- results 1185708
-- combine Black and African american
update filtered_people
set race = replace(race, 'Black or African American', 'Black')

-- combine Puerto Rican and Hispanic
update filtered_people
set race = replace(race, 'Puerto Rican', 'Hispanic')

-- native peoples
update filtered_people
set race = replace(replace(race, 'Eskimo Aleut', 'Native'), 'American Indian or Alaska Native', 'Native');


-- verified 
select race, count(race)
from filtered_people
group by race;



--------------------
-- veteran
--------------------

select count (*) from filtered_people
where
veteran='Veteran';
-- results 33753

--- add description to np_under

DROP TABLE IF EXISTS  np_u;
--add category descriptions
SELECT f.jobs_saved, f.date, f.bank, f.gender, f.veteran, f.race, f.city, f.state, f.n_cat, c.description
INTO np_u
FROM np_under as f
 	INNER JOIN naics_cat as c
	  ON(f.n_cat=c.cat);



SELECT * FROM np_u LIMIT 10;
SELECT COUNT (*) FROM np_u;
SELECT COUNT (*) FROM np_under;

DROP TABLE np_under;

ALTER TABLE np_u
RENAME TO np_under;


---------------------------------
-- massage, spas and related
--------------------------------

select * from under_150 limit 4;
select * from over_150 limit 4;

-- codes of interest:812112, 812112, 621399
-- words spa, massage, foot, reflexology, body
SELECT * 
FROM over_150 
WHERE name 
ILIKE any (array['%Massage%', '%Day Spa%', '%Foot Reflexology%', '%Reflexology%', '%Bodywork%'])
ORDER BY
state ASC,
city DESC;

SELECT * 
FROM under_150 
WHERE naics_code = any (array['621399', '812112', '812199' ])
ORDER BY
state ASC,
city DESC;

SELECT * 
FROM under_150 
WHERE naics_code = any (array['621399', '812112', '812199' ])
ORDER BY
state ASC,
city DESC;


----- count of massage / salon category for all loan amounts in city of san diego which comes close to 20k

SELECT (select count(*) from under_150 
		WHERE naics_code=ANY (array['621399', '812112', '812199' ])
		AND state ='CA') AS count1,
  (SELECT COUNT(*) FROM over_150 WHERE naics_code=ANY (array['621399', '812112', '812199'])) AS count2


  -----------------------------------------
  -- results are saved in csv files called 