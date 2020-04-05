# Title     : Imputation
# Objective : TODO
# Created by: Amol
# Created on: 4/2/2020





# Apply median imputation: median_model
median_model <- train(
  x = breast_cancer_x,
  y = breast_cancer_y,
  method = "glm",
  trControl = myControl,
  preProcess = "medianImpute"
)

# Print median_model to console
median_model

# Apply KNN imputation: knn_model
knn_model <- train(
  x = breast_cancer_x,
  y = breast_cancer_y,
  method = "glm",
  trControl = myControl,
  preProcess = "knnImpute"
)

# Print knn_model to console
knn_model





#MUTLIPLE IMPUTATIONS AT ONCE

#MEDIAN IMPUTATION THEN CENTER THEN SCALING THEN FIT GLM

# Fit glm with median imputation
model <- train(
  x =breast_cancer_x,
  y = breast_cancer_y,
  method = "glm",
  trControl = myControl,
  preProcess = c("medianImpute", "center", "scale")
)

# Print model
model

# Update model with standardization
model <- train(
  x = breast_cancer_x,
  y = breast_cancer_y,
  method = "glm",
  trControl = myControl,
  preProcess = c("centering", "scale")
)

# Print updated model
model





# Update model with standardization
model <- train(
  x = breast_cancer_x,
  y = breast_cancer_y,
  method = "glm",
  trControl = myControl,
  preProcess = c("center", "scale")
)

# Print updated model
model


#removing
#using "zv" "nzv"



# Identify near zero variance predictors: remove_cols
remove_cols <- nearZeroVar(bloodbrain_x, names = TRUE,
                           freqCut = 2, uniqueCut = 20)

# Get all column names from bloodbrain_x: all_cols
all_cols <- names(bloodbrain_x)

# Remove from data: bloodbrain_x_small
bloodbrain_x_small <- bloodbrain_x[ , setdiff(all_cols, remove_cols)]

#in the above lines I dont knwo wht has happned?


# Fit model on reduced data: model
model <- train(
  x =bloodbrain_x_small,
  y = bloodbrain_y,
  method = "glm"
)

# Print model to console
model


#PCA low varaince variable into high variance perpendicular predictors.


# Fit glm model using PCA: model
model <- train(
  x = bloodbrain_x,
  y = bloodbrain_y,
  method = "glm",
  preProcess = "pca"
)

# Print model to console
model
