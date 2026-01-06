-- SQL Advent Calendar - Day 3
-- Title: The Grinch's Best Pranks Per Target
-- Difficulty: hard
--
-- Question:
-- The Grinch has brainstormed a ton of pranks for Whoville, but he only wants to keep the top prank per target, with the highest evilness score. Return the most evil prank for each target. If two pranks have the same evilness, the more recently brainstormed wins.
--
-- The Grinch has brainstormed a ton of pranks for Whoville, but he only wants to keep the top prank per target, with the highest evilness score. Return the most evil prank for each target. If two pranks have the same evilness, the more recently brainstormed wins.
--

-- Table Schema:
-- Table: grinch_prank_ideas
--   prank_id: INTEGER
--   target_name: VARCHAR
--   prank_description: VARCHAR
--   evilness_score: INTEGER
--   created_at: TIMESTAMP
--

-- My Solution:

WITH RankedPranks AS (
    SELECT
        target_name,
        prank_id,
        evilness_score,
        created_at,
        -- Assigns a rank based on the required criteria within each target group
        ROW_NUMBER() OVER (
            PARTITION BY target_name 
            ORDER BY 
                evilness_score DESC, -- 1. Highest score wins
                created_at DESC      -- 2. Most recent date wins ties
        ) as rn
    FROM
        grinch_prank_ideas
)
SELECT
    target_name,
    prank_id,
    evilness_score,
    created_at
FROM
    RankedPranks
WHERE
    rn = 1 -- Only keep the #1 ranked prank for each target
ORDER BY
    target_name;
