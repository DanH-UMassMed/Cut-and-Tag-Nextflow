FROM danhumassmed/base-conda:1.0.1

RUN apt-get update -q && \
    apt-get install -y --no-install-recommends \
        libxml2-dev \
        libssl-dev  \
        libcurl4-openssl-dev \
        libfontconfig1-dev \
        libcairo2-dev

COPY conda.yml .
COPY startDEBrowser.R .

RUN mamba env update -n root -f conda.yml

RUN R -e "install.packages('stringi', configure.args='--disable-pkg-config', repos='https://cran.r-project.org')"


CMD ["Rscript", "/startDEBrowser.R"]