library(stringr)
library(osfr)

corrected_data <- rio::import(here::here("data", "preregister", "corrected_data.xlsx"))

.remove_na <- function(x) {
    x[!is.na(x)]
}

urls <- tolower(c(corrected_data$code_url, corrected_data$data_url))
str_extract(.remove_na(urls), "osf\\.io/([a-z0-9]+)[/\\.]") %>% str_remove("osf\\.io/") %>% str_remove("[/\\.]$") %>% .remove_na -> osf_nodes

cache_dir <- here::here("data", "osfcache")

if (!dir.exists(cache_dir)) {
    dir.create(cache_dir)
}

start_time <- as.character(Sys.time())
.cache_node <- function(node) {
    message(node)
    base_dir <- here::here("data", "osfcache", node)
    dir.create(base_dir)
    osf_retrieve_node(node) %>% 
        osf_ls_files() %>%
        osf_download(base_dir, progress = TRUE)
}

purrr::walk(setdiff(osf_nodes, list.files(cache_dir)), .cache_node)
writeLines(c("caching from:", start_time, "to: ", as.character(Sys.time())), here::here("data", "osfcache", "log.txt"))
