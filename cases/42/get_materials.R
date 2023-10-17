library(osfr)
library(stringr)

## adopted from https://github.com/chainsawriot/ots/blob/master/README.md
## Reasons: Use the archived version instead

osf_retrieve_node(Sys.getenv("PROJECT_NODE")) |>
    osf_ls_files("osfcache/utxs5", n_max = Inf) -> utxs5_files 

utxs5_files[str_detect(utxs5_files$name, "RDS$|csv$"), ] |> osf_download(path = here::here("data/raw"), conflicts = "overwrite")
