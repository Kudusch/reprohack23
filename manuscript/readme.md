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

# Dockerfile

You can also use the Dockerfile to create a computational environment that can be used to render the manuscript.
First, build the image:

```bash
docker build -t ccr-render .
```

To render the article, you can then use this command:

```bash
docker run --rm \
    --volume $PWD:/usr/local/src/input \
    --user $(id -u):$(id -g) \
    ccr-render
```

You can also use one of the other commands from the `Makefile`.
For example, run `make nuke` to remove all prebuilt targets and then rebuild them with `make ccr.cls fig-waffle-1.pdf body.tex render`.
Or as a shorthand, run `make all`

```bash
docker run --rm \
    --volume $PWD:/usr/local/src/input \
    ccr-render all # inside container, you can omit `make`
```
