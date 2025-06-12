/*
Question : what are the top paying Data Analyst Job ?
- Identify the top 10 highest-paying Data Analyst role hat are available remotely.
- Focuses on job posting with specified salary (remove nulls).
- BONUSES added company name
- Wy ? highlight the top paying opportunities for Data Analyst. offering insigth into 
*/

SELECT
    job_id,
    job_title,
    job_location,
    job_schedule_type,
    salary_year_avg,
    job_posted_date,
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