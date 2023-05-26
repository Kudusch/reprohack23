library(osfr)

stopifnot(Sys.getenv("PROJECT_NODE") != "")
stopifnot(Sys.getenv("OSF_PAT") != "")
osf_auth(Sys.getenv("OSF_PAT"))
node <- osf_retrieve_node(Sys.getenv("PROJECT_NODE"))
osf_upload(node, here::here("data", "osfcache"), recurse = TRUE, progress = TRUE)
