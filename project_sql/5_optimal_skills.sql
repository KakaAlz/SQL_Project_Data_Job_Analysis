/*
Question : what are the most optimal skill to learn (it's in high demand and high paying skills) ?
- identified skills in high demand and associated with high avg salary for Data Analyst roles
- concentrates on remote positions with specified salary 
- Why ? target skills that offer job security (high demand) and financial benefits (high salaries)
  offering strategic insigth for career development in Data Analyst
*/

/*
query option 1

WITH skills_demand AS (
    SELECT 
        sd.skill_id,
        skills AS skill_name,
        COUNT(sjd.skill_id) AS demand_skills
    FROM 
        job_postings_fact AS jpf
    INNER JOIN 
        skills_job_dim AS sjd ON jpf.job_id = sjd.job_id
    INNER JOIN 
        skills_dim AS sd ON sjd.skill_id = sd.skill_id
    WHERE
        jpf.job_title_short = 'Data Analyst'
        AND jpf.salary_year_avg IS NOT NULL
        AND jpf.job_work_from_home = 'True'
    GROUP BY 
        sd.skill_id
), average_salary AS (
    SELECT 
        sd.skill_id,
        skills AS skill_name,
        ROUND (AVG(salary_year_avg),2) AS avg_salary
    FROM 
        job_postings_fact AS jpf
    INNER JOIN 
        skills_job_dim AS sjd ON jpf.job_id = sjd.job_id
    INNER JOIN 
        skills_dim AS sd ON sjd.skill_id = sd.skill_id
    WHERE
        jpf.job_title_short = 'Data Analyst'
        AND jpf.salary_year_avg IS NOT NULL
        AND jpf.job_work_from_home = 'True'
    GROUP BY 
        sd.skill_id
)
SELECT
    skills_demand.skill_id,
    skills_demand.skill_name,
    demand_skills,
    avg_salary
FROM
    skills_demand
INNER JOIN
    average_salary ON skills_demand.skill_id = average_salary.skill_id
ORDER BY
    demand_skills DESC,
    avg_salary DESC
LIMIT 25
*/

-- query option 2

SELECT
    sd.skill_id,
    sd.skills AS skill_name,
    COUNT(sd.skill_id) AS demand_skills,
    ROUND(AVG(jpf.salary_year_avg),2) AS avg_salary
FROM
    job_postings_fact AS jpf
    INNER JOIN 
        skills_job_dim AS sjd ON jpf.job_id = sjd.job_id
    INNER JOIN 
        skills_dim AS sd ON sjd.skill_id = sd.skill_id
WHERE
    jpf.job_title_short = 'Data Analyst'
    AND jpf.job_work_from_home = 'True'
    AND jpf.salary_year_avg IS NOT NULL
GROUP BY
    sd.skill_id
HAVING
    COUNT(sd.skill_id) > 10
ORDER BY
    demand_skills DESC,
    avg_salary DESC
LIMIT 25