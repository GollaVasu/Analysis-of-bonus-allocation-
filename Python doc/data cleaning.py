# -*- coding: utf-8 -*-
"""
Created on Tue Apr  1 19:46:59 2025

@author: G Thirumala Vasu
"""

# -*- coding: utf-8 -*-
"""
Created on Mon Feb 10 19:10:21 2025

@author: G Thirumala Vasu
"""

# Data preprocessing

import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
import seaborn as sns
from sklearn.impute import SimpleImputer

data = pd.read_csv(r"C:\Users\G Thirumala Vasu\OneDrive\Desktop\Bonus Allocation Data - Master Data.csv.csv")
data.shape          #(6814, 14)
data.describe()
data.info()


# Handling Duplicates
data.duplicated().sum()
# no duplicates

# Outlier Treatment

#Boxplot to visualize outliers
sns.boxplot(data["age"])
plt.title("Box plot of age")

sns.boxplot(data["income_level"])
plt.title("Box plot of income_level")

sns.boxplot(data["Winning_percentage"])
plt.title("Box plot of Winning_percentage")

sns.boxplot(data["Days_Since_Last_Bet"])
plt.title("Box plot of Days_Since_Last_Bet")

sns.boxplot(data["Active_Days"])
plt.title("Box plot of Active_Days")

sns.boxplot(data["Total_Number_of_Bets"])
plt.title("Box plot of Total_Number_of_Bets")

sns.boxplot(data["Total_Amount_Wagered"])
plt.title("Box plot of Total_Amount_Wagered")

sns.boxplot(data["Average_Bet_Amount"])
plt.title("Box plot of Average_Bet_Amount")

sns.boxplot(data["Number_of_Bonuses_Received"])
plt.title("Box plot of Number_of_Bonuses_Received")

sns.boxplot(data["Amount_of_Bonuses_Received"])
plt.title("Box plot of Amount_of_Bonuses_Received")

sns.boxplot(data["Revenue_from_Bonuses"])
plt.title("Box plot of Revenue_from_Bonuses")

sns.boxplot(data["Increase_in_Bets_After_Bonus"])
plt.title("Box plot of Increase_in_Bets_After_Bonus")

sns.boxplot(data["Increase_in_wagering_after_Bonus"])
plt.title("Box plot of Increase_in_wagering_after_Bonus")

sns.boxplot(data["Should_Receive_Bonus"])
plt.title("Box plot of Should_Receive_Bonus")




#Detecting outliers using IQR method
columns = ["age", "income_level", "Winning_percentage","Days_Since_Last_Bet","Active_Days",
           "Total_Number_of_Bets","Total_Amount_Wagered","Average_Bet_Amount"]

for col in columns:
    Q1 = data[col].quantile(0.25)
    Q3 = data[col].quantile(0.75)
    IQR = Q3 - Q1

    lower_bound = Q1 - 1.5 * IQR
    upper_bound = Q3 + 1.5 * IQR

    Outliers = data[(data[col] < lower_bound) | (data[col] > upper_bound)]
   
    # Replaceing the outliers with median value
    Median_value = data[col].median()
    data[col] = data[col].apply(lambda x : Median_value if(x < lower_bound or x > upper_bound) else x)


# Missing Values
print(data.isna().sum())  # Shows the count of NaN values in each column
data.fillna(0, inplace=True)  # Replace NaNs with 0 (or use another strategy like mean)

# no missingvalues


sns.histplot(data["age"], bins = 20)
sns.histplot(data["income_level"] , bins = 20)
sns.histplot(data["Winning_percentage"], bins = 20)
sns.histplot(data["Days_Since_Last_Bet"] , bins = 20)
sns.histplot(data["Active_Days"], bins = 20)
sns.histplot(data["Total_Number_of_Bets"] , bins = 20)
sns.histplot(data["Total_Amount_Wagered"], bins = 20)
sns.histplot(data["Average_Bet_Amount"] , bins = 20)
sns.histplot(data["Number_of_Bonuses_Received"], bins = 20)
sns.histplot(data["Amount_of_Bonuses_Received"] , bins = 20)
sns.histplot(data["Revenue_from_Bonuses"], bins = 20)
sns.histplot(data["Increase_in_Bets_After_Bonus"] , bins = 20) 
sns.histplot(data["Increase_in_wagering_after_Bonus"] , bins = 20)
sns.histplot(data["Increase_in_Bets_After_Bonus"] , bins = 20)


# Discretization 

data['age'] = data['age'].round(0).astype(int)
data['income_level'] = data['income_level'].round(0).astype(int)
data['Winning_percentage'] = data['Winning_percentage'].round(0).astype(int)
data['Days_Since_Last_Bet'] = data['Days_Since_Last_Bet'].round(0).astype(int)
data['Active_Days'] = data['Active_Days'].round(0).astype(int)
data['Total_Number_of_Bets'] = data['Total_Number_of_Bets'].round(0).astype(int)
data['Total_Amount_Wagered'] = data['Total_Amount_Wagered'].round(0).astype(int)
data['Average_Bet_Amount'] = data['Average_Bet_Amount'].round(0).astype(int)
data['Number_of_Bonuses_Received'] = data['Number_of_Bonuses_Received'].round(0).astype(int)
data['Amount_of_Bonuses_Received'] = data['Amount_of_Bonuses_Received'].round(0).astype(int)
data['Revenue_from_Bonuses'] = data['Revenue_from_Bonuses'].round(0).astype(int)
data['Increase_in_Bets_After_Bonus'] = data['Increase_in_Bets_After_Bonus'].round(0).astype(int)
data['Increase_in_wagering_after_Bonus'] = data['Increase_in_wagering_after_Bonus'].round(0).astype(int)
data['Should_Receive_Bonus'] = data['Should_Receive_Bonus'].round(0).astype(int)

print(data.dtypes)



data.to_csv("Cleaned data12.csv", index = False)
import os
print(os.getcwd())
