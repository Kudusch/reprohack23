# snapshots are not available on every date
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

hard_deps <- c(
  "attachment", 
  if (snap_date > as.Date("2021-12-01")) "pak",
  "remotes"
)
for (p in hard_deps) {
  if (!requireNamespace(p, quietly = TRUE)) install.packages(p)
}

fs <- list.files(".", recursive = TRUE)
is_file_ext <- function(x, ext) {
  e <- regmatches(x, regexpr("(?<=.)[A-z]+$", x, perl = TRUE))
  grepl(ext, e, ignore.case = TRUE)
}
deps <- c(
  attachment::att_from_rscripts(path = ".", recursive = TRUE),
  if (any(is_file_ext(fs, "qmd"))) attachment::att_from_qmds(path = ".", recursive = TRUE),
  if (any(is_file_ext(fs, "rmd"))) attachment::att_from_rmds(path = ".", recursive = TRUE)
)

reqs <- remotes::system_requirements("ubuntu", "20.04", package = deps)
lapply(reqs, system)

if (snap_date > as.Date("2021-12-01")) {
  pak::pkg_install(deps)
} else {
  install.packages(deps)
}
