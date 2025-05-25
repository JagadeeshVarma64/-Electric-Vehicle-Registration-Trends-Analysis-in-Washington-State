# Load the necessary libraries
library(ggplot2)
library(dplyr)

# Read the dataset
data <- read.csv("FinalDS.csv")

head(data)
str(data)
summary(data)



# Convert the Date column to a proper date format
data$Date <- as.Date(data$Date, format = "%d/%m/%y")

hist(data$Date, breaks = "months", xlab = "Date", main = "Histogram of Dates")


hist(data$Percent.Electric.Vehicles, xlab = "Percent Electric Vehicles", main = "Histogram of Percent Electric Vehicles")


# Subset the data for Washington State
wa_data <- data %>% filter(State == "WA")

# Group the data by County and year, and calculate the total electric vehicles for each year
county_data <- wa_data %>%
  group_by(County, Year = lubridate::year(Date)) %>%
  summarise(Total_EV = sum(Electric.Vehicle..EV..Total))

# Calculate the overall trend in electric vehicle adoption in Washington State over the past decade
overall_trend <- county_data %>%
  group_by(Year) %>%
  summarise(Total_EV = sum(Total_EV))

# Plot the overall trend in electric vehicle adoption
ggplot(overall_trend, aes(x = Year, y = Total_EV)) +
  geom_line() +
  labs(x = "Year", y = "Total Electric Vehicles", title = "Overall Trend in Electric Vehicle Adoption in Washington State")


# Plot the electric vehicle adoption by vehicle primary use
ggplot(wa_data, aes(x = Vehicle.Primary.Use, fill = Vehicle.Primary.Use)) +
  geom_bar() +
  labs(x = "Vehicle Primary Use", y = "Count", title = "Electric Vehicle Adoption by Vehicle Primary Use") +
  scale_fill_discrete(name = "Vehicle Primary Use")

# Plot the distribution of percent electric vehicles by county
ggplot(wa_data, aes(y = County, x = Percent.Electric.Vehicles)) +
  geom_boxplot() +
  labs(y = "County", x = "Percent Electric Vehicles", title = "Distribution of Percent Electric Vehicles by County")

