# rendering

In order to render this manuscript, make sure you have the following R packages:

```r
install.packages(c("tidyverse", "readxl", "waffle", "hrbrthemes", "here", "knitr"))
```

You should also have `make`, `latexmk` (it's better to install this via `texlive-full`) and Quarto.

```bash
# install make and texlive-full
sudo apt install make texlive-full -y
# install quarto
sudo apt-get install -y curl git && curl -LO https://quarto.org/download/latest/quarto-linux-amd64.deb && dpkg -i quarto-linux-amd64.deb && quarto install tool tinytex && rm quarto-linux-amd64.deb

make fig-waffle-1.pdf
make render
```
