# Title     : TODO
# Objective : TODO
# Created by: Amol
# Created on: 4/3/2020
set.seed(42)

load("churn.Rdata")
install.packages("caret")
library("caret")
install.packages("C50")
library("C50")
install.packages("glmnet")
library("glmnet")
install.packages("ranger")
library("ranger")



churn_y

#crating train control object

# Create custom indices: myFolds
myFolds <- createFolds(churn_y, k = 5)

# Create reusable trainControl object: myControl
myControl <- trainControl(
  summaryFunction = twoClassSummary,
  classProbs = TRUE, # IMPORTANT!
  verboseIter = TRUE,
  savePredictions = TRUE,
  index = myFolds
)

#fiting glmnet
# Fit glmnet model: model_glmnet
model_glmnet <- train(
  x = churn_x,
  y = churn_y,
  metric = "ROC",
  method = "glmnet",
  trControl = myControl
)


#- Fold5: alpha=1.00, lambda=0.01821
#Aggregating results
#Selecting tuning parameters
#Fitting alpha = 1, lambda = 0.0182 on full training set



#fitting random forest
model_rf <- train(
  x = churn_x,
  y =churn_y,
  metric = "ROC",
  method = "ranger",
  trControl = myControl
)



set.seed(42)

churn_x$churn <- facor(churn_x, levels= c("no", "yes"))

model_rf<- train(churn~. , churn_x, metric= "ROC", method= "ranger", trControl= myControl )

#make a list
model_list <- list(glmnet= model_glmnet, rf= model_rf)

#Collect resamples from cv folds

resamp <- resamples(model_list)
resamp

summary(resamp)

# Create bwplot
bwplot(resamples, metric = "ROC")

#creat xy plot
xyplot(resamples, metric = "ROC")

#create ensemble
# Create ensemble model: stack
stack <- caretStack(model_list, method = "glm")

# Look at summary
summary(stack)


