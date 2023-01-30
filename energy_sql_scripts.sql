-- How Green is the Energy We Use?

-- A dashboard for tracking global low-carbon energy consumption and its impact on carbon emissions.

-- Below is the descriptive and diagnostic data analysis conducted in the process of developing insights and subsequently creating data visualizations with Tableau.


-- 1. What are the Biggest Energy Consuming Countries by Source?

SELECT country, year, primary_ej as total_cons, oilcons_ej as oil_cons, 
    gascons_ej as natgas_cons, coalcons_ej as coal_cons, nuclear_ej as nuclear_cons,
    hydro_ej as hydro_cons, renewables_ej as renew_cons
FROM `Energy.bp_review` 
WHERE YEAR = 2021 
    AND country_code NOT LIKE 'T-%'
    AND country_code NOT LIKE 'O-%'
ORDER BY total_cons DESC


-- 2. What are the most efficient Countries in the use of Oil to achieve the same unit of GDP? (US$ per barrel of oil)

WITH temp_table as (
SELECT a.country, a.year, 
    a.primary_ej as total_cons, (a.oilcons_kbd*365) as oil_cons_per_year, 
    CAST(b.GDP_current AS FLOAT64) as GDP_current
FROM `Energy.bp_review` a
JOIN `Energy.worldbank_development_indicators` b
    ON a.Year = b.Time
    AND a.country_code = b.Country_Code
WHERE b.GDP_current != '..' 
    AND region IS NOT NULL
ORDER BY total_cons DESC
)
SELECT country, oil_cons_per_year, GDP_current, 
    ROUND(GDP_current/NULLIF(oil_cons_per_year,0)) as GDP_per_barrel
FROM temp_table
WHERE year = 2021
    AND oil_cons_per_year IS NOT NULL
ORDER BY GDP_per_barrel DESC ;

-- 3. What is the Share of Low-carbon energy in Global Power Consumption? (Per Country)

SELECT country, region, total_cons, nuclear_cons, 
    hydro_cons, renew_cons, renew_total_cons, 
    (renew_total_cons / total_cons) as share_of_renew
FROM (  
    SELECT country, region, year, primary_ej as total_cons, nuclear_ej as nuclear_cons, 
        hydro_ej as hydro_cons, renewables_ej as renew_cons, 
        (COALESCE(nuclear_ej,0) + COALESCE(hydro_ej,0) + COALESCE(renewables_ej,0)) as renew_total_cons
    FROM `Energy.bp_review` 
    WHERE year = 2021 
        AND country_code NOT LIKE 'T-%'
        AND country_code NOT LIKE 'O-%' )
ORDER BY share_of_renew DESC ;


-- 4. What is the Total Energy Consumption Per Capita by country?

SELECT a.country, a.region, a.primary_ej as total_cons, 
    CAST(b.population AS INT64) as population, 
    COALESCE(a.primary_ej / CAST(b.population AS INT64)) as cons_per_capita
FROM `Energy.bp_review` a
LEFT JOIN `Energy.worldbank_development_indicators` b
    ON a.Year = b.Time
    AND a.country_code = b.Country_Code
WHERE year = 2021 
    AND region IS NOT NULL
ORDER BY cons_per_capita DESC ;


-- 5. How has Low-carbon Energy Consumption evolved by source since 1965?

SELECT country, year, primary_ej as total_cons, oilcons_ej as oil_cons, 
    gascons_ej as natgas_cons, coalcons_ej as coal_cons, 
    nuclear_ej as nuclear_cons, hydro_ej as hydro_cons, renewables_ej as renew_cons
FROM `Energy.bp_review` 
WHERE year BETWEEN 1965 AND 2021 
    AND country_code NOT LIKE 'T-%'
    AND country_code NOT LIKE 'O-%'
ORDER BY 1,2 ;


-- 6. What is the Relationship between Energy Consumption and GDP per Capita?

SELECT a.country, a.region, CAST(b.population AS INT64) as population, 
    a.primary_ej_pc as cons_per_capita, 
    (CAST(b.GDP_current AS FLOAT64) / CAST(b.population AS INT64)) as GDP_per_capita
FROM `Energy.bp_review` a
LEFT JOIN `Energy.worldbank_development_indicators` b
    ON a.Year = b.Time
    AND a.country_code = b.Country_Code
WHERE year = 2021 
    AND region IS NOT NULL 
    AND b.GDP_current != '..' 
ORDER BY GDP_per_capita DESC ;


-- 7. What is the evolution of Low-carbon Energy Consumption (Renewables, Hydro, Nuclear) by country in the last decade?

SELECT country, region, year, primary_ej as total_cons, 
    nuclear_ej as nuclear_cons, hydro_ej as hydro_cons, renewables_ej as renew_cons, 
    (COALESCE(nuclear_ej,0) + COALESCE(hydro_ej,0) + COALESCE(renewables_ej,0)) as renew_total_cons
FROM `Energy.bp_review` 
WHERE YEAR BETWEEN 2012 AND 2021 
    AND region IS NOT NULL
ORDER BY 1,2,3 ;


-- 8. What is the Correlation between Renewable Energy use and CO2 Emissions per capita?

SELECT country, region, population, total_cons, cons_per_capita, renew_total_cons, 
    (renew_total_cons / population) as renew_per_capita, co2_emissions_pc
FROM ( 
    SELECT a.country, a.region, CAST(b.population AS INT64) as population, a.primary_ej as total_cons,
        (COALESCE(nuclear_ej,0) + COALESCE(hydro_ej,0) + COALESCE(renewables_ej,0)) as renew_total_cons,  
        a.primary_ej_pc as cons_per_capita, 
        a.co2_combust_pc as co2_emissions_pc
    FROM `Energy.bp_review` a
    LEFT JOIN `Energy.worldbank_development_indicators` b
        ON a.Year = b.Time
        AND a.country_code = b.Country_Code
    WHERE year = 2021 
        AND region IS NOT NULL 
      ) 
ORDER BY renew_per_capita DESC ;


-- 9. Which Countries Consume more Energy per Capita than World Average?

SELECT country, region, cons_per_capita, avg_per_capita, 
    (cons_per_capita / avg_per_capita) as perc_above_avg
FROM (
    SELECT country, region, year, primary_ej_pc as cons_per_capita, 
        AVG(primary_ej_pc) OVER() as avg_per_capita
    FROM `Energy.bp_review`
    WHERE year = 2021 
        AND region IS NOT NULL
    ) 
WHERE cons_per_capita > avg_per_capita    
ORDER BY cons_per_capita DESC ;


-- 10. What is the Share of Renewable Energy in Global Energy Consumption?

SELECT country, total_cons, nuclear_cons, hydro_cons, renew_cons, 
    renew_total_cons, (renew_total_cons / total_cons) as share_of_renew
FROM (  
    SELECT country, region, year, primary_ej as total_cons, 
        nuclear_ej as nuclear_cons, hydro_ej as hydro_cons, renewables_ej as renew_cons, 
        (COALESCE(nuclear_ej,0) + COALESCE(hydro_ej,0) + COALESCE(renewables_ej,0)) as renew_total_cons
    FROM `Energy.bp_review` 
    WHERE year = 2021 
        AND country = 'Total World' 
        )
ORDER BY share_of_renew DESC ;

