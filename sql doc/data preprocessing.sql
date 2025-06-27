create database bonus_allocation1;
use bonus_allocation1;
SELECT * FROM bonus_allocation1;
 
-- Handling duplicates 

SELECT 
    Order_ID, COUNT(*) AS duplicate_count
FROM bonus_allocation1;

-- Step 1: Create a temporary table with unique records
CREATE TABLE temp_bonus_allocation AS
SELECT * 
FROM bonus_allocation1
WHERE Order_ID IN (
    SELECT MIN(Order_ID) 
    FROM bonus_allocation1 
    GROUP BY Order_ID
);

-- Step 2: Remove all data from the original table
TRUNCATE TABLE bonus_allocation1;

-- Step 3: Reinsert unique records
INSERT INTO bonus_allocation1
SELECT * FROM temp_bonus_allocation;

-- Step 4: Drop the temporary table
DROP TABLE temp_bonus_allocation; 

-- Outliers treatment  
WITH row_counts AS (
    SELECT COUNT(*) AS total_rows FROM bonus_allocation1
),
quartiles AS (
    SELECT 
        Customer_ID,
        age,
        income_level,
        Winning_percentage,
        Days_Since_Last_Bet,
        Active_Days,
        Total_Number_of_Bets,
        Total_Amount_Wagered,
        Average_Bet_Amount,
        Number_of_Bonuses_Received,
        Amount_of_Bonuses_Received,
        Revenue_from_Bonuses,
        Increase_in_Bets_After_Bonus,
        Increase_in_wagering_after_Bonus,
        NTILE(4) OVER (ORDER BY age) AS age_Q,
        NTILE(4) OVER (ORDER BY income_level) AS income_level_Q,
        NTILE(4) OVER (ORDER BY Winning_percentage) AS Winning_percentage_Q,
        NTILE(4) OVER (ORDER BY Days_Since_Last_Bet) AS Days_Since_Last_Bet_Q,
        NTILE(4) OVER (ORDER BY Active_Days) AS Active_Days_Q
    FROM bonus_allocation1
),
median_values AS (
    SELECT 
        AVG(age) AS age_median,
        AVG(income_level) AS income_level_median,
        AVG(Winning_percentage) AS Winning_percentage_median,
        AVG(Days_Since_Last_Bet) AS Days_Since_Last_Bet_median,
        AVG(Active_Days) AS Active_Days_median
    FROM bonus_allocation1 t
    JOIN row_counts r
    ON (SELECT COUNT(*) FROM bonus_allocation1 WHERE age <= t.age) 
       BETWEEN (r.total_rows / 2) AND (r.total_rows / 2 + 1)
)
UPDATE bonus_allocation1 AS e
JOIN quartiles q ON e.Customer_ID = q.Customer_ID
JOIN median_values m
SET 
    e.age = CASE 
        WHEN q.age_Q = 1 OR q.age_Q = 4 THEN m.age_median ELSE e.age 
    END,
    e.income_level = CASE 
        WHEN q.income_level_Q = 1 OR q.income_level_Q = 4 THEN m.income_level_median ELSE e.income_level 
    END,
    e.Winning_percentage = CASE 
        WHEN q.Winning_percentage_Q = 1 OR q.Winning_percentage_Q = 4 THEN m.Winning_percentage_median ELSE e.Winning_percentage 
    END,
    e.Days_Since_Last_Bet = CASE 
        WHEN q.Days_Since_Last_Bet_Q = 1 OR q.Days_Since_Last_Bet_Q = 4 THEN m.Days_Since_Last_Bet_median ELSE e.Days_Since_Last_Bet 
    END,
    e.Active_Days = CASE 
        WHEN q.Active_Days_Q = 1 OR q.Active_Days_Q = 4 THEN m.Active_Days_median ELSE e.Active_Days 
    END;

-- Missing values 
SELECT 
    COUNT(*) AS total_rows,
    SUM(CASE WHEN age IS NULL THEN 1 ELSE 0 END) AS age_missing,
    SUM(CASE WHEN income_level IS NULL THEN 1 ELSE 0 END) AS income_level_missing,
    SUM(CASE WHEN Winning_percentage IS NULL THEN 1 ELSE 0 END) AS Winning_percentage_missing,
    SUM(CASE WHEN Days_Since_Last_Bet IS NULL THEN 1 ELSE 0 END) AS Days_Since_Last_Bet_missing,
    SUM(CASE WHEN Active_Days IS NULL THEN 1 ELSE 0 END) AS Active_Days_missing,
    SUM(CASE WHEN Total_Number_of_Bets IS NULL THEN 1 ELSE 0 END) AS Total_Number_of_Bets_missing,
    SUM(CASE WHEN Total_Amount_Wagered IS NULL THEN 1 ELSE 0 END) AS Total_Amount_Wagered_missing,
    SUM(CASE WHEN Average_Bet_Amount IS NULL THEN 1 ELSE 0 END) AS Average_Bet_Amount_missing,
    SUM(CASE WHEN Number_of_Bonuses_Received IS NULL THEN 1 ELSE 0 END) AS Number_of_Bonuses_Received_missing,
    SUM(CASE WHEN Amount_of_Bonuses_Received IS NULL THEN 1 ELSE 0 END) AS Amount_of_Bonuses_Received_missing,
    SUM(CASE WHEN Revenue_from_Bonuses IS NULL THEN 1 ELSE 0 END) AS Revenue_from_Bonuses_missing,
    SUM(CASE WHEN Increase_in_Bets_After_Bonus IS NULL THEN 1 ELSE 0 END) AS Increase_in_Bets_After_Bonus_missing,
    SUM(CASE WHEN Increase_in_wagering_after_Bonus IS NULL THEN 1 ELSE 0 END) AS Increase_in_wagering_after_Bonus_missing,
    SUM(CASE WHEN Should_Receive_Bonus IS NULL THEN 1 ELSE 0 END) AS Should_Receive_Bonus_missing
FROM bonus_allocation1;

SET SQL_SAFE_UPDATES = 0;

DELETE FROM bonus_allocation1 
WHERE age IS NULL 
   OR income_level IS NULL 
   OR Winning_percentage IS NULL 
   OR Days_Since_Last_Bet IS NULL 
   OR Active_Days IS NULL 
   OR Total_Number_of_Bets IS NULL 
   OR Total_Amount_Wagered IS NULL 
   OR Average_Bet_Amount IS NULL 
   OR Number_of_Bonuses_Received IS NULL 
   OR Amount_of_Bonuses_Received IS NULL 
   OR Revenue_from_Bonuses IS NULL 
   OR Increase_in_Bets_After_Bonus IS NULL 
   OR Increase_in_wagering_after_Bonus IS NULL 
   OR Should_Receive_Bonus IS NULL;

SET SQL_SAFE_UPDATES = 1;  -- Re-enable safe mode

UPDATE bonus_allocation1
SET 
    age = COALESCE(age, 0),
    income_level = COALESCE(income_level, 0),
    Winning_percentage = COALESCE(Winning_percentage, 0),
    Days_Since_Last_Bet = COALESCE(Days_Since_Last_Bet, 0),
    Active_Days = COALESCE(Active_Days, 0),
    Total_Number_of_Bets = COALESCE(Total_Number_of_Bets, 0),
    Total_Amount_Wagered = COALESCE(Total_Amount_Wagered, 0),
    Average_Bet_Amount = COALESCE(Average_Bet_Amount, 0),
    Number_of_Bonuses_Received = COALESCE(Number_of_Bonuses_Received, 0),
    Amount_of_Bonuses_Received = COALESCE(Amount_of_Bonuses_Received, 0),
    Revenue_from_Bonuses = COALESCE(Revenue_from_Bonuses, 0),
    Increase_in_Bets_After_Bonus = COALESCE(Increase_in_Bets_After_Bonus, 0),
    Increase_in_wagering_after_Bonus = COALESCE(Increase_in_wagering_after_Bonus, 0),
    Should_Receive_Bonus = COALESCE(Should_Receive_Bonus, 0);





