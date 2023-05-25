library(osfr)

osf_retrieve_node("c4xq3") %>% 
  osf_ls_files() %>%
  osf_download()
