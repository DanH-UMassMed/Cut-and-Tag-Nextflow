FROM danhumassmed/base-conda:1.0.1

RUN apt-get update -q && \
    apt-get install -q -y --no-install-recommends \
        zlib1g-dev \
        libncurses-dev \ 
        libzip-dev \
        libbz2-dev \
        liblzma-dev \
        libcurl4-openssl-dev
 
RUN wget https://github.com/samtools/samtools/releases/download/1.10/samtools-1.10.tar.bz2 && \
    tar xvjf samtools-1.10.tar.bz2 && \
    cd samtools-1.10 && \
    ./configure && \
    make install && \
    cd .. && \
    rm -rf samtools-1.10 && \
    rm samtools-1.10.tar.bz2

RUN wget https://github.com/arq5x/bedtools2/releases/download/v2.29.2/bedtools-2.29.2.tar.gz && \
    tar xvzf bedtools-2.29.2.tar.gz && \
    cd bedtools2 && \
    make install && \
    cd .. && \
    rm -rf bedtools2 && \
    rm bedtools-2.29.2.tar.gz

RUN wget https://github.com/marbl/MashMap/releases/download/v2.0/mashmap-Linux64-v2.0.tar.gz && \
    tar xvzf mashmap-Linux64-v2.0.tar.gz && \
    cd mashmap-Linux64-v2.0 && \
    cp mashmap /usr/local/bin && \
    cd .. && \
    rm -rf mashmap-Linux64-v2.0 && \
    rm  mashmap-Linux64-v2.0.tar.gz

COPY conda.yml .
RUN mamba env update -n root -f conda.yml