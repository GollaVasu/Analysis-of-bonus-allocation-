use bonus_allocation;
SELECT * FROM bonus_allocation;

-- Mean
SELECT 
    AVG(age) AS age_mean,
    AVG(income_level) AS income_level_mean,
    AVG(Winning_percentage) AS Winning_percentage_mean,
    AVG(Days_Since_Last_Bet) AS Days_Since_Last_Bet_mean,
    AVG(Active_Days) AS Active_Days_mean,
    AVG(Total_Number_of_Bets) AS Total_Number_of_Bets_mean,
    AVG(Total_Amount_Wagered) AS Total_Amount_Wagered_mean,
    AVG(Average_Bet_Amount) AS Average_Bet_Amount_mean,
    AVG(Number_of_Bonuses_Received) AS Number_of_Bonuses_Received_mean,
    AVG(Amount_of_Bonuses_Received) AS Amount_of_Bonuses_Received_mean,
    AVG(Revenue_from_Bonuses) AS Revenue_from_Bonuses_mean,
    AVG(Increase_in_Bets_After_Bonus) AS Increase_in_Bets_After_Bonus_mean,
    AVG(Increase_in_wagering_after_Bonus) AS Increase_in_wagering_after_Bonus_mean
FROM bonus_allocation;

-- Median (example for age, repeat similarly for others)
SELECT age AS median_age
FROM (
    SELECT age, ROW_NUMBER() OVER (ORDER BY age) AS row_num,
    COUNT(*) OVER () AS total_count
    FROM bonus_allocation
) AS subquery
WHERE row_num = (total_count + 1) / 2 OR row_num = (total_count + 2) / 2;

-- Mode (example for Should_Receive_Bonus, repeat similarly for others if needed)
SELECT Should_Receive_Bonus AS mode_Should_Receive_Bonus
FROM (
    SELECT Should_Receive_Bonus, COUNT(*) AS frequency
    FROM bonus_allocation
    GROUP BY Should_Receive_Bonus
    ORDER BY frequency DESC
    LIMIT 1
) AS subquery;

-- Standard Deviation
SELECT 
    STDDEV(age) AS age_stddev,
    STDDEV(income_level) AS income_level_stddev,
    STDDEV(Winning_percentage) AS Winning_percentage_stddev,
    STDDEV(Days_Since_Last_Bet) AS Days_Since_Last_Bet_stddev,
    STDDEV(Active_Days) AS Active_Days_stddev,
    STDDEV(Total_Number_of_Bets) AS Total_Number_of_Bets_stddev,
    STDDEV(Total_Amount_Wagered) AS Total_Amount_Wagered_stddev,
    STDDEV(Average_Bet_Amount) AS Average_Bet_Amount_stddev,
    STDDEV(Number_of_Bonuses_Received) AS Number_of_Bonuses_Received_stddev,
    STDDEV(Amount_of_Bonuses_Received) AS Amount_of_Bonuses_Received_stddev,
    STDDEV(Revenue_from_Bonuses) AS Revenue_from_Bonuses_stddev,
    STDDEV(Increase_in_Bets_After_Bonus) AS Increase_in_Bets_After_Bonus_stddev,
    STDDEV(Increase_in_wagering_after_Bonus) AS Increase_in_wagering_after_Bonus_stddev
FROM bonus_allocation;

-- Variance
SELECT 
    VARIANCE(age) AS age_variance,
    VARIANCE(income_level) AS income_level_variance,
    VARIANCE(Winning_percentage) AS Winning_percentage_variance,
    VARIANCE(Days_Since_Last_Bet) AS Days_Since_Last_Bet_variance,
    VARIANCE(Active_Days) AS Active_Days_variance,
    VARIANCE(Total_Number_of_Bets) AS Total_Number_of_Bets_variance,
    VARIANCE(Total_Amount_Wagered) AS Total_Amount_Wagered_variance,
    VARIANCE(Average_Bet_Amount) AS Average_Bet_Amount_variance,
    VARIANCE(Number_of_Bonuses_Received) AS Number_of_Bonuses_Received_variance,
    VARIANCE(Amount_of_Bonuses_Received) AS Amount_of_Bonuses_Received_variance,
    VARIANCE(Revenue_from_Bonuses) AS Revenue_from_Bonuses_variance,
    VARIANCE(Increase_in_Bets_After_Bonus) AS Increase_in_Bets_After_Bonus_variance,
    VARIANCE(Increase_in_wagering_after_Bonus) AS Increase_in_wagering_after_Bonus_variance
FROM bonus_allocation;

-- Range
SELECT 
    MAX(age) - MIN(age) AS age_range,
    MAX(income_level) - MIN(income_level) AS income_level_range,
    MAX(Winning_percentage) - MIN(Winning_percentage) AS Winning_percentage_range,
    MAX(Days_Since_Last_Bet) - MIN(Days_Since_Last_Bet) AS Days_Since_Last_Bet_range,
    MAX(Active_Days) - MIN(Active_Days) AS Active_Days_range,
    MAX(Total_Number_of_Bets) - MIN(Total_Number_of_Bets) AS Total_Number_of_Bets_range,
    MAX(Total_Amount_Wagered) - MIN(Total_Amount_Wagered) AS Total_Amount_Wagered_range,
    MAX(Average_Bet_Amount) - MIN(Average_Bet_Amount) AS Average_Bet_Amount_range,
    MAX(Number_of_Bonuses_Received) - MIN(Number_of_Bonuses_Received) AS Number_of_Bonuses_Received_range,
    MAX(Amount_of_Bonuses_Received) - MIN(Amount_of_Bonuses_Received) AS Amount_of_Bonuses_Received_range,
    MAX(Revenue_from_Bonuses) - MIN(Revenue_from_Bonuses) AS Revenue_from_Bonuses_range,
    MAX(Increase_in_Bets_After_Bonus) - MIN(Increase_in_Bets_After_Bonus) AS Increase_in_Bets_After_Bonus_range,
    MAX(Increase_in_wagering_after_Bonus) - MIN(Increase_in_wagering_after_Bonus) AS Increase_in_wagering_after_Bonus_range
FROM bonus_allocation;

-- Skewness (example shown for 'age', similar format to be followed for each column)
SELECT 
    (
        SUM(POWER(age - (SELECT AVG(age) FROM bonus_allocation), 3)) / 
        (COUNT(*) * POWER((SELECT STDDEV(age) FROM bonus_allocation), 3))
    ) AS age_skewness
FROM bonus_allocation;

-- Kurtosis (example shown for 'age', apply same logic to others)
SELECT 
    (
        (SUM(POWER(age - (SELECT AVG(age) FROM bonus_allocation), 4)) / 
        (COUNT(*) * POWER((SELECT STDDEV(age) FROM bonus_allocation), 4))) - 3
    ) AS age_kurtosis
FROM bonus_allocation;
