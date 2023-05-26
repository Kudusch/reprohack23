suppressMessages(library(rio))
library(purrr)
library(tidyverse)

articles_csvs <- list.files(here::here("data"), "issue.+articles.csv", full.names = TRUE)
all_articles <- map_dfr(articles_csvs, rio::import)

prereg_coded <- rio::import(here::here("data", "preregister", "ccr_overview.xlsx"))
## bug-to-bug compatibility
prereg_coded[44,"url"] <- "https://computationalcommunication.org/ccr/article/view/51/30"
                            
## confirm that the prereg data have problems
setdiff(str_replace(prereg_coded$url, "/[0-9]+$", ""), all_articles$url)
setdiff(all_articles$url, str_replace(prereg_coded$url, "/[0-9]+$", ""))

bad_data <- rio::import(here::here("data", "preregister", "ccr_overview_2023_05_26.xlsx"))
bad_data[44,"url"] <- "https://computationalcommunication.org/ccr/article/view/51/30"

all_articles %>% left_join((bad_data %>% mutate(url = str_replace(url, "/[0-9]+$", "")) %>% distinct(url, .keep_all = TRUE) %>% rename(old_id = `id`) %>% select(-title, -issue)), by = "url") %>% arrange(old_id) %>% rowid_to_column(var = "id") -> corrected_data

rio::export(corrected_data, here::here("data", "preregister", "corrected_data.xlsx"))
