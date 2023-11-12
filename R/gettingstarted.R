#' @importFrom keras dataset_imdb
#' @importFrom magrittr %>%
run <- function() {
  imdb <- keras::dataset_imdb(num_words = 10000)
  train_data <- imdb$train$x
  train_labels <- imdb$train$y
  test_data <- imdb$test$x
  test_labels <- imdb$test$y

  vectorize_sequences <- function(sequences, dimension = 10000) {
    results <- matrix(0, nrow = length(sequences), ncol = dimension)
    for (i in 1:length(sequences))
      results[i, sequences[[i]]] <- 1
    results
  }

  x_train <- vectorize_sequences(train_data)
  x_test <- vectorize_sequences(test_data)

  y_train <- as.numeric(train_labels)
  y_test <- as.numeric(test_labels)

  val_indicies <- 1:10000
  x_val <- x_train[val_indicies,]
  partial_x_train <- x_train[-val_indicies,]
  y_val <- y_train[val_indicies]
  partial_y_train <- y_train[-val_indicies]

  result <- create_train_model(
    input_shape = c(10000),     # Number of features in the input data
    units = c(16, 16, 1),       # Number of neurons in each layer
    activation = c("relu", "relu", "sigmoid"),  # Activation functions for each layer
    optimizer = "rmsprop",      # Optimizer for the model
    loss = "binary_crossentropy",  # Loss function for binary classification
    metrics = c("accuracy"),    # Metric to evaluate model performance
    epochs = 20,                # Number of epochs for training
    batch_size = 512,           # Batch size for training
    train_data = partial_x_train,   # Training data
    train_labels = partial_y_train, # Training labels
    val_data = x_val,               # Validation data
    val_labels = y_val              # Validation labels
  )

}

#' @importFrom keras keras_model_sequential layer_dense fit compile
create_train_model <- function(input_shape, units, activation, optimizer, loss, metrics, epochs, batch_size, train_data, train_labels, val_data, val_labels) {
  model <- keras::keras_model_sequential() %>%
    keras::layer_dense(units = units[1], activation = activation[1], input_shape = input_shape) %>%
    keras::layer_dense(units = units[2], activation = activation[2]) %>%
    keras::layer_dense(units = units[3], activation = activation[3])

  model %>% keras::compile(
    optimizer = optimizer,
    loss = loss,
    metrics = metrics
  )

  history <- model %>% keras::fit(
    train_data,
    train_labels,
    epochs = epochs,
    batch_size = batch_size,
    validation_data = list(val_data, val_labels)
  )

  return(list(model = model, history = history))
}


