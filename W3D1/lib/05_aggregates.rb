# == Schema Information
#
# Table name: countries
#
#  name        :string       not null, primary key
#  continent   :string
#  area        :integer
#  population  :integer
#  gdp         :integer

require_relative './sqlzoo.rb'

def example_sum
  execute(<<-SQL)
    SELECT
      SUM(population)
    FROM
      countries
  SQL
end

def continents
  # List all the continents - just once each.
  execute(<<-SQL)
    SELECT
    continent
    FROM
     countries
    GROUP BY
     continent
  SQL
end

def africa_gdp
  # Give the total GDP of Africa.
  execute(<<-SQL)
   SELECT
    SUM(gdp)
   FROM
    countries
  WHERE
    continent = 'Africa'
  SQL
end

def area_count
  # How many countries have an area of more than 1,000,000?
  execute(<<-SQL)
  SELECT
   COUNT(countries.name)
  FROM
   countries
  JOIN (
    SELECT
     name
     FROM
      countries
    WHERE
      area > 1000000
  ) AS high_area_countries ON countries.name = high_area_countries.name
  SQL
end

def group_population
  # What is the total population of ('France','Germany','Spain')?
  execute(<<-SQL)
  -- SELECT
  --  SUM(countries.population)
  -- FROM
  --  countries
  -- JOIN (
  --   SELECT
  --    name
  --   FROM
  --    countries
  --   WHERE
  --    name = 'France' OR name = 'Germany' OR name = 'Spain'
  -- ) AS fgs ON countries.name = fgs.name

  SELECT
   SUM(population)
  FROM
   countries
  WHERE
   name = 'France' OR name = 'Germany' OR name = 'Spain'

  SQL
end

def country_counts
  # For each continent show the continent and number of countries.
  execute(<<-SQL)
  SELECT DISTINCT
   countries.continent, countries_in_continents.count
  FROM
   countries
  JOIN (
    SELECT
     COUNT(name), continent
    FROM
     countries
    GROUP BY
     continent
  ) AS countries_in_continents ON countries.continent = countries_in_continents.continent
  SQL
end

def populous_country_counts
  # For each continent show the continent and number of countries with
  # populations of at least 10 million.
  execute(<<-SQL)
  -- SELECT
  --  countries.continent, COUNT(countries.name)
  -- FROM
  --   countries
  -- JOIN
  --      (
  --       SELECT
  --        name, population
  --       FROM
  --        countries
  --       WHERE
  --        population >= 10000000
  --      ) AS large_countries ON countries.name = large_countries.name
  -- GROUP BY
  --  countries.continent

   SELECT
    continent, COUNT(population)
   FROM
    countries
   WHERE
    population >= 10000000
   GROUP BY
   continent
  SQL
end

def populous_continents
  # List the continents that have a total population of at least 100 million.
  execute(<<-SQL)
  -- SELECT
  --  continent
  -- FROM
  --  countries
  -- JOIN (
  --   SELECT
  --    continent, SUM(population)
  --   FROM
  --    countries
  --   GROUP BY
  --    continent
  -- ) AS populous_continents ON


  SELECT
   continent
  FROM
   countries
  GROUP BY
   continent
  HAVING
   SUM(population) > 100000000


  SQL
end
