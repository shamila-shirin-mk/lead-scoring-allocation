CREATE DATABASE lead_project;
use lead_project;

SELECT * from leads;

SELECT `Lead Source`, COUNT(*) AS total_leads
FROM leads
GROUP BY `Lead Source`
ORDER BY total_leads DESC;


SELECT
`Lead Source`, COUNT(*) AS total_leads,
SUM(Converted) AS converted_leads,
SUM(Converted)/ COUNT(*) * 100 AS Conversion_Rate
FROM leads
GROUP BY `Lead Source`
ORDER BY total_leads DESC;


SELECT
`Lead Source`, COUNT(*) AS total_leads,
SUM(Converted) AS converted_leads,
ROUND(SUM(Converted)/ COUNT(*) * 100 ,2)AS Conversion_Rate
FROM leads
GROUP BY `Lead Source`
ORDER BY Conversion_Rate DESC;


SELECT
`Lead Source`, COUNT(*) AS total_leads,
SUM(Converted) AS converted_leads,
ROUND(SUM(Converted)/ COUNT(*) * 100 ,2)AS Conversion_Rate
FROM leads
GROUP BY `Lead Source`
HAVING COUNT(*) >= 30
ORDER BY Conversion_Rate DESC;


-- A window function does something different: it keeps every single original row, but adds an extra calculated column based on groups — without collapsing anything away
SELECT 
    `Lead Source`,
    `Total Time Spent on Website`,
    Converted,
    RANK() OVER (
        PARTITION BY `Lead Source`  -- it reset the ranking counter every time the Lead Source changes. So Google's leads get ranked 1, 2, 3... among themselves, and separately, Direct Traffic's leads also get ranked 1, 2, 3... among themselves — all in the same result, all rows still visible.
        ORDER BY `Total Time Spent on Website` DESC
    ) AS engagement_rank
FROM leads;


SELECT 
    `Lead Source`,
    `Total Time Spent on Website`,
    Converted,
    RANK() OVER (
        PARTITION BY `Lead Source`
        ORDER BY `Total Time Spent on Website` DESC
    ) AS engagement_rank
FROM leads
ORDER BY `Lead Source`, engagement_rank -- First arrange by Lead Source, and within each Lead Source arrange by engagement rank.
LIMIT 15;

SELECT 
    `Lead Source`,
    `Total Time Spent on Website`,
    Converted,
    RANK() OVER (
        PARTITION BY `Lead Source`
        ORDER BY `Total Time Spent on Website` DESC
    ) AS engagement_rank
FROM leads
WHERE `Lead Source` IN ('Google', 'Direct Traffic', 'Olark Chat')
ORDER BY `Lead Source`, engagement_rank 
LIMIT 15;

-- it's the difference between RANK() (which leaves a "gap" after ties — 1, 2, 3, 3, 5) and a similar function called DENSE_RANK() (which doesn't leave gaps — 1, 2, 3, 3, 4).