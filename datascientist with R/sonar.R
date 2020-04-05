# Title     : classification at sonar
# Objective : "to apply statistical analysis on sonar data sets"
# Created by: Amol
# Created on: 3/31/2020


install.packages("mlbench")
install.packages("caret")
install.packages("dplyr")
install.packages("caTools")
library("mlbench")
library("dplyr")
library("caret")
library("caTools")


Sonar
head(Sonar)
rows <- sample(nrow(Sonar))
rows
Sonar<- Sonar[rows, ]
# Get the number of observations
n_obs <- nrow(Sonar)

# Shuffle row indices: permuted_rows
permuted_rows <- sample(nrow(Sonar))

# Randomly order data: Sonar
Sonar_shuffled <- Sonar[permuted_rows,]

# Identify row to split on: split
split <- round(n_obs * 0.60)

# Create train
train<- Sonar_shuffled[1:split,]

# Create test
test<- Sonar_shuffled[(split+1):n_obs, ]
head(train)
head(test)

nrow(train)/ nrow(Sonar)


#training a data
# Fit glm model: model
model<- glm(Class~ ., family= "binomial",train)

# Predict on test: p
p <- predict(model, test, "response")


head(p)
# If p exceeds threshold of 0.5, M else R: m_or_r
m_or_r <- ifelse(p>0.50, "M", "R")

# Convert to factor: p_class
p_class<-factor( m_or_r, levels= levels(test[["Class"]]))

# Create confusion matrix
confusionMatrix(p_class, test[["Class"]])


#threshhold 0.9


# If p exceeds threshold of 0.9, M else R: m_or_r
m_or_r <- ifelse( p> 0.9, "M", "R")

# Convert to factor: p_class

p_class <- factor(m_or_r, levels= levels(test[["Class"]]))

# Create confusion matrix
confusionMatrix(p_class, test[["Class"]])


#threshold= 0.1
# If p exceeds threshold of 0.1, M else R: m_or_r

m_or_r <- ifelse( p> 0.1, "M", "R")
# Convert to factor: p_class
p_class <- factor(m_or_r, levels= levels(test[["Class"]]))

# Create confusion matrix
confusionMatrix(p_class, test[["Class"]])

# Predict on test: p
p <- predict(model, test, type="response")

# Make ROC curve
colAUC(p, test[["Class"]],plotROC= TRUE)

# Create trainControl object: myControl
myControl <- trainControl (
  method = "cv",
  number = 10,
  summaryFunction = twoClassSummary,
  classProbs = TRUE, # IMPORTANT!
  verboseIter = TRUE
)

# Train glm with custom trainControl: model
model <- train(
  Class ~ .,
  Sonar,
  method = "glm",
  trControl = myControl
)


# Print model to console
model


