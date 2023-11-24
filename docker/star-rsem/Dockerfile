FROM danhumassmed/base-conda:1.0.1

RUN apt-get update -q && \
    apt-get install -q -y --no-install-recommends \
        libzip-dev 


RUN cd /usr/local && \
    wget https://github.com/alexdobin/STAR/archive/2.7.10b.tar.gz && \
    tar -xzf 2.7.10b.tar.gz && \
    cd ./STAR-2.7.10b/source && \
    make STARstatic && \
    mv /usr/local/STAR-2.7.10b/source/STAR /usr/local/bin/STAR && \
    cd /usr/local && \
    rm 2.7.10b.tar.gz && \
    rm -rf STAR-2.7.10b

RUN apt-get update -q && \
    apt-get install -q -y --no-install-recommends \
        r-base \
        r-base-dev 

RUN wget https://github.com/deweylab/RSEM/archive/refs/tags/v1.3.3.tar.gz && \
    tar -xvzf v1.3.3.tar.gz && \
    cd RSEM-1.3.3 && \
    make install && \
    cd .. && \
    rm -rf RSEM-1.3.3 && \
    rm v1.3.3.tar.gz


COPY conda.yml .
RUN mamba env update -n root -f conda.yml


