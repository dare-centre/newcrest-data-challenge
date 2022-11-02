
###############################################################################
###############################################################################

calculate_model_performance <- function(y_obs, y_mod) {

  # Calculate the model performance metrics:
  #  - R2
  #  - RMSE
  #  - MAE

  # Calculate the metrics
  r2 <- MLmetrics::R2_Score(y_obs, y_mod)
  rmse <- Metrics::rmse(y_obs, y_mod)
  mae <- Metrics::mae(y_obs, y_mod)
  metrics_out <- list(
    "r2" = r2,
    "rmse" = rmse,
    "mae" = mae
  )
  return(metrics_out)
}

###############################################################################
###############################################################################

assess_model_prediction <- function(predictor) {

  # Plot the model performance for training, validation and test data.
  # Return the metrics for model performance.
  # Input:
  #    - predictor: A dataframe with:
  #        - train_y: observed values for training data
  #        - train_y_pred: predicted values for training data
  #        - val_y: observed values for validation data
  #        - val_y_pred: predicted values for validation data
  #        - test_y: observed values for test data
  #        - test_y_pred: predicted values for test data
  # Output:
  #    - metrics: A dataframe with:
  #        - R2
  #        - RMSE
  #        - MAE
  #    - plots for train, validation and test performance

  predictor_colnames <- colnames(predictor)

  # Calculate the metrics
  if ("train_y" %in% predictor_colnames) {
    train_metrics <- calculate_model_performance(
      predictor$train_y, predictor$train_y_pred
    )
    plot_model_fit(
      predictor$train_time, predictor$train_y, predictor$train_y_pred,
      mod_metrics = train_metrics,
      title = "Model fit for training data"
    )
  } else {
    train_metrics <- NULL
  }
  if ("val_y" %in% predictor_colnames) {
    val_metrics <- calculate_model_performance(
      predictor$val_y, predictor$val_y_pred
    )
    plot_model_fit(
      predictor$val_time, predictor$val_y, predictor$val_y_pred,
      mod_metrics = val_metrics,
      title = "Model fit for validation data"
    )
  } else {
    val_metrics <- NULL
  }
  if ("test_y" %in% predictor_colnames) {
    test_metrics <- calculate_model_performance(
      predictor$test_y, predictor$test_y_pred
    )
    plot_model_fit(
      predictor$test_time, predictor$test_y, predictor$test_y_pred,
      mod_metrics = test_metrics,
      title = "Model fit for test data"
    )
  } else {
    test_metrics <- NULL
  }

  # construct dataframe
  metrics <- data.frame(
    "train" = train_metrics,
    "val" = val_metrics,
    "test" = test_metrics
  )

  return(metrics)
}

###############################################################################
###############################################################################

inversescaler_pred_dict <- function(predicted_data, scaler = None) {

  # Construct a dictionary with the model predictions and inverse transform if needed.

  if not scaler is None:
    predicted_data["train_y"] <- scaler.inverse_transform(predicted_data["train_y"])
  predicted_data["train_y_pred"] <- scaler.inverse_transform(predicted_data["train_y_pred"].reshape(-1,1))
  predicted_data["test_y"] <- scaler.inverse_transform(predicted_data["test_y"])
  predicted_data["test_y_pred"] <- scaler.inverse_transform(predicted_data["test_y_pred"].reshape(-1,1))
  if not predicted_data["val_y"] is None:
    predicted_data["val_y"] <- scaler_y.inverse_transform(predicted_data["val_y"])
  predicted_data["val_y_pred"] <- scaler_y.inverse_transform(predicted_data["val_y_pred"].reshape(-1,1))

  return(predicted_data)
}
