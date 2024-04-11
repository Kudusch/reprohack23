FROM rocker/r-ver:4.3.3
RUN apt-get update \
	&& apt-get install -y --no-install-recommends texlive-full curl git

COPY . /usr/local/src/input
WORKDIR /usr/local/src/input

RUN Rscript install.R \
    && curl -LO https://quarto.org/download/latest/quarto-linux-amd64.deb \
    && dpkg -i quarto-linux-amd64.deb \
    && quarto install tool tinytex \
    && rm -r * # remove files used during build before run

ENTRYPOINT ["make"]
CMD ["render"]
