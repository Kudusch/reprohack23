## ADD THE DATA FETCHING CODE HERE
## e.g.
require(osfr)
osf_auth(Sys.getenv("OSF_PAT"))
osf_retrieve_node(Sys.getenv("PROJECT_NODE")) %>% 
    osf_ls_files("osfcache/dv8gx", n_max = Inf) -> all_files

## just download the first file in the analytical pipeline to
## prove the point
osf_download(all_files[grepl("training lda", all_files$name),])
