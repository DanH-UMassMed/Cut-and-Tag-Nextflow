FROM danhumassmed/base-conda:1.0.1

COPY conda.yml .

RUN mamba env update -n root -f conda.yml && \
    mamba clean -a -y

RUN pip install deeptools==3.5.3 