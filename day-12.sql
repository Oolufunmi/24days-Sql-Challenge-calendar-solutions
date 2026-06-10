-- SQL Advent Calendar - Day 12
-- Title: North Pole Network Most Active Users
-- Difficulty: hard
--

-- Table Schema:
-- Table: npn_users
--   user_id: INT
--   user_name: VARCHAR
--
-- Table: npn_messages
--   message_id: INT
--   sender_id: INT
--   sent_at: TIMESTAMP
--
-- Question:
-- The North Pole Network wants to see who's the most active in the holiday chat each day. Write a query to count how many messages each user sent, then find the most active user(s) each day. 
--If multiple users tie for first place, return all of them.


-- My Solution:

with CTE as (
  select DATE(npn_messages.sent_at)AS Messagedate, npn_users.user_name,npn_users.user_id,
  count(npn_messages.message_id) as Totalmessage from npn_messages  
  join npn_users
  on npn_messages.sender_id = npn_users.user_id
GROUP by DATE(npn_messages.sent_at), npn_users.user_id,npn_users.user_name
  ),
  
Ranking AS
  (Select Messagedate,Totalmessage, user_id,user_name,
  rank() over (partition by Messagedate 
  order by Totalmessage  DESC ) as RankingDaily
from CTE)

SELECT Messagedate, user_id, user_name,Totalmessage from Ranking  
  where RankingDaily = 1
  order by Messagedate, user_name;
