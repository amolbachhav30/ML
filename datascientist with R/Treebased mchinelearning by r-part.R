# Title     : TODO
# Objective : TODO
# Created by: Amol
# Created on: 4/4/2020
install.packages("rpart")
library("rpart")
install.packages("rpart.plot")
library("rpart.plot")
creditsub <- read.csv("credit.csv")

gradesub <- read.csv("grade.csv")




#working with creditsub dataframe to find out number of default.

# Look at the data
str(creditsub)

# Create the model
credit_model <- rpart(formula = default ~ .,
                      data = creditsub,
                      method = "class")

# Display the results
rpart.plot(x = credit_model , yesno = 2, type = 0, extra = 0)

# Total number of rows in the credit data frame
n <- nrow(creditsub)

# Number of rows for the training set (80% of the dataset)
n_train <- round(0.80 * n)

# Create a vector of indices which is an 80% random sample
set.seed(123)
train_indices <- sample(1:n, n_train) #feeding 1to n rows of n_train


# Subset the credit data frame to training indices only
credit_train <- creditsub[train_indices, ]

# Exclude the training indices to create the test set
credit_test <- creditsub[-train_indices, ]

# Train the model (to predict 'default')
credit_model <- rpart(formula = default~.,
                      data = credit_train,
                      method = "class")

# Look at the model output
print(credit_model)


# Generate predicted classes using the model object
class_prediction <- predict(object = credit_model,
                            newdata = credit_test,
                            type = "class")

# Calculate the confusion matrix for the test set
caret::confusionMatrix(data = class_prediction,
                reference = credit_test$default)


# Train a gini-based model
credit_model1 <- rpart(formula = default ~ .,
                       data = credit_train,
                       method = "class",
                       parms = list(split = "gini"))

# Train an information-based model
credit_model2 <- rpart(formula = default ~ .,
                       data = credit_train,
                       method = "class",
                       parms = list(split = "information"))

# Generate predictions on the validation set using the gini model
pred1 <- predict(object = credit_model1,
                 newdata = credit_test,
                 type = "class")
head(pred1)
# Generate predictions on the validation set using the information model
pred2 <- predict(object = credit_model2,
                 newdata = credit_test,
                 type = "class")

# Compare classification error
Metrix::ce(actual = credit_test$default,
   predicted = pred1)
Metrix::ce(actual = credit_test$default,
   predicted = pred2)