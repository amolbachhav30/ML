# Title     :study random forest
# Objective : TODO
# Created by: Amol
# Created on: 4/1/2020

install.packages("mlbench")
install.packages("caret")
install.packages("dplyr")
install.packages("caTools")
install.packages("ranger")
library("mlbench")
library("dplyr")
library("caret")
library("caTools")
library(ranger)

wine<- readRDS("C:/Users/Amol/OneDrive - The University of Texas at Dallas/datascientist with R/wine_100.RDS")

head(wine)


# Fit random forest: model
model <- train(
  quality ~ .,
  tuneLength = 35,
  data = wine,
  method = "ranger",
  trControl = trainControl(
    method = "cv",
    number = 5,
    verboseIter = TRUE
  )
)

# Print model to console
plot(model)


# Fit random forest: model
model <- train(
  quality ~ .,
  tuneLength = 3,
  data = wine,
  method = "ranger",
  trControl = trainControl(
    method = "cv",
    number = 5,
    verboseIter = TRUE
  )
)

# Print model to console

plot(model)
# Plot model


# Define the tuning grid: tuneGrid
tuneGrid <- data.frame(
  .mtry = c(2,3,7),
  .splitrule = "variance",
  .min.node.size = 5
)


# Fit random forest: model
model <- train(
  quality ~.,
  tuneGrid = tuneGrid,
  data = wine,
  method = "ranger",
  trControl = trainControl(
    method = "cv",
    number = 5,
    verboseIter = TRUE
  )
)

# Print model to console

model
# Plot model
plot(model)




#glmnet

myControl <- trainControl(
  method = "cv",
  number = 10,
  summaryFunction = twoClassSummary,
  classProbs = TRUE, # IMPORTANT!
  verboseIter = TRUE
)

# Fit glmnet model: model
model <- train(
  y ~ .,
  overfit,
  method = "glmnet",
  trControl = myControl
)
# Print model to console
model

# Print maximum ROC statistic
max(model[["results"]][["ROC"]])




# Train glmnet with custom trainControl and tuning: model
model <- train(
  y~.,
  overfit,
  tuneGrid = expand.grid(
    alpha= 0:1,
    lambda= seq(0.0001,1, length=20 )
  ),
  method = "glmnet",
  trControl = myControl
)

# Print model to console
model

# Print maximum ROC statistic
max(model[["results"]][["ROC"]])