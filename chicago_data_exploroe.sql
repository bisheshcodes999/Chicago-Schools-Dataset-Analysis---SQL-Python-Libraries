-- DATA EXPLORATION SETS -- 3rd PHASE of the Data explorations of the given chicago school dataset

USE data_exploration;
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
    ROUND(SUM(College_Enrollment_Rate), 1) AS College_enrollment
FROM chicago_schools
GROUP BY ZIP_Code
ORDER BY College_enrollment DESC;
-- Hence we can observe that most of the college has not been enrolled
-- One of the key insights for the reason might be : Due to the school being elementary -> hence the college is not applicable

SELECT ZIP_Code,
		COUNT(*) AS Total_Students,
		Types_of_school
FROM chicago_schools
WHERE ZIP_Code = '60608'
GROUP BY Types_of_school;
-- Hence from the above query we can see that zip code 60608 contains 12 students and all belong to the Type -> elementary school. Hence college eligibility will be nill
SELECT * 
FROM chicago_schools;

-- USING THE TEACHERS AND STUDENTS DATA FOR FURTHER 'EDA' process
WITH school_parent_environment AS 
(
SELECT school_name, Types_of_school, Environment_Score, Parent_Engagement_Score, Parent_Environment_Score
FROM chicago_schools
)
SELECT Types_of_school,
		COUNT(*) as total_schools
FROM school_parent_environment
GROUP BY Types_of_school;

-- Hence the total number of schools as per the schema can be fetched where 350 schools were elementary schools, 35 were high schools and middle level -> 6

-- For checking the highest rated school according to the parent engagemenet score 

SELECT school_name, Types_of_school, Environment_Score, Parent_Engagement_Score, Parent_Environment_Score
FROM chicago_schools;


-- Top 10 schools along with their types having the best average combined parents score 
SELECT school_name,
	   Types_of_school,
       Parent_Engagement_Score,
       Parent_Environment_Score,
       (Parent_Environment_Score + Parent_Engagement_Score)/2 AS combined_parents_score
FROM chicago_schools
ORDER BY combined_parents_score DESC
LIMIT 10;
-- This calculates the average combined parents score for the engagement and the environement score to not create bias between the 2 aspects

-- Integrating with the parents engagement score 

WITH engagement_filter AS (
    SELECT 
        school_name,
        Types_of_school,
        Parent_Engagement_Score
    FROM chicago_schools
    WHERE Parent_Engagement_Score > 50
)

SELECT 
    Types_of_school,
    COUNT(*) AS total_schools
FROM engagement_filter
GROUP BY Types_of_school;

-- Performing analysis based on the average parent engagement score and the respective types of schools


CREATE VIEW average_engagement AS 
SELECT 
    Types_of_school,
    AVG(Parent_Engagement_Score) AS avg_parent_engagement,
    COUNT(*) AS total_schools
FROM chicago_schools
GROUP BY Types_of_school;
-- From the above query -> average parents engagemenet score -> with respect to the types of school was concluded

SELECT net_change_explore_and_plan,
	  COUNT(*) as total_net_change_explore,
      COUNT(*) as total_counts
FROM chicago_schools
WHERE net_change_explore_and_plan = 'NDA';

 
SELECT net_change_explore_and_plan
from chicago_schools;

SELECT School_ID,
	   ROW_NUMBER() OVER(ORDER BY School_ID) as total_numbering_of_fields
FROM chicago_schools;

-- to select the top 3 school_ids of the given table of the records that it holds and display the top 3 records of the given table according to the table name 

SELECT School_ID, total_numbering_of_fields,
		ROW_NUMBER() OVER(partition by School_ID ORDER BY 












-- Checking the data for the students performance VS teachers performance along with the safety scores for -> visualizing whether or not to enroll the children in the respective school

SELECT Average_stu_attendance, Average_Teacher_Attendance
FROM chicago_schools;

-- Here almost 5 datas of the teachers attendance field has value 0% so exploring more through it 

SELECT Average_Teacher_Attendance


-- creationg of CTes 

-- WITH total_sales AS 
-- (
-- 	SELECT customer_id, SUM(total_sales) as Total_customer_sales
--     FROM retail_sales
--     GROUP BY customer_id
-- )
-- SELECT * 
-- FROM total_sales;