## ADD THE DATA FETCHING CODE HERE
## e.g.
require(osfr)
#osf_auth(Sys.getenv("OSF_PAT"))
osf_retrieve_node(Sys.getenv("PROJECT_NODE")) |> 
    osf_ls_files("osfcache/fhcgp", n_max = Inf) -> all_files

osf_download(all_files)

