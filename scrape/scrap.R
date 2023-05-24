require(rvest)
require(stringr)
require(purrr)

scrap <- function(issue) {
    message(issue)
    x <- read_html(paste0("https://computationalcommunication.org/ccr/issue/view/", issue))
    x %>% html_nodes("div.title") %>% html_text %>% str_trim -> titles
    x %>% html_node("li.current") %>% html_node("h1") %>% html_text %>% str_trim -> issue
    x %>% html_nodes("a.obj_galley_link") %>% html_attr("href") %>% str_trim -> urls
    tibble::tibble(issue = issue, title = titles, url = urls)
}


for(i in seq(1, 10)) {
    tryCatch({
        res <- scrap(i)
        rio::export(res, paste0("issue_", i , ".csv"))
    }, error = function(e) {
        message(i)
    })
}
