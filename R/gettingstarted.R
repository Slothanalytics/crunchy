#' @importFrom reticulate install_python
install_python_and_stuff <- function() {


  reticulate::install_python(version = '3.8')
  # Create a  new virtual environment with Python 3.9
  #
  python_path <- system2("which", args = "python3.8", stdout = TRUE)

  # Define the path for the new virtual environment
  virtualenv_path <- "~/Dataprojects/testingkeras"
  virtualenv_create(envname = virtualenv_path, python = python_path)

  # Install TensorFlow in the virtual environment
  # requirements https://www.tensorflow.org/install
  # as of 2023-11-11:
  # Python 3.8–3.1
  # macOS 10.12.6 (Sierra) or later (no GPU support)
  virtualenv_install(virtualenv_path, packages = "tensorflow")

  # Use the virtual environment in R
  use_virtualenv(virtualenv_path, required = TRUE)

  # Test the setup (optional)
  # You can add your code here to test the TensorFlow setup, like loading keras and a dataset
  library(keras)
  imdb <- dataset_imdb(num_words = 10000)
}
