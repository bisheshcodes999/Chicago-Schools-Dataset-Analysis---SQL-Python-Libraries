-- Declaring which schema database that we are using right now 
USE data_exploration;

-- Viewing all the records of the dataset along with the field -> for table chicago_schools ( IMPORTED DATA )
SELECT * 
FROM chicago_schools;

-- Checking the total number of rows(records) from the given dataset
 
SELECT COUNT(*)
FROM chicago_schools;
-- There are about 391 records in the given dataset

DESCRIBE chicago_schools;
-- we can observe that the phone number field of the given dataset is in text but i think should be in INT
-- Different scores for the students and the schools are some in INT and some in TEXT, so filtering and chagning all the scores to INT 

-- Checking what fields of the given dataset holds what kinds of values in it 
DESCRIBE chicago_schools;

-- Analyzing the distinct values for each records from the given table 
SELECT DISTINCT school_name as School_Names
FROM chicago_schools
ORDER BY School_Names DESC;

SELECT DISTINCT `Elementary, Middle, or High School` as School_Types
FROM chicago_schools
ORDER BY School_Types DESC;
-- it basically contains 3 types of elementary schools in the given dataset -> middle schools, high schools, elemetary schools 

SELECT DISTINCT(Leaders_Icon), COUNT(Leaders_Icon)
FROM chicago_schools
GROUP BY Leaders_Icon;
-- Hence only 1 unique attribute for the table Leaders_Icon can be found and that is Weak type 

SELECT community_area_name, COUNT(*) AS school_count
FROM chicago_schools
GROUP BY community_area_name
ORDER BY school_count DESC
LIMIT 1;
-- This indicates that the MAX number of the school that has the community area name SOUTH LAWINDLE is 16 and is the most in chicago

SELECT community_area_name, COUNT(*) AS school_count
FROM chicago_schools
GROUP BY community_area_name
ORDER BY school_count
LIMIT 1;
-- This indicates that the MIN number of the school counts having the community area under it name FULLER PARK is 1 which is the minimum 
-- But the school_count for the given community area under the schools valued 1 will be many HENCE filtering according to the max and min for a clear representation

-- UNION -> for unifying the max and min count for the given school counts having community and its name under it 

(SELECT community_area_name, COUNT(*) AS school_counts, 'Highest' AS Category
FROM chicago_schools
GROUP BY community_area_name
ORDER BY school_counts DESC
LIMIT 1)
UNION
(SELECT community_area_name, COUNT(*) AS school_counts, 'Lowest' AS Category
FROM chicago_schools
GROUP BY community_area_name
ORDER BY school_counts ASC
LIMIT 1);

-- The above lines of code -> help of UNION helps me retrieve the datas of the school counts under specific community area name 

SELECT *
FROM chicago_schools;
-- Basic description of the table was analyzed 
-- Sequentially, different aspects of the given dataset was considered and generalized



-- 2nd phase CASE -> Altering the various fields and changing the dtypes of the given feild value accordingly
-- Changing the field names of the given field of the dataset from LOWER to UPPER ... ... etc
SELECT *
FROM chicago_schools;
-- Changing and re-arranging the field names of the given dataset from our table to same cases ( snake_case ) strings 
-- updating the given name of the school that we just set in the given dataset 
-- changing the name of the school to `snake case`
ALTER TABLE chicago_schools
RENAME COLUMN school_Name TO school_name;
-- for healthy school certified field 
ALTER TABLE chicago_schools
RENAME COLUMN HEALTHY_SCHOOL_CERTIFIED to healthy_school_certified;
-- for other different fields containing the UPPER CASES in names 
ALTER TABLE chicago_schools
RENAME COLUMN SAFETY_SCORE to safety_score;

ALTER TABLE chicago_schools
RENAME COLUMN AVERAGE_STUDENT_ATTENDANCE to average_stu_attendance;

ALTER TABLE chicago_schools
RENAME COLUMN COLLEGE_ENROLLMENT to college_enrollment;

ALTER TABLE chicago_schools
RENAME COLUMN X_COORDINATE to x_axis;

ALTER TABLE chicago_schools
RENAME COLUMN Y_COORDINATE to y_axis;

ALTER TABLE chicago_schools
RENAME COLUMN COMMUNITY_AREA_NUMBER to community_area_number;

ALTER TABLE chicago_schools
RENAME COLUMN COMMUNITY_AREA_NAME to community_area_name;

ALTER TABLE chicago_schools
RENAME COLUMN Net_Change_EXPLORE_and_PLAN to net_change_explore_and_plan;

ALTER TABLE chicago_schools
RENAME COLUMN Collaborative_Name to collaborative_name;

ALTER TABLE chicago_schools
RENAME COLUMN `Elementary, Middle, or High School` to Types_of_school;

-- Changing the given name of the different fields used in the given dataset so that its easier to visualize and read it in the exploration phase 

ALTER TABLE chicago_schools
RENAME COLUMN College_Eligibility__ TO College_Eligibility;

ALTER TABLE chicago_schools
RENAME COLUMN Graduation_Rate__ TO Graduation_Rate;

ALTER TABLE chicago_schools
RENAME COLUMN College_Enrollment_Rate__ TO College_Enrollment_Rate;

ALTER TABLE chicago_schools
RENAME COLUMN Freshman_on_Track_Rate__ TO Freshman_on_Track_Rate;

ALTER TABLE chicago_schools
RENAME COLUMN Students_Passing__Algebra__ TO Students_Passing__Algebra;

ALTER TABLE chicago_schools
RENAME COLUMN Students_Taking__Algebra__ TO Students_Taking__Algebra;

ALTER TABLE chicago_schools
RENAME COLUMN ISAT_Exceeding_Reading__ TO ISAT_Exceeding_Reading;

ALTER TABLE chicago_schools
RENAME COLUMN ISAT_Exceeding_Math__ TO ISAT_Exceeding_Math;

ALTER TABLE chicago_schools RENAME COLUMN Adequate_Yearly_Progress_Made_ TO Adequate_Yearly_Progress_Made;
ALTER TABLE chicago_schools RENAME COLUMN Pk_2_Literacy__ TO Pk_2_Literacy;
ALTER TABLE chicago_schools RENAME COLUMN Pk_2_Math__ TO Pk_2_Math;
ALTER TABLE chicago_schools RENAME COLUMN Gr3_5_Grade_Level_Math__ TO Gr3_5_Grade_Level_Math;
ALTER TABLE chicago_schools RENAME COLUMN Gr3_5_Grade_Level_Read__ TO Gr3_5_Grade_Level_Read;
ALTER TABLE chicago_schools RENAME COLUMN Gr3_5_Keep_Pace_Read__ TO Gr3_5_Keep_Pace_Read;
ALTER TABLE chicago_schools RENAME COLUMN Gr3_5_Keep_Pace_Math__ TO Gr3_5_Keep_Pace_Math;
ALTER TABLE chicago_schools RENAME COLUMN Gr6_8_Grade_Level_Math__ TO Gr6_8_Grade_Level_Math;
ALTER TABLE chicago_schools RENAME COLUMN Gr6_8_Grade_Level_Read__ TO Gr6_8_Grade_Level_Read;
ALTER TABLE chicago_schools RENAME COLUMN Gr6_8_Keep_Pace_Math_ TO Gr6_8_Keep_Pace_Math;
ALTER TABLE chicago_schools RENAME COLUMN Gr6_8_Keep_Pace_Read__ TO Gr6_8_Keep_Pace_Read;
ALTER TABLE chicago_schools RENAME COLUMN Rate_of_Misconducts__per_100_students_ TO Rate_of_Misconducts_per_100_students;
ALTER TABLE chicago_schools RENAME COLUMN Gr_8_Explore_Math__ TO Gr_8_Explore_Math;
ALTER TABLE chicago_schools RENAME COLUMN Gr_8_Explore_Read__ TO Gr_8_Explore_Read;


-- Hence all the required fields from the given dataset has been renamed and reassigned with the new name for the given column
-- community area name, collaborative_name fields -> field values are in upper case so change it to snake case strings ie LOWER

SELECT Collaborative_Name
FROM chicago_schools;

UPDATE chicago_schools
SET Collaborative_Name = CONCAT(
    UPPER(LEFT(TRIM(Collaborative_Name), 1)),   
    LOWER(SUBSTRING(TRIM(Collaborative_Name), 2)) 
);

UPDATE chicago_schools
SET community_area_name = CONCAT(
    UPPER(LEFT(TRIM(community_area_name), 1)),   
    LOWER(SUBSTRING(TRIM(community_area_name), 2)) 
);

-- also updating for the community area name 

UPDATE chicago_schools
SET community_area_name = LOWER(TRIM(community_area_name));

SELECT community_area_name 
FROM chicago_schools;
-- Describing the different fields of the dataset
DESCRIBE chicago_schools;

UPDATE chicago_schools
SET `Elementary, Middle, or High School` = CASE
	WHEN `Elementary, Middle, or High School` = 'ES' THEN 'Elementary School'
    WHEN `Elementary, Middle, or High School` = 'HS' THEN 'High School'
    WHEN `Elementary, Middle, or High School` = 'MS' THEN 'Middle Level School'
    ELSE `Elementary, Middle, or High School`
END;
-- the last line ELSE `elemen.....` generally does nothing but whenver a null or non elementary values come in the field, it ignores it rather than calling it null value 

-- Hence all the required fields and their values has been cleaned and the 2nd phase DATA CLEANING AND ORGANIZING HAS BEEN COMPLETED....


-- 3rd PHASE of the Data explorations of the given chicago school dataset

-- Checking if there are null values in the given dataset and then using the COALESCE function to repalce or remove the null values from the given dataset
CREATE VIEW everything AS 
SELECT * 
FROM chicago_schools;

SELECT *
FROM chicago_schools
	WHERE Phone_Number IS NULL
    OR  Link IS NULL
    OR  Adequate_Yearly_Progress_Made_ IS NULL
    OR  safety_score IS NULL
    OR  Family_Involvement_Score IS NULL
    OR  Environment_Score IS NULL
    OR  Instruction_Icon IS NULL
    OR  Teachers_Score IS NULL
    OR  average_stu_attendance IS NULL
    OR  Graduation_Rate__ IS NULL;
-- All the fields of the given datasets are compeltely unique/filled with values and doesnt consist of any NULL values in it 
-- Checking with the CASE statements for the null values -> best method for the SQL procedures


SELECT COUNT(*) AS total_rows,
	SUM(CASE WHEN ZIP_Code IS NULL THEN 1 ELSE 0 END) as Missing_ZipCodes,
	SUM(CASE WHEN State IS NULL THEN 1 ELSE 0 END) as Missing_State,
	SUM(CASE WHEN Phone_Number IS NULL THEN 1 ELSE 0 END) as Missing_Phone_Number,
	SUM(CASE WHEN School_ID IS NULL THEN 1 ELSE 0 END) as Missing_School_ID,
    SUM(CASE WHEN Network_Manager IS NULL THEN 1 ELSE 0 END) as Missing_Network_Manager,
    SUM(CASE WHEN safety_score IS NULL THEN 1 ELSE 0 END) as Missing_SAFETY_SCORE
FROM chicago_schools;
-- checking for any possible missing values for the given columns by SUM method


SELECT * FROM chicago_schools;
-- 1st Extraction (exploration of data) -> School types and their counts
-- Checking for the differnet value counts of the given field of schools -> ES,HS,MS
DROP VIEW school_type_count;
CREATE VIEW school_type_count AS
SELECT Types_of_school, COUNT(*) as total_counts
FROM chicago_schools
GROUP BY 1;
-- Hence the ratio of the elemetary school is extremely large than the count for the high school and middle level schools 
-- Here middle level schools being the least in count and elementary schools being the highest in count 

-- Checking the safety scores of the schools along with their types 
SELECT Types_of_school
FROM chicago_schools;

SELECT * FROM chicago_schools;

-- Checking the frequency of the healthy certified schools along with their types for our city 

CREATE VIEW healthy_school AS 
SELECT Types_of_school, COUNT(healthy_school_certified = 'Yes') as Healthy_schools
FROM chicago_schools
WHERE healthy_school_certified = 'Yes'
GROUP BY Types_of_school;

SELECT Types_of_school, healthy_school_certified, COUNT(healthy_school_certified)
FROM chicago_schools
WHERE healthy_school_certified = 'Yes'
GROUP BY Types_of_school;

SELECT COUNT(*) as total_health_certified
FROM chicago_schools
WHERE healthy_school_certified = 'Yes';
-- Indicates that the total number of healthy certified schools are 12 , among which largest being ES ie with the total frequency of 10 schools

-- Dropping the column Links as it is absolutely not required by the given dataset and also for the further analysis 
ALTER TABLE chicago_schools
DROP Link;
-- Report: Which Zip Code has the most schools in that area?
-- By zip codes -> we can refer to the city chicago and their schools and use the zip codes to calculate the number of schools 

CREATE VIEW school_types AS 
SELECT Types_of_school, COUNT(*) as count_of_schools
FROM chicago_schools
GROUP BY Types_of_school;
-- Calculating the frequency of different kinds of school along with their count from the dataset


 -- CALCULATION WITH RESEPECT TO THE ZIP CODE OF THE VARIOUS SCHOOLS
 
 
CREATE VIEW zip_performance_summary AS 
SELECT ZIP_Code , COUNT(*) AS school_counts
FROM chicago_schools
GROUP BY ZIP_Code
ORDER BY school_counts DESC;
-- Here the zipcode for 60623 refers to the south side of the chicago hence south side has most number of schools 

CREATE VIEW cleaned_chicago_schools AS
SELECT School_ID, school_name, ZIP_Code
FROM chicago_schools
WHERE Types_of_school = 'Elementary School';

-- From the above zip codes of the schools, we can generate which zip codes with the most number of schools in that region 
-- Here we can order the given zip codes along with their schools frequency in descending to get the highest frequency first


-- Plotting the given data for the ZIP code of chicago along with the frequency of schools it hold
CREATE VIEW zip_school_counts AS
SELECT ZIP_Code, COUNT(*) AS Schools_Per_Zip
FROM chicago_schools
GROUP BY ZIP_Code 
HAVING Schools_Per_Zip > 15
ORDER BY Schools_Per_Zip DESC;
-- From the above query it is clear that the zip code 60623 holds most number of schools
-- Can be also termed as 'School-Heavy' data anaylsis

-- From the zip code , generating the given datas for the schools in the respective zip codes that has healthy schools 

SELECT ZIP_Code,
	   SUM(CASE WHEN healthy_school_certified = 'Yes' THEN 1 ELSE 0 END) as healthy_schools,
       ROUND(SUM(CASE WHEN healthy_school_certified = 'Yes' THEN 1 ELSE 0 END) * 100.00 / COUNT(*), 2) as healthy_rate 
FROM chicago_schools
GROUP BY ZIP_Code
HAVING healthy_rate  > 5
ORDER BY healthy_rate DESC;

-- Creating view for the basic plot of the given data
CREATE VIEW zip_healthy AS
SELECT ZIP_Code,
		SUM(CASE WHEN healthy_school_certified = 'Yes' THEN 1 ELSE 0 END) as Healthy_schools
FROM chicago_schools
GROUP BY ZIP_Code
HAVING Healthy_schools > 1
ORDER BY Healthy_schools DESC;
-- By the above query we can see that the Zip code 60608 has highest number of healthy schools being 3
-- Maximum number of zip codes -> schools generally has low healthy schools hence it is quite unsafe for the students studying in Chicago state
-- Zip Codes -> 60608 60622 60632 -->> are the region with safe scores and considered healthy

-- Cross checking for the zip code -> 60608
SELECT ZIP_Code , COUNT(*) AS number_of_schools
FROM chicago_schools
WHERE ZIP_Code = '60608'
GROUP BY ZIP_Code;

-- Now checking the healthy school certified for same region
-- using case sum for the health certified schools as values in yes or no
SELECT ZIP_Code ,
        SUM(CASE WHEN healthy_school_certified = 'No' THEN 1 ELSE 0 END) as total_unhealthy_count
FROM chicago_schools
WHERE ZIP_Code = '60608'
GROUP BY ZIP_Code;
-- The above is the total count for the unhealthy school counts for the given ZIP code 
-- Hence there are 3 healthy and 9 unhealthy scored schools in the respective 60608 Zip Code

-- Another essential data insights we can report is :
-- Taking the average safety score for the zip codes and then checking number of schools for that zip code
CREATE VIEW average_safety_zip AS
SELECT ZIP_Code,
	   COUNT(*) AS	number_of_schools,
	   ROUND(AVG(safety_score), 2) AS average_safety_zip
FROM chicago_schools
GROUP BY ZIP_Code
HAVING number_of_schools > 3
ORDER BY number_of_schools DESC;

-- Interpretation of the average_safety_zip code values for the given dataset according to the highest average safety scores 
-- Even the region having 1-3 schools might have safe schools which is important markings

CREATE VIEW highest_average_safety_zip AS
SELECT ZIP_Code,
	   COUNT(*) AS	number_of_schools,
	   ROUND(AVG(safety_score), 2) AS average_safety_zip
FROM chicago_schools
GROUP BY ZIP_Code
HAVING average_safety_zip BETWEEN 75.00 AND 90.00
ORDER BY average_safety_zip DESC;


 SELECT ZIP_Code, healthy_school_certified
 FROM chicago_schools
 WHERE ZIP_Code = '60608'
 	AND healthy_school_certified = 'Yes';
-- to check the total sum of healthy school in ZIP CODES

SELECT ZIP_Code, Types_of_school
FROM chicago_schools
WHERE Types_of_school = 'High School' OR 'Middle Level School';


SELECT Types_of_school, COUNT(*) AS school_count
FROM chicago_schools
GROUP BY Types_of_school;

SELECT 
    ZIP_Code,
    COUNT(*) AS School_Count,
    AVG(safety_score) AS Avg_Safety,
    ROUND(SUM(College_Enrollment_Rate), 1) AS Total_Students
FROM chicago_schools
GROUP BY ZIP_Code
ORDER BY Total_Students DESC;