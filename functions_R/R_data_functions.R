
###############################################################################
###############################################################################

load_raw_data <- function() {

  # Define a NULL variable reference to provide more graceful error
  # handling in the event of failed data import.
  raw_data <- NULL

  # N.B. Assumes a header row is present.
  raw_data <- readr::read_csv(
    file = Gmisc::pathJoin(
      funr::get_script_path(), "data", "raw_data",
      "MiningProcess_Flotation_Plant_Database.csv"
    ),
    locale = readr::locale(decimal_mark = ","),
    show_col_types = FALSE
  )

  return(raw_data)
}

###############################################################################
###############################################################################

load_hourly_data <- function() {

  # Load the hourly data

  train_data <- readr::read_csv(
    file = Gmisc::pathJoin(
      funr::get_script_path(), "data",
      "hourly_train_data.csv"
    ),
    show_col_types = FALSE
  )
  test_data <- readr::read_csv(
    file = Gmisc::pathJoin(
      funr::get_script_path(), "data",
      "hourly_test_data.csv"
    ),
    show_col_types = FALSE
  )

  train_x <- train_data[, !(names(train_data) %in% "% Silica Concentrate")]
  train_y <- train_data[, "% Silica Concentrate"]
  test_x <- test_data[, !(names(test_data) %in% "% Silica Concentrate")]
  test_y <- test_data[, "% Silica Concentrate"]

  return(list("train_x" = train_x, "train_y" = train_y,
              "test_x" = test_x, "test_y" = test_y))
}

###############################################################################
###############################################################################
