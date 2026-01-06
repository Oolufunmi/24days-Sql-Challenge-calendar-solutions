-- SQL Advent Calendar - Day 11
-- Title: Winter Market Sweater Search
-- Difficulty: medium
--
-- Question:
-- At the winter market, Cindy Lou is browsing the clothing inventory and wants to find all items with "sweater" in their name. But the challenge is the color and item columns have inconsistent capitalization. Can you write a query to return only the sweater names and their cleaned-up colors.
--
-- At the winter market, Cindy Lou is browsing the clothing inventory and wants to find all items with "sweater" in their name. But the challenge is the color and item columns have inconsistent capitalization. Can you write a query to return only the sweater names and their cleaned-up colors.
--

-- Table Schema:
-- Table: winter_clothing
--   item_id: INT
--   item_name: VARCHAR
--   color: VARCHAR
--

-- My Solution:

select Lower(item_name)As cleanedName,lower(color) as CleanedColor FROM winter_clothing
  where cleanedName like '%sweater%'
