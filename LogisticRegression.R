# Teryn Morgan 
# Logistic Regression Model
install.packages("visreg")
install.packages("effects") 
library(effects)
library(visreg)
library(ggplot2)

# Read data
diabetes_data <- read.csv(file.path("Project/Cleaned_Diabetes_Dataset.csv"), stringsAsFactors = FALSE)

# Vector containing 1/0s to be added as a column in diabetes_data
TRUE_CVD <- c()
table(TRUE_CVD) # 0 - 612, 1 - 322 --> 0 - 540 1- 405

# Iterate over each row of diabetes_data
# If values in the record meets criteria, adds 1 to TRUE_CVD vector  
# Deterministic values based on histogram distributions in ExploratoryAnalysis.R and literature in Project Proposal II
for(record in 1:nrow(diabetes_data)){
  # If Age > 50 OR BMI > 28
  if (((diabetes_data[record, ]$AGE > 55) || (diabetes_data[record, ]$BMI > 25)) 
      # AND TG > 2.5 OR HDL < 0.75 OR LDL > 3.5 OR VLDL > 3
      && ((diabetes_data[record, ]$TG > 2.5) || (diabetes_data[record, ]$HDL < 0.75) || (diabetes_data[record, ]$LDL > 3.5) || (diabetes_data[record, ]$VLDL > 3))) {
    TRUE_CVD <- append(TRUE_CVD, 1)
  }
  # If record doesn't meet criteria, adds 0 to TRUE_CVD vector 
  else {
    TRUE_CVD <- append(TRUE_CVD, 0)
  }
} 

# Bind TRUE_CVD columns to diabetes_data
TRUE_CVD <- as.factor(TRUE_CVD)
diabetes_data <- cbind(diabetes_data, TRUE_CVD)

# Logistic Regression Train & Test splits
set.seed(1234)

# 70% for training and 30% for testing
sample <- sample(c(TRUE, FALSE), nrow(diabetes_data), replace=TRUE, prob=c(0.7,0.3))
train <- diabetes_data[sample, ]
test <- diabetes_data[!sample, ] 

# Logistic Regression model construction using training data
# From this model AGE, TG, LDL, VLDL, BMI, and CLASS were significant attributes
model1 <- glm(CVD ~ AGE + Urea + Cr + HbA1c + Chol + TG + HDL + LDL + VLDL + BMI + CLASS, family="binomial"(link="logit"), data=train)
summary(model1)

# Model using significant attributes
model2 <-glm(CVD ~ AGE + TG + LDL + VLDL + BMI + CLASS, family="binomial"(link="logit"), data=train)
summary(model2)

# Model Visualizations
plot(model2)
visreg(model2, "CVD", by="CLASS")
visreg(model2)

# Validate model on test data
pred <- predict(model2, newdata = test, type = "response")
y_pred_num <- ifelse(pred > 0.5, 1, 0)
y_pred <- factor(y_pred_num, levels=c(0, 1))
y_act <- test$CVD

# Model Evaluation Metrics with splits
accuracy <- mean(y_pred == y_act) # 0.894
conf_matrix <- confusionMatrix(y_pred, y_act) 
confidence_intervals <- confint(model2)
odd_ratios <- coef(model2)

# Plot Confusion Matrix
cm <- confusionMatrix(factor(y_pred), factor(y_act), dnn = c("Prediction", "Reference"))

plt <- as.data.frame(cm$table)
plt$Prediction <- factor(plt$Prediction, levels=rev(levels(plt$Prediction)))

ggplot(plt, aes(Prediction, Reference, fill= Freq)) +
  geom_tile() + geom_text(aes(label=Freq)) +
  scale_fill_gradient(low="white", high="#009194") +
  labs(x = "Reference",y = "Prediction") +
  ggtitle("Test Data Confusion Matrix")
  scale_x_discrete(labels=c("Class_1","Class_2","Class_3","Class_4")) +
  scale_y_discrete(labels=c("Class_4","Class_3","Class_2","Class_1"))

# Get predicted values into a column in diabetes_data
log_CVD_pred <- predict(model2, newdata = diabetes_data, type = "response")
factor_CVD_pred <- ifelse(log_CVD_pred > 0.5, 1, 0)
factor_CVD_pred <- factor(y_CVD_pred, levels=c(0, 1))

Predicted_CVD_Log <- c()
for (i in log_CVD_pred){
  Predicted_CVD_Log<- append(Predicted_CVD_Log, i)
}
diabetes_data <- cbind(diabetes_data, Predicted_CVD_Log) # Logistic values

Predicted_CVD_Factor <- c()
for (i in factor_CVD_pred){
  Predicted_CVD_Factor <- append(Predicted_CVD_Factor, i)
}
diabetes_data <- cbind(diabetes_data, Predicted_CVD_Factor) # Factor values

write.csv(diabetes_data, "Predicted_Diabetes_Dataset.csv", row.names = FALSE)

