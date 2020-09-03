-- Creating tables for cash4covid
DROP TABLE IF EXISTS  naics_cat;
CREATE TABLE naics_cat (
     id VARCHAR, 
     cat VARCHAR,
     description VARCHAR,
     biz_count VARCHAR

);
DROP TABLE IF EXISTS  naics_desc;
CREATE TABLE naics_desc (     
	Code VARCHAR,
     	Title VARCHAR,
	Description VARCHAR
);

DROP TABLE IF EXISTS  banks_summary;
CREATE TABLE banks_summary (
    	Bank VARCHAR,
	Loan_Sum VARCHAR,
	Average_Loan VARCHAR,
	Median_Loan VARCHAR	
);

DROP TABLE IF EXISTS  category_summary;
CREATE TABLE category_summary (
    description VARCHAR,
	Jobs_Saved VARCHAR,
	Median_Loan VARCHAR,
	Average_Loan VARCHAR,
	Total_Loans VARCHAR
);

DROP TABLE IF EXISTS  non_profit_over_150k;
CREATE TABLE  non_profit_over_150k(
	Loan_Range VARCHAR,
	Name VARCHAR,
	Address VARCHAR, 
	City VARCHAR, 
	State VARCHAR,
	Zip VARCHAR, 
	NAICS_Code VARCHAR,
	Business_Type VARCHAR, 
	Race VARCHAR,
	Gender VARCHAR, 
	Veteran VARCHAR,
	Non_Profit VARCHAR,
	Jobs_Saved VARCHAR,
	Date VARCHAR,
	Bank VARCHAR, 
	NAICS_Category VARCHAR, 
	Title VARCHAR,
	description VARCHAR	
);

-- run to verify working
-- select * from naics_desc;
--  copied from csv 'Loan Amount', 'City', 'State', 'Zip', 'NAICS Code', 'Race', 'Gender', 'Veteran', 'Jobs Saved', 'Date', 'Bank', 'NAICS Category
DROP TABLE IF EXISTS  non_profit_under_150k;
CREATE TABLE  non_profit_under_150k(
	Loan_Amount VARCHAR, 
	City VARCHAR, 
	State VARCHAR,
	Zip VARCHAR, 
	NAICS_Code VARCHAR,
	Business_Type VARCHAR, 
	Race VARCHAR,
	Gender VARCHAR, 
	Veteran VARCHAR,
	Non_Profit VARCHAR,
	Jobs_Saved VARCHAR,
	Date VARCHAR,
	Bank VARCHAR,
FOREIGN KEY (NAICS_Code) REFERENCES naics_desc (Code)	
);

-- Creating tables for cash4covid
DROP TABLE IF EXISTS  over_150_for_sql;
--Loan_Range,Name,Address,City,State,Zip,NAICS_Code,Business_Type,Race,Gender,Veteran,Jobs_Saved,Date,Bank,NAICS_Category,description
CREATE TABLE  over_150_for_sql(
	Loan_Range VARCHAR,
	Name VARCHAR,
	Address VARCHAR, 
	City VARCHAR, 
	State VARCHAR,
	Zip VARCHAR, 
	NAICS_Code VARCHAR,
	Business_Type VARCHAR, 
	Race VARCHAR,
	Gender VARCHAR, 
	Veteran VARCHAR,
	Jobs_Saved VARCHAR,
	Date VARCHAR,
	Bank VARCHAR, 
	NAICS_Category VARCHAR, 
	description VARCHAR	
);
select * from over_150_for_sql;
-- select 5 from ver_150_for_sql;


-- select * from naics_desc;
--'Loan_Amount', 'City', 'State', 'Zip', 'NAICS_Code', 'Race', 'Gender', 'Veteran', 'Jobs_Saved', 'Date', 'Bank', 'NAICS_Category'
DROP TABLE IF EXISTS  under_150;
CREATE TABLE  under_150(
	Loan_Amount VARCHAR, 
	City VARCHAR, 
	State VARCHAR,
	Zip VARCHAR, 
	NAICS_Code VARCHAR,
	Race VARCHAR,
	Gender VARCHAR, 
	Veteran VARCHAR,
	Jobs_Saved VARCHAR,
	Date VARCHAR,
	Bank VARCHAR,
	NAICS_Category VARCHAR
);




