# Load required libraries
library(ggplot2)
library(dplyr)
library(lubridate)

# Read the dataset
data <- read.csv("FinalDS.csv")

# Convert the Date column to a proper date format
data$Date <- dmy(data$Date)

# Filter the data for Washington State only
wa_data <- data %>% filter(State == "WA")

# Group the data by year and calculate the total electric vehicles and total vehicles for each year and county
yearly_county_data <- wa_data %>%
  mutate(Year = year(Date)) %>%
  group_by(Year, County) %>%
  summarize(Total_EV = sum(`Electric.Vehicle..EV..Total`), Total_Vehicles = sum(`Total.Vehicles`))

# Calculate the percentage of electric vehicles
yearly_county_data <- mutate(yearly_county_data, Percent_EV = (Total_EV / Total_Vehicles) * 100)

# Plotting the trend in electric vehicle adoption by county
ggplot(yearly_county_data, aes(x = Year, y = Percent_EV, color = County)) +
  geom_line() +
  geom_point() +
  labs(title = "Electric Vehicle Adoption in Washington State by County",
       x = "Year", y = "Percentage of Electric Vehicles") +
  theme_minimal() +
  theme(legend.position = "bottom", legend.title = element_blank())



