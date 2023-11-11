#' remember to have python 3.8 installed
#' /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
#' brew install python@3.8
#' brew link python@3.8
#' @importFrom reticulate virtualenv_create virtualenv_install
.onLoad <- function(libname, pkgname) {
  current_dir <- getwd()
  virtualenv_path <- file.path(current_dir, "MLmodel_env")
  python_path <- system("which python3.8", intern = TRUE)

  if (!reticulate::virtualenv_exists(virtualenv_path)) {
    reticulate::virtualenv_create(virtualenv_path, python = python_path)
  }
  #install tensorflow-cpu or gpu (gpu if you have some of the new MX macs or high end nvidea card)
  reticulate::py_install(packages = "tensorflow-cpu", envname = virtualenv_path, method = "auto", pip = TRUE)

  reticulate::use_virtualenv(virtualenv_path, required = TRUE)
}
