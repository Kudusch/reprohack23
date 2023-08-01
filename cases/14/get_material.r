library(osfr)

osf_auth(Sys.getenv("OSF_PAT"))
osf_retrieve_node(Sys.getenv("PROJECT_NODE")) %>% 
    osf_ls_files("osfcache/cyfd7", n_max = Inf) %>%
    osf_download()
