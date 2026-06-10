-- SQL Advent Calendar - Day 6
-- Title: Ski Resort Snowfall Rankings
-- Difficulty: hard
--
-- Table Schema:
-- Table: resort_monthly_snowfall
--   resort_id: INT
--   resort_name: VARCHAR
--   snow_month: INT
--   snowfall_inches: DECIMAL
--
-- Question:
-- Buddy is planning a winter getaway and wants to rank ski resorts by annual snowfall. Can you help him bucket these ski resorts into quartiles?

-- My Solution:

with cte AS (
  select resort_id, resort_name , sum (snowfall_inches) as AnnualSnowfall 
  from resort_monthly_snowfall group by resort_id,resort_name
  )
select  resort_id, resort_name, AnnualSnowfall, ntile(4) over (order by AnnualSnowfall) 
  as Snowfall_per_Quartile 
  from cte ORDER by  AnnualSnowfall DESC
