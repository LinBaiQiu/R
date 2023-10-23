# Load necessary libraries
if (!require(ggplot2)) install.packages("ggplot2")
if (!require(dplyr)) install.packages("dplyr")
if (!require(readr)) install.packages("readr")
if (!require(gridExtra)) install.packages("gridExtra")

library(ggplot2)
library(dplyr)
library(readr)
library(gridExtra)

# Read survey data from a CSV file (replace with your file path)
survey_data <- read_csv("D:\\GitHub\\R\\survey_data.csv")  # Replace with the correct file path

# Data visualization

# Create chart 1: Bar chart for a categorical variable (e.g., Gender)
chart1 <- ggplot(data = survey_data, aes(x = Gender)) +
  geom_bar(fill = "skyblue") +
  labs(title = "Gender Distribution", x = "Gender", y = "Count") +
  theme_minimal()

# Create chart 2: Histogram for a numeric variable (e.g., Age)
chart2 <- ggplot(data = survey_data, aes(x = Age)) +
  geom_histogram(fill = "lightgreen", binwidth = 5) +
  labs(title = "Age Distribution", x = "Age", y = "Count") +
  theme_minimal()

# Create chart 3: Box plot for a numeric variable (e.g., Income) by a categorical variable (e.g., Education)
chart3 <- ggplot(data = survey_data, aes(x = Education, y = Income)) +
  geom_boxplot(fill = "salmon") +
  labs(title = "Income Distribution by Education", x = "Education", y = "Income") +
  theme_minimal()

# Arrange the charts in parallel using grid.arrange
grid.arrange(chart1, chart2, chart3, ncol = 3)
