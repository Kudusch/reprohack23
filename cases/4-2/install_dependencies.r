for (p in c("attachment", "pak", "remotes")) {
  if (!requireNamespace(p, quietly = TRUE)) install.packages(p)
}

deps <- c(
  attachment::att_from_rscripts(path = ".", recursive = TRUE),
  attachment::att_from_qmds(path = ".", recursive = TRUE),
  attachment::att_from_rmds(path = ".", recursive = TRUE)
)

# needs to be debugged
# reqs <- remotes::system_requirements("ubuntu", "20.04", package = deps)
# system2(reqs)

pak::pkg_install(deps)
