## We add the following so that `install.packages` always installs the same version by respecting the SNAPSHOT_DATE

snap_date <- as.Date(Sys.getenv("SNAPSHOT_DATE"))
repo <- paste0("https://packagemanager.posit.co/cran/", snap_date)
repo_url_test <- try(readLines(paste0(repo, "/src/contrib/PACKAGES")), silent = TRUE)
while (is(repo_url_test, "try-error")) {
  warning("Snapshot for ", snap_date, "not reachable, trying previous day")
  snap_date <- snap_date - 1
  repo <- paste0("https://packagemanager.posit.co/cran/", snap_date)
  repo_url_test <- try(readLines(paste0(repo, "/src/contrib/PACKAGES")), silent = TRUE)
}

options(repos = c(REPO_NAME = repo))
Sys.setenv(RSPM_ROOT = "https://packagemanager.posit.co")

## original instruction
install.packages(c("rvest", "tidyverse", "lubridate", "lmtest", "zoo", "corrplot", "rio", "here", "rmarkdown", "stringr"))

## We modify this line to make this reproducible; so that it always installs the latest version as of the snapshot date

## Rscript -e 'install.packages("devtools"); devtools::install_github("crsh/papaja")'

install.packages("devtools")
devtools::install_github("crsh/papaja@1c488f73598ae088a4f0201e767aaa87f28387d3")
