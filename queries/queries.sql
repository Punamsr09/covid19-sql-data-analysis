
-- Question: Retrieve all records from the COVID-19 deaths dataset.
SELECT * FROM covid_data_db.covid_deaths;

-- Question: For each country and date, calculate the death rate as a percentage of total cases.
SELECT location, date, total_cases, total_deaths, ROUND((total_deaths/total_cases)*100,2) AS death_percentage
FROM covid_data_db.covid_deaths
-- WHERE location like '%India%'
ORDER BY location, date;

-- Question: Find countries with the highest proportion of their population infected.

SELECT location, population, MAX(total_cases) AS highest_infection_count, ROUND(MAX((total_cases)/population) *100,2) AS highest_infection_rate
FROM covid_deaths
GROUP BY location, population
ORDER BY highest_infection_rate DESC;

-- Question: List all countries that reported no COVID-19 cases.
WITH table_a AS (SELECT location, population, MAX(total_cases) AS highest_infection_count, ROUND(MAX((total_cases)/population) *100,2) AS infection_rate
FROM covid_deaths
GROUP BY location, population
ORDER BY 1, 2
)
SELECT location, highest_infection_count
FROM table_a
WHERE highest_infection_count = 0;

-- Question: Identify countries with the highest number of COVID-19 deaths (excluding locations with missing continent data).

SELECT location, MAX(total_deaths) AS highest_death_count
FROM covid_data_db.covid_deaths
WHERE continent != ''
GROUP BY location
ORDER BY highest_death_count DESC;

-- Question: Determine which continents experienced the highest total COVID-19 deaths.
SELECT continent, MAX(total_deaths) AS highest_death_counts
FROM covid_data_db.covid_deaths
WHERE continent IS NOT NULL AND continent !=''
GROUP BY continent
ORDER BY highest_death_counts DESC;

-- Question: Display daily new vaccination counts for each country along with population and continent.
SELECT dth.continent, dth.location, dth.date, dth.population, vac.new_vaccinations 
FROM covid_deaths dth
JOIN covid_vaccinations vac
ON dth.location = vac.location
AND dth.date = vac.date
WHERE dth.continent != ''
ORDER BY 1, 2, 3;

-- Question: Calculate the cumulative number of vaccinations for each country over time.

SELECT dth.location, dth.date, dth.population, vac.new_vaccinations,
SUM(vac.new_vaccinations) OVER(PARTITION BY dth.location ORDER BY dth.date) AS cumulative_vac
FROM covid_deaths dth
JOIN covid_vaccinations vac
ON dth.date = vac.date
AND dth.location = vac.location
WHERE vac.new_vaccinations != 0;

-- Question: Determine the percentage of the population vaccinated in each country using cumulative vaccination data.

WITH cumulative_table AS  (SELECT dth.location, dth.date, dth.population, vac.new_vaccinations,
							SUM(vac.new_vaccinations) OVER(PARTITION BY dth.location ORDER BY dth.date) AS cumulative_vac
							FROM covid_deaths dth
							JOIN covid_vaccinations vac
							ON dth.date = vac.date
							AND dth.location = vac.location
							WHERE vac.new_vaccinations != 0
                            
)
SELECT location, population, 
			ROUND(MAX(cumulative_vac)/population*100,2)  AS percent_vacc
			FROM cumulative_table
			GROUP BY location, population;
           
-- Question: Rank countries by the percentage of the population vaccinated.
WITH cumulative_table AS  (SELECT dth.location, dth.date, dth.population, vac.new_vaccinations,
							SUM(vac.new_vaccinations) OVER(PARTITION BY dth.location ORDER BY dth.date) AS cumulative_vac
							FROM covid_deaths dth
							JOIN covid_vaccinations vac
							ON dth.date = vac.date
							AND dth.location = vac.location
							WHERE vac.new_vaccinations != 0
                            
),
table_b AS (SELECT location, population, 
			ROUND(MAX(cumulative_vac)/population*100,2)  AS percent_vacc
			FROM cumulative_table
			GROUP BY location, population
)
SELECT location, population, percent_vacc,	RANK() OVER(ORDER BY percent_vacc DESC ) AS country_rank
FROM table_b
WHERE percent_vacc !=0;



