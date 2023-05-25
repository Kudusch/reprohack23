# Dependencies ----
library(googlesheets4)
library(dplyr)
library(tidyr)
library(ggplot2)
library(lubridate)
library(stringr)
library(networkD3)

# Reading data from API ----
df <- googlesheets4::read_sheet(
    ss = "https://docs.google.com/spreadsheets/d/1CDPAce227BvLXc-3NATCT0ZEhURIIX5nK1WK5RlbyVo",
    col_types = "c"
) |>
    mutate(repro_applicable = factor(
        repro_applicable,
        levels = c("1", "0"),
        labels = c("applicable", "not applicable")
    )) |>
    mutate(code = factor(
        code,
        levels = c("1", "0"),
        labels = c("code available", "no code available")
    )) |>
    mutate(data = factor(
        data,
        levels = c("1", "0"),
        labels = c("data available", "no data available")
    ))


# Make plots ----
## Articles per year
fig.articles_per_year <- df |>
    mutate(year = as.numeric(year)) |>
    count(year) |>
    ggplot(aes(x = year, y = n)) +
    geom_col(fill = "#2081C3") +
    theme_minimal() +
    labs(
        title = "Number CCR of articles per year",
        y = "n",
        x = "Year"
    )
ggsave(
    plot = fig.articles_per_year,
    file = "articles_per_year.png",
    scale = .8,
    height = 210,
    width = 297,
    units = "mm"
)

## Article selection
links <- rbind(
    df |>
        count(repro_applicable, name = "value") |>
        rename(target = repro_applicable) |>
        mutate(source = "all") |>
        select(source, target, value),
    df |>
        group_by(repro_applicable) |>
        count(code, name = "value") |>
        rename(source = repro_applicable) |>
        mutate(target = paste0(source, "_", code)) |>
        select(source, target, value)
)
nodes <- data.frame(
    name=c(as.character(links$source),
           as.character(links$target)) |> unique()
) |>
    mutate(group = c("black", "blue", "darkgrey", "lightblue", "darkgrey", "darkgrey", "darkgrey"))

# With networkD3, connection must be provided using id, not using real name like in the links dataframe.. So we need to reformat it.
links$IDsource <- match(links$source, nodes$name)-1
links$IDtarget <- match(links$target, nodes$name)-1
nodes$name <- str_remove_all(nodes$name, ".*?_")
clr_scale <- sprintf('d3.scaleOrdinal() .domain([%s]) .range([%s])', paste(dQuote(nodes$group |> unique(), "\""), collapse = ","), paste(dQuote(nodes$group |> unique(), "\""), collapse = ","))
# Make the Network
p <- sankeyNetwork(
    Links = links,
    Nodes = nodes,
    Source = "IDsource",
    Target = "IDtarget",
    Value = "value",
    NodeID = "name",
    NodeGroup="group",
    colourScale = clr_scale,
    fontSize = "30px",
    fontFamily = "monospace"
)
p
