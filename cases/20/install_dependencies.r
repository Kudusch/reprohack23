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

hard_deps <- c("renv", "remotes", "packrat", "osfr")

for (p in hard_deps) {
  if (!requireNamespace(p, quietly = TRUE)) install.packages(p)
}

deps <- unique(renv::dependencies(".")$Package)

reqs <- remotes::system_requirements("ubuntu", "20.04", package = deps)
print(reqs)
z <- lapply(reqs, system)

install.packages(deps)
