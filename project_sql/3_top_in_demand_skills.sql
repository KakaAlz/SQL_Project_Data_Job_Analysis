/*
Question : what are the most in demand skill are required for the Data Analyst Job ?
- join job posting to inner join table similiar to query 2
- identify the top 5 in demand skills for data analyst
- Focuses on all job posting
- Why ? retrieve the top 5 skills with the higest demand in the job market
    providing insights into the most valuable skills for job seekers
*/

/*
qurey option 1

WITH remote_job_skills AS (
    SELECT
        skill_id,
        COUNT (*) AS skill_count
    FROM 
        skills_job_dim AS sjd
    INNER JOIN 
        job_postings_fact AS jpf ON sjd.job_id = jpf.job_id
    WHERE 
        jpf.job_title_short = 'Data Analyst' AND
        jpf.job_location = 'Anywhere'
    GROUP BY 
        skill_id
)
SELECT 
    remote_job_skills.*,
    skills AS skill_name
FROM remote_job_skills
INNER JOIN
    skills_dim AS sd ON remote_job_skills.skill_id = sd.skill_id
ORDER BY skill_count DESC
LIMIT 5

*/

-- query option 2

SELECT *
FROM job_postings_fact AS jpf
INNER JOIN skills_job_dim AS sjd ON jpf.job_id = sjd.job_id
INNER JOIN skills_dim AS sd ON sjd.skill_id = sd.skill_id
LIMIT 5
