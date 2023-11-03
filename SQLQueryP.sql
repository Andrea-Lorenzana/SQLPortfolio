--SELECT * FROM [SQL Portfolio]..CovidDeaths$ ORDER BY 3,4

--SELECT * FROM [SQL Portfolio]..CovidVaccinations$ ORDER BY 3,4

--SELECT location, date, total_cases, new_cases, total_deaths, population FROM [SQL Portfolio]..CovidDeaths$ ORDER BY 1,2

--SELECT location, date, total_cases,total_deaths, (total_deaths/total_cases)*100 AS Ppercentage  FROM CovidDeaths$
--WHERE location like '%states%'
--ORDER BY 1,2

--SELECT location, date, population,total_cases, (total_cases/population)*100 AS PercentPopulation  FROM CovidDeaths$
--ORDER BY 1,2

--HIGHEST INFECTION VS POPULATION
--SELECT location, population, MAX(total_cases) as HighestInfection, Max((total_cases/population)*100) AS PercentagPopInfec  FROM CovidDeaths$
--where continent is not null
--group by location, population
--order by PercentagPopInfec desc

--COUNTRIES WITH HIGHEST DEATH COUNT PER POPULATION
--SELECT location, MAX(cast(total_deaths as int)) as TotalDeaths  FROM CovidDeaths$
--where continent is not null
--group by location
--order by TotalDeaths desc


SELECT SUM(new_cases) as total_cases, SUM(cast(new_deaths as int)) as total_deaths,
SUM(cast(new_deaths as int))/ SUM(New_cases)*100 as DeathPercentage
From [SQL Portfolio]..CovidDeaths$





