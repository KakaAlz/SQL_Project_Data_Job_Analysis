/*
Question : what skill are required for the top 10 paying Data Analyst Job ?
- use the top 10 paying Data Analyst job from the 1st query  
- add the specific skills required for these roles
- Focuses on job posting with specified salary (remove nulls).
- Wy ? it provided a detailed look at which high-paying jobs demand certain skills, helping job seeker understand which skills to develop that align with top salaries. 
*/

WITH top_paying_jobs AS (
    SELECT
        job_id,
        job_title,
        salary_year_avg,
        name AS company_name
    FROM
        job_postings_fact AS jpf
    LEFT JOIN company_dim AS cd ON jpf.company_id = cd.company_id
    WHERE
        job_title_short = 'Data Analyst' AND
        job_location = 'Anywhere' AND
        salary_year_avg IS NOT NULL
    ORDER BY
        salary_year_avg DESC
    LIMIT 10
)
SELECT 
    top_paying_jobs.*,
    skills
FROM top_paying_jobs
INNER JOIN skills_job_dim ON top_paying_jobs.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
ORDER BY salary_year_avg DESC