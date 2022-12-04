# Exploratory Analysis

# Read Data
diabetes_data <- read.csv(file.path("Cleaned_Diabetes_Dataset.csv"), stringsAsFactors = FALSE)

# Histograms per column
# UREA
hist(diabetes_data$Urea, breaks = 30, main = paste("Histogram of Urea Column"), xlab = 'Urea', xaxt='n')
axis(side=1, at=seq(0, 40, 0.5), labels=seq(0, 40, 0.5))

# CR
hist(diabetes_data$Cr, breaks = 30, main = paste("Histogram of Cr Column"), xlab = 'Cr', xaxt='n')
axis(side=1, at=seq(0, 800, 100), labels=seq(0, 800, 100))

# HbA1c
hist(diabetes_data$HbA1c, breaks = 30, main = paste("Histogram of HbA1c Column"), xlab = 'HbA1c', xaxt='n')
axis(side=1, at=seq(0, 16, 0.5), labels=seq(0, 16, 0.5))

# CHOL
hist(diabetes_data$Chol, breaks = 30, main = paste("Histogram of Chol Column"), xlab = 'Chol', xaxt='n')
axis(side=1, at=seq(0, 11, 0.5), labels=seq(0, 11, 0.5))

# AGE
hist(diabetes_data$AGE, breaks = 30, main = paste("Histogram of Age"), xlab = 'Age', xaxt='n')
axis(side=1, at=seq(20, 70, 5), labels=seq(20, 70, 5))

# BMI
hist(diabetes_data$BMI, breaks = 30, main = paste("Histogram of BMI Column"), xlab = 'BMI', xaxt='n')
axis(side=1, at=seq(15, 50, 5), labels=seq(15, 50, 5))

# TG
hist(diabetes_data$TG, breaks = 30, main = paste("Histogram of TG Column"), xlab = 'TG', xaxt='n')
axis(side=1, at=seq(0, 14, 0.5), labels=seq(0, 14, 0.5))

# HDL
hist(diabetes_data$HDL, breaks = 35, main = paste("Histogram of HDL Column"), xlab = 'HDL', xaxt='n')
axis(side=1, at=seq(0, 10, 0.5), labels=seq(0, 10, 0.5))

# VLDL
hist(diabetes_data$VLDL, breaks = 30, main = paste("Histogram of VLDL Column"), xlab = 'VLDL', xaxt='n')
axis(side=1, at=seq(0, 34, 0.5), labels=seq(0, 34, 0.5))

# LDL
hist(diabetes_data$LDL, breaks = 30, main = paste("Histogram of LDL Column"), xlab = 'LDL', xaxt='n')
axis(side=1, at=seq(0, 8, 0.5), labels=seq(0, 8, 0.5))

