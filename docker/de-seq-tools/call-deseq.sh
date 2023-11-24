#!/bin/bash

# Used to test new features added to deseq-tools
mount_dir="/Users/dan/Code/NextFlow/RNA-Seq-Nextflow/docker/de-seq-tools"
input_file="genes_expression_expected_count.tsv"
output_dir="deseq_out"

echo "Running DESeq container at ${mount_dir} and cvs path ${input_csv_dir}"

# docker run --platform linux/amd64 --rm -v ${mount_dir}:/usr/data danhumassmed/de-seq-tools:1.0.1 \
#       Rscript /usr/data/low_counts_filter.R \
#       -i /usr/data/${input_file} \
#       -o /usr/data/${output_dir} \
#       -l 10

input_file="./deseq_out/count_data_low_counts_filtered.tsv"
meta_file="./run_oxIs12_ABC284.csv"
time {
docker run --platform linux/amd64 --rm -v ${mount_dir}:/usr/data danhumassmed/de-seq-tools:1.0.1 \
      Rscript /usr/data/run_deseq2.R \
      -i /usr/data/${input_file} \
      -o /usr/data/${output_dir} \
      -m /usr/data/${meta_file}

}


