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