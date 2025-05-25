#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Sat Dec  2 15:56:46 2023

@author: gadirajujagadeeshvarma
"""

import pandas as pd
import matplotlib.pyplot as plt
import chardet
import seaborn as sns

# Detect file encoding
with open('FinalDS.csv', 'rb') as f:
    result = chardet.detect(f.read())
encoding = result['encoding']


# Read CSV file with detected encoding
df = pd.read_csv('FinalDS.csv', encoding=encoding)

df['Date'] = pd.to_datetime(df['Date'])


# Add columns for year and quarter
df['Year'] = df['Date'].dt.year  
df['Quarter'] = df['Date'].dt.quarter

# Plot quarters separately for each year
years = df['Year'].unique()
for year in years:
    subset = df[df['Year']==year] 
    plt.figure()
    plt.plot(subset['Quarter'], subset['Electric Vehicle (EV) Total'], marker='o')
    plt.xlabel('Quarter')
    plt.ylabel('EV Registrations')
    plt.title(f'EV Registrations by Quarter, {year}')

# Boxplot by quarter  
sns.boxplot(data=df, x='Quarter', y='Electric Vehicle (EV) Total')
plt.xlabel('Quarter')
plt.ylabel('EV Registrations')
plt.title('Distribution of EV Registrations by Quarter')

# Get mean quarterly registrations
print(df.groupby(['Year', 'Quarter']).mean())

df = df.set_index('Date').resample('Q').sum()

# Plot horizontal bars 
ax = df[['Battery Electric Vehicles (BEVs)', 
         'Plug-In Hybrid Electric Vehicles (PHEVs)']].plot.barh(figsize=(8,10))

xticks = df.index.to_series().dt.to_period('Q') 
ax.set_yticklabels(xticks)

ax.set_ylabel("Quarter")
ax.set_xlabel("Registrations")
ax.legend(loc='lower right') 

for container in ax.containers:
    ax.bar_label(container)
    
ax.set_title("EV Registrations by Quarter")  

# Scatter plot
plt.figure()
plt.scatter(df.index, df['Electric Vehicle (EV) Total'])
plt.xlabel('Year')
plt.ylabel('EV Registrations')
plt.title('Scatter Plot of EV Registrations Over Time')

plt.tight_layout()
plt.show()