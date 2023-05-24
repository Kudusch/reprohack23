require(rvest)
require(stringr)
library(tidyverse)
require(purrr)

get_articles <- function(issue_url) {
  issue <- str_extract(issue_url, "\\d+$")
  message(issue)
  x <- read_html(paste0("https://computationalcommunication.org/ccr/issue/view/", issue))
  x %>% html_nodes("div.title") %>% html_text %>% str_trim -> titles
  x %>% html_nodes(".meta>.authors") %>% html_text %>% str_trim -> authors
  x %>% html_node("li.current") %>% html_node("h1") %>% html_text %>% str_trim -> issue
  x %>% html_nodes(".title>a") %>% html_attr("href") %>% str_trim -> urls
  x %>% html_nodes("a.pdf") %>% html_attr("href") %>% str_trim %>% str_replace("/view/", "/download/")-> pdf_url
  
  tibble::tibble(issue = issue, title = titles, authors = authors, url = urls, pdf_url = pdf_url)
}

get_issues <- function(base_url = "https://computationalcommunication.org/ccr/issue/archive") {
  html <- read_html(base_url)
  html %>% 
    html_nodes(".title") %>% 
    html_attr("href")
}

get_pdf <- function(pdf_urls, issue_url, dest_folder = ".") {
  destfiles = file.path(dest_folder, str_extract(issue_url, "\\d+$"), str_extract(pdf_urls, "\\d+$"))
  dir.create(dirname(destfiles[1]), showWarnings = FALSE)
  curl::multi_download(pdf_urls, destfiles = paste0(destfiles, ".pdf"))
}

get_meta <- function(art_url) {
  html <- read_html(art_url)
  html %>% html_nodes(".published>.value") %>% html_text() %>% lubridate::ymd() -> published
  galleys_links <- html %>% html_nodes(".galleys_links")
  files_titles <- galleys_links %>% html_node("a") %>% html_text() %>% trimws()
  files_urls <- galleys_links %>% html_node("a") %>% html_attr("href")
  files <- list(files_titles = files_titles, files_urls = files_urls)
  tibble::tibble(art_url = art_url, published = published, files_title = files_titles, files_url = files_urls)
}

for(i in get_issues()) {
    tryCatch({
        arts <- get_articles(i)
        rio::export(arts, paste0("data/issue_", str_extract(i, "\\d+$") , "_articles.csv"))

        meta <- map(arts$url, function(u) get_meta(u)) %>% 
          bind_rows()
        rio::export(meta, paste0("data/issue_", str_extract(i, "\\d+$") , "_meta.csv"))
        
        get_pdf(arts$pdf_url, i, "data")
    }, error = function(e) {
        message(i)
    })
}
