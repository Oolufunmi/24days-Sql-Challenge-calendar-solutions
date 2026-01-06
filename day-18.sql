-- SQL Advent Calendar - Day 18
-- Title: 12 Days of Data - Progress Tracking
-- Difficulty: hard
--
-- Question:
-- Over the 12 days of her data challenge, Data Dawn tracked her daily quiz scores across different subjects. Can you find each subject's first and last recorded score to see how much she improved?
--
-- Over the 12 days of her data challenge, Data Dawn tracked her daily quiz scores across different subjects. Can you find each subject's first and last recorded score to see how much she improved?
--

-- Table Schema:
-- Table: daily_quiz_scores
--   subject: VARCHAR
--   quiz_date: DATE
--   score: INTEGER
--

-- My Solution:

with FirstScores AS (
  select subject, score as first_score 
  from ( 
  select 
  subject,score,
  row_number() over (partition by subject ORDER by quiz_date ASC ) AS rn
  FROM daily_quiz_scores
  ) AS sub_first
  where rn = 1 
),

LastScores AS (
  select subject, score as last_score 
  from ( 
  select 
  subject,score,
  row_number() over (partition by subject ORDER by quiz_date DESC ) AS rn
  FROM daily_quiz_scores
  ) AS sub_last
  where rn = 1 
)
SELECT f.subject, f.first_score, 
  l.last_score, 
  (l.last_score- f.first_score) As Improvement 
  from FirstScores as f join  LastScores as l
on f.subject = l.subject
