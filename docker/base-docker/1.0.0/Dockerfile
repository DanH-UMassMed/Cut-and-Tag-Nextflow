FROM debian:buster-slim

ENV LANG=C.UTF-8 LC_ALL=C.UTF-8

RUN apt-get update -q && \
    apt-get install -q -y --no-install-recommends \
        build-essential \
        bzip2 \
        ca-certificates \
        git \
        libglib2.0-0 \
        libsm6 \
        libxext6 \
        libxrender1 \
        openssh-client \
        procps \
        libarchive13 \
        wget \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

ENV PATH /opt/conda/bin:$PATH

CMD [ "/bin/bash" ]

# Leave these args here to better use the Docker build cache
ARG CONDA_VERSION=py27_4.8.3

RUN set -x && \
    UNAME_M="$(uname -m)" && \
    if [ "${UNAME_M}" = "x86_64" ]; then \
        MINICONDA_URL="https://repo.anaconda.com/miniconda/Miniconda2-${CONDA_VERSION}-Linux-x86_64.sh"; \
        SHA256SUM="b820dde1a0ba868c4c948fe6ace7300a252b33b5befd078a15d4a017476b8979"; \
    elif [ "${UNAME_M}" = "ppc64le" ]; then \
        MINICONDA_URL="https://repo.anaconda.com/miniconda/Miniconda2-${CONDA_VERSION}-Linux-ppc64le.sh"; \
        SHA256SUM="23473678afb15a6ed87045ce6490463420aed9c249607fb389a788e95335bb28"; \
    fi && \
    wget "${MINICONDA_URL}" -O miniconda.sh -q && \
    echo "${SHA256SUM} miniconda.sh" > shasum && \
    if [ "${CONDA_VERSION}" != "latest" ]; then sha256sum --check --status shasum; fi && \
    mkdir -p /opt && \
    bash miniconda.sh -b -p /opt/conda && \
    rm miniconda.sh shasum && \
    ln -s /opt/conda/etc/profile.d/conda.sh /etc/profile.d/conda.sh && \
    echo ". /opt/conda/etc/profile.d/conda.sh" >> ~/.bashrc && \
    echo "conda activate base" >> ~/.bashrc && \
    find /opt/conda/ -follow -type f -name '*.a' -delete && \
    find /opt/conda/ -follow -type f -name '*.js.map' -delete && \
    /opt/conda/bin/conda clean -afy

RUN apt-get update && apt-get install -y libarchive13

RUN conda install -c conda-forge -n root mamba \
&& conda clean -a

