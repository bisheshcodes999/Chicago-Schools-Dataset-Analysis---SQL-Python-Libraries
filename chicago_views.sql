-- Defining the name of the schema we will be using
USE data_exploration;

SELECT * 
FROM chicago_schools;

CREATE VIEW vw_schools_cleaned AS
SELECT
    School_ID,
    School_name,
    Types_of_school,
    community_area_name,
    Ward,
    Network_Manager,

    CAST(Graduation_Rate AS float) AS Graduation_Rate,
    CAST(College_Enrollment_Rate AS float) AS College_Enrollment_Rate,
    CAST(Average_stu_attendance AS float) AS Avg_Student_Attendance,
    CAST(Average_Teacher_Attendance AS float) AS Avg_Teacher_Attendance,

    Safety_score,
    Environment_Score,
    Instruction_Score,
    Parent_Environment_Score,
    Rate_of_Misconducts_per_100_students,

    Latitude,
    Longitude
FROM Chicago_Schools
WHERE Graduation_Rate IS NOT NULL;

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




-- Checking the ranks of the different schools 
