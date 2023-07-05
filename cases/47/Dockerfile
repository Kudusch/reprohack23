FROM rocker/verse:4.3.0

# install system dependencies
RUN apt-get update \
	&& apt-get install -y --no-install-recommends \
    curl \
    libssl-dev \
    libcurl4-openssl-dev \
    libxml2-dev \
    xz-utils \
    make \
    build-essential \
    zlib1g-dev \
    libbz2-dev \
    libreadline-dev \
    libsqlite3-dev \
    wget \
    curl \
    llvm \
    libncursesw5-dev \
    tk-dev \
    libxml2-dev \
    libxmlsec1-dev \
    libffi-dev \
    liblzma-dev

# copy scripts
COPY . /usr/local/src/input
WORKDIR /usr/local/src/input

ENV PYENV_GIT_TAG v2.3.17
ENV PYENV_ROOT $HOME/.pyenv
ENV PATH $PYENV_ROOT/bin:$PATH
ENV PYTHON_VERSION 3.11.3
RUN curl -L https://github.com/pyenv/pyenv-installer/raw/master/bin/pyenv-installer | bash \
    && eval "$(pyenv init -)" \
    && pyenv install $PYTHON_VERSION \
    && pyenv global $PYTHON_VERSION

CMD ["bash", "make.sh"]
