library(ggplot2)
library(dplyr)
library(reshape2)



data <- read.csv("FinalDS.csv")
data$Date <- as.Date(data$Date, format = "%d/%m/%y")



# Visualize the overall trend of EV registrations over time
ggplot(data, aes(Date, `Electric.Vehicle..EV..Total`)) +
  geom_line() +
  scale_x_date(date_labels = "%Y") +
  labs(x = "Year", y = "EV Registrations") +
  theme_minimal()
summary(data)



# Filter data for Washington (WA)
wa_data <- subset(data, State == "WA")

# Extract the year from the Date column
wa_data$Year <- format(wa_data$Date, "%Y")

# Aggregate the EV registrations by County, Year, and calculate the sum
agg_data <- aggregate(`Electric.Vehicle..EV..Total` ~ County + Year, wa_data, sum)

# Reshape the data to wide format
wide_data <- dcast(agg_data, County ~ Year, value.var = "Electric.Vehicle..EV..Total")

# Display the table
wide_data


# Perform linear regression
linear_model <- lm(`Electric.Vehicle..EV..Total` ~ as.numeric(Year), data = agg_data)

# Display the summary of the linear model
summary(linear_model)


ggplot(agg_data, aes(x = as.numeric(Year), y = `Electric.Vehicle..EV..Total`)) +
  geom_point() +
  geom_smooth(method = "lm", se = FALSE, color = "blue") +
  labs(x = "Year", y = "EV Registrations") +
  theme_minimal()

