
# Covid19-sql-data-analysis

COVID-19 case and vaccination trends were analyzed with SQL to demonstrate advanced querying and extract meaningful insights.

## SQL Functions & Techniques Used
 
### SQL Functions
•	Aggregate Functions: SUM(), COUNT(), MAX(), AVG(), ROUND() → for totals, averages, highest counts, and percentages

•	Window Functions:

o	SUM() OVER(PARTITION BY ORDER BY) → cumulative vaccinations

o	RANK() OVER(ORDER BY …) → ranking countries by vaccination percentage

•	Conditional Logic: CASE WHEN → handling division by zero or missing values

•	Mathematical Operations: Ratio and percentage calculations (infection rate, death rate, vaccination rate)

### SQL Techniques
•	Joins: INNER JOIN between covid_deaths and covid_vaccinations for integrated insights

•	CTEs (Common Table Expressions): Breaking down complex queries into structured, readable steps

•	Grouping & Aggregation: GROUP BY location, population to summarize by country or continent

•	Filtering & Cleaning: Handling NULL and blank values in the continent column, filtering non-zero records

•	Ordering & Ranking: Sorting with ORDER BY, creating leaderboards with RANK()

•	Cumulative & Time-Based Analysis: Tracking infection, death, and vaccination trends over time
________________________________________
## Findings

1.	Death Percentage:

    Across countries, death rates (deaths ÷ cases) varied significantly, showing higher fatality rates in some regions despite lower case counts.

2.	Highest Infection Rates:

    Certain smaller countries exhibited very high infection rates relative to their population, even though their absolute case counts were lower than those of larger nations.

4.	Zero COVID Cases:

    A handful of countries reported zero cases in the dataset, which may indicate underreporting or true isolation from the pandemic spread.

6.	Highest Death Counts:

    Large-population countries (and those heavily hit by waves) showed the highest absolute death counts.

8.	Continental Trends:

    Continents such as Europe and Asia accounted for the majority of deaths, underscoring the regional severity of the outbreaks.

10.	Vaccination Progress:

    Cumulative vaccination analysis revealed how quickly (or slowly) different nations rolled out vaccines over time.

12.	Population Vaccination Percentage & Ranking:

    Some small countries achieved near-total population vaccination, while larger countries lagged, ranking lower despite higher total doses administered.
________________________________________

Overall, by combining window functions, aggregations, and mathematical calculations, I transformed raw vaccination data into a meaningful metric-the percentage of population vaccinated.
This technique demonstrates how SQL can be applied to answer real-world business and policy questions, such as monitoring health initiatives or measuring progress toward goals.
