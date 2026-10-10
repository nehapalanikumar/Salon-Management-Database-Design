"""
Salon Data Visualisations

This script generates visualisations from the salon dataset
using Pandas and Matplotlib.

Skills demonstrated:
- Data visualisation
- Pandas
- Matplotlib
- Exploratory data analysis
"""

import pandas as pd 
import matplotlib.pyplot as plt

# loads dataset
values = pd.read_csv("beezkneezvisualisation.csv")  

#------------------------------------------------------------
# treatment popularity pie chart
#------------------------------------------------------------
colours = [
  'pink', 'silver', 'steelblue','green',
  'orange', 'blue', 'red', 'purple', 
  'yellow', 'brown', 'gold'
] 

explode = (
  0.05, 0.05, 0.05,0.05,
  0.05, 0.05, 0.05, 0.05,
  0.05,0.05, 0.05
) 

chart = values["Description"].value_counts().plot(
  kind="pie",
  title="Treatments", 
  autopct='%1.0f%%', 
  explode=explode, 
  colors=colours, 
  shadow=True
) 

# gets rid of the labels for the x and y axis
chart.xaxis.set_visible(False) 

#------------------------------------------------------------
# booking cost boxplot
#------------------------------------------------------------
values.boxplot(column="TotalCostAfterDiscount")

#------------------------------------------------------------
# treatment duration histogram
#------------------------------------------------------------
plt.hist(values['TreatmentTime'], bins=5)

plt.xlabel('Treatment Duration')
plt.ylabel('Frequency')
plt.title('Distribution of Treatment Durations')

#------------------------------------------------------------
# membership booking comparison
#------------------------------------------------------------
bookings_gold = values[
  values['MembershipLevel'] == 'GOLD'
].shape[0]
bookings_silver = values[
  values['MembershipLevel'] == 'SILVER'
].shape[0]
bookings_bronze = values[values[
  'MembershipLevel'] == 'BRONZE'
].shape[0]
bookings_without_membership = values[
  values['MembershipLevel'].isnull()
].shape[0]
 

categories = [
  'Gold', 
  'Silver', 
  'Bronze', 
  'Without Membership'
]

booking_counts = [
  bookings_gold,
  bookings_silver, 
  bookings_bronze, 
  bookings_without_membership
]
plt.bar(categories, booking_counts)
 
# Adding labels and title
plt.xlabel('Membership')
plt.ylabel('Number of Bookings')
plt.title('Bookings by Membership Type')
