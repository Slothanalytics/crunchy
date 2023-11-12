# Mock training data
mock_train_data <- matrix(runif(30), nrow = 3, ncol = 10)

# Mock training labels
mock_train_labels <- sample(0:1, 3, replace = TRUE)

# Mock validation data
mock_val_data <- matrix(runif(30), nrow = 3, ncol = 10)

# Mock validation labels
mock_val_labels <- sample(0:1, 3, replace = TRUE)

test_that("Model is created without errors", {
  expect_silent(create_train_model(
    input_shape = c(10),
    units = c(16, 16, 1),
    activation = c("relu", "relu", "sigmoid"),
    optimizer = "rmsprop",
    loss = "binary_crossentropy",
    metrics = c("accuracy"),
    epochs = 1,
    batch_size = 1,
    train_data = mock_train_data,
    train_labels = mock_train_labels,
    val_data = mock_val_data,
    val_labels = mock_val_labels
  ))
})

test_that("Function handles input parameters correctly", {
  result <- create_train_model(
    input_shape = c(10),
    units = c(16, 16, 1),
    activation = c("relu", "relu", "sigmoid"),
    optimizer = "rmsprop",
    loss = "binary_crossentropy",
    metrics = c("accuracy"),
    epochs = 1,
    batch_size = 1,
    train_data = mock_train_data,
    train_labels = mock_train_labels,
    val_data = mock_val_data,
    val_labels = mock_val_labels
  )

  expect_true("model" %in% names(result))
  expect_true("history" %in% names(result))
})

test_that("Function returns a Sequential model", {
  result <- create_train_model(
    input_shape = c(10),
    units = c(16, 16, 1),
    activation = c("relu", "relu", "sigmoid"),
    optimizer = "rmsprop",
    loss = "binary_crossentropy",
    metrics = c("accuracy"),
    epochs = 1,
    batch_size = 1,
    train_data = mock_train_data,
    train_labels = mock_train_labels,
    val_data = mock_val_data,
    val_labels = mock_val_labels
  )
  expect_true(inherits(result$model, "keras.engine.sequential.Sequential"))
})

test_that("Training history has expected attributes", {
  result <- create_train_model(
    input_shape = c(10),
    units = c(16, 16, 1),
    activation = c("relu", "relu", "sigmoid"),
    optimizer = "rmsprop",
    loss = "binary_crossentropy",
    metrics = c("accuracy"),
    epochs = 1,
    batch_size = 1,
    train_data = mock_train_data,
    train_labels = mock_train_labels,
    val_data = mock_val_data,
    val_labels = mock_val_labels
  )
  expect_true("metrics" %in% names(result$history))
  expect_true("params" %in% names(result$history))
})
