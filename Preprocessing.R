# Pre-processing Steps
# Import libraries
library(readr)

# Read data
diabetes_data <- read.csv(file.path("Diabetes_Dataset.csv"), stringsAsFactors = FALSE)

# Filter for Age < 65
diabetes_under_65 <- subset(diabetes_data, AGE < 65) 

# Replace Gender with binary values M = 0, F = 1
diabetes_under_65$Gender[diabetes_under_65$Gender == 'M'] <- 0
diabetes_under_65$Gender[diabetes_under_65$Gender == 'F'] <- 1

# Replace Class with numerical values N=0, P=1, Y=2
diabetes_under_65$CLASS[diabetes_under_65$CLASS == 'N'] <- 0
diabetes_under_65$CLASS[diabetes_under_65$CLASS == 'P'] <- 1
diabetes_under_65$CLASS[diabetes_under_65$CLASS == 'Y'] <- 2

# Write to CSV file
write_csv(diabetes_under_65, "Cleaned_Diabetes_Dataset.csv")
