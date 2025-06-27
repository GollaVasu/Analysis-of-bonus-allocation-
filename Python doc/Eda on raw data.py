# -*- coding: utf-8 -*-
"""
Created on Tue Apr  1 18:19:38 2025

@author: G Thirumala Vasu
"""

# -*- coding: utf-8 -*-
"""
Created on Mon Feb 10 06:08:43 2025

@author: G Thirumala Vasu
"""

import pandas as pd

data = pd.read_csv(r"C:\Users\G Thirumala Vasu\OneDrive\Desktop\Bonus Allocation Data - Master Data.csv.csv")

data.info()
# Four Business Decision Moments

def EDA(num_column_name):
    if num_column_name in data.columns:
        #Fisrt moment business decision(mean , median , mode)
        mean = data[num_column_name].mean()
        median = data[num_column_name].median()
        mode = data[num_column_name].mode()
        
        print(f"Mean value of {num_column_name} is {mean}")
        print(f"Median value of {num_column_name} is {median}")
        print(f"Mode value of {num_column_name} is {mode}")
        print("")
        
        
        #Second moment Business Decision(Variance, Standard deviation , Range)
        variance = data[num_column_name].var()
        std = data[num_column_name].std()
        datarange = data[num_column_name].max() - data[num_column_name].min()
        
        print(f"Variance of {num_column_name} is {variance}")
        print(f"Standard deviation of {num_column_name} is {std}")
        print(f"Range of {num_column_name} is {datarange}")
        print("")
        
        
        #Third moment Business Decision(skewness)
        skewness = data[num_column_name].skew()
        
        print(f"Skewness of {num_column_name} is {skewness}")
        print("")
        
        
        # Forth moment Business Decision(kurtosis)
        kurtosis = data[num_column_name].kurt()
        
        print(f"Kurtosis of {num_column_name} is {kurtosis}")
        print("")
    
    else:
        print("Column not found")

EDA("age")
EDA("income_level")
EDA("Winning_percentage")
EDA("Days_Since_Last_Bet")    
EDA("Active_Days")    
EDA("Total_Number_of_Bets")    
EDA("Total_Amount_Wagered")    
EDA("Average_Bet_Amount")    
EDA("Number_of_Bonuses_Received")    
EDA("Amount_of_Bonuses_Received")    
EDA("Revenue_from_Bonuses")    
EDA("Increase_in_Bets_After_Bonus")    
EDA("Increase_in_wagering_after_Bonus")    
EDA("Should_Receive_Bonus")    


def mode(cat_column_name):
    if cat_column_name in data.columns:
        mode = data[cat_column_name].mode()
        print(f"Mode of {cat_column_name} is {mode}") 
    else:
        print("Column not found")
        
mode("gender")     
mode("country")    

        
        
        
        
        
        
        