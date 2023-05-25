FROM rocker/verse:4.3.0

# install system dependencies
RUN apt-get update \
	&& apt-get install -y --no-install-recommends \
    curl \
    libssl-dev \
    libcurl4-openssl-dev \
    libxml2-dev

# copy scripts
COPY . /usr/local/src/input
WORKDIR /usr/local/src/input

CMD ["bash", "make.sh"]
