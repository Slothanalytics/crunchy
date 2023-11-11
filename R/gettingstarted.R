#' importFrom keras dataset_imdb
run <- function() {
  imdb <- keras::dataset_imdb(num_words = 10000)
  train_data <- imdb$train$x
  train_labels <- imdb$train$y
  test_data <- imdb$test$x
  test_labels <- imdb$test$y
}
