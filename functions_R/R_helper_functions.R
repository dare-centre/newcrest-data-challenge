
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

assess_model_prediction <- function(predictor, test = FALSE) {

  # Plot the model performance for training, validation and test data.
  # Return the metrics for model performance.
  # Input:
  #    - predictor: A dataframe with,
  #        - train_y       observed values for training data
  #        - train_y_pred  predicted values for training data
  #        - val_y         observed values for validation data
  #        - val_y_pred    predicted values for validation data
  #        - test_y        observed values for test data
  #        - test_y_pred   predicted values for test data
  #   - test: False - set to True to get test set results
  # Output:
  #    - metrics: A dataframe with,
  #        - R2
  #        - RMSE
  #        - MAE
  #    - plots for train, validation and test performance

  predictor_names <- names(predictor)

  # Calculate the metrics
  if ("train_y" %in% predictor_names) {
    train_metrics <- calculate_model_performance(
      predictor$train_y, predictor$train_y_pred
    )
    ### DEBUG
    cat("\npredictor$train_time", head(predictor$train_time), sep = " ")
    cat("\npredictor$train_y", head(predictor$train_y), sep = " ")
    cat("\npredictor$train_y_pred", head(predictor$train_y_pred), sep = " ")
    cat("\n")
    ### END DEBUG
    plot_model_fit(
      predictor$train_time, predictor$train_y, predictor$train_y_pred,
      mod_metrics = train_metrics,
      title = "Model fit for training data"
    )
  } else {
    train_metrics <- NULL
  }
  if ("val_y" %in% predictor_names) {
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
  if ("test_y" %in% predictor_names) {
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

  # construct list
  metrics <- list(
    "train" = train_metrics,
    "val" = val_metrics,
    "test" = test_metrics
  )

  return(metrics)
}

###############################################################################
###############################################################################

inversescaler_predictor <- function(predictor) {

  # Inverse scale selected predictor dataframe columns.

  predictor$train_y <- predictor$train_y *
    attr(predictor$train_y, "scaled:scale") +
    attr(predictor$train_y, "scaled:center")
  attr(predictor$train_y, "scaled:scale") <- NULL
  attr(predictor$train_y, "scaled:center") <- NULL

  predictor$train_y_pred <- predictor$train_y_pred *
    attr(predictor$train_y_pred, "scaled:scale") +
    attr(predictor$train_y_pred, "scaled:center")
  attr(predictor$train_y_pred, "scaled:scale") <- NULL
  attr(predictor$train_y_pred, "scaled:center") <- NULL

  predictor$test_y <- predictor$test_y *
    attr(predictor$test_y, "scaled:scale") +
    attr(predictor$test_y, "scaled:center")
  attr(predictor$test_y, "scaled:scale") <- NULL
  attr(predictor$test_y, "scaled:center") <- NULL

  predictor$test_y_pred <- predictor$test_y_pred *
    attr(predictor$test_y_pred, "scaled:scale") +
    attr(predictor$test_y_pred, "scaled:center")
  attr(predictor$test_y_pred, "scaled:scale") <- NULL
  attr(predictor$test_y_pred, "scaled:center") <- NULL

  if ("val_y" %in% colnames(predictor)) {

    predictor$val_y <- predictor$test_y_pred *
      attr(predictor$val_y, "scaled:scale") +
      attr(predictor$val_y, "scaled:center")
    attr(predictor$val_y, "scaled:scale") <- NULL
    attr(predictor$val_y, "scaled:center") <- NULL

    predictor$val_y_pred <- predictor$test_y_pred *
      attr(predictor$val_y_pred, "scaled:scale") +
      attr(predictor$val_y_pred, "scaled:center")
    attr(predictor$val_y_pred, "scaled:scale") <- NULL
    attr(predictor$val_y_pred, "scaled:center") <- NULL
  }

  return(predictor)
}
