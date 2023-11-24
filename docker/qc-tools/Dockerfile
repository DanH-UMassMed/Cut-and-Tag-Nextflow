FROM danhumassmed/base-conda:1.0.1

RUN apt-get update -q && \
    apt-get install -q -y --no-install-recommends \
        default-jre \
        wkhtmltopdf \
        libcairo2 \
        libffi-dev \
        libpango-1.0-0 \
        libpangocairo-1.0-0 \
        python3-pip \
        unzip \
   && apt-get clean \
   && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /var/cache/apt/*


RUN cd /usr/local && \
    wget https://www.bioinformatics.babraham.ac.uk/projects/fastqc/fastqc_v0.12.1.zip && \
    unzip fastqc_v0.12.1.zip && \
    rm fastqc_v0.12.1.zip && \
    chmod 755 /usr/local/FastQC/fastqc && \
    ln -s /usr/local/FastQC/fastqc /usr/local/bin/fastqc 


RUN cd /usr/local && \
    wget https://sourceforge.net/projects/rseqc/files/RSeQC-5.0.1.tar.gz && \
    tar -xf RSeQC-5.0.1.tar.gz && \
    cd RSeQC-5.0.1 && \
    pip install . && \
    cd /usr/local && \
    rm RSeQC-5.0.1.tar.gz

RUN cd /usr/local && \
    wget https://downloads.rclone.org/rclone-current-linux-amd64.zip && \
    unzip rclone-current-linux-amd64.zip && \
    cd rclone-*-linux-amd64 && \
    cp rclone /usr/bin/ && \
    chown root:root /usr/bin/rclone && \
    chmod 755 /usr/bin/rclone

ENV LC_ALL C.UTF-8
ENV LANG C.UTF-8

COPY conda.yml .
RUN mamba env update -n root -f conda.yml && \
    mamba clean -a -y

RUN mkdir /app

COPY md2pdf.py /app

WORKDIR /app
