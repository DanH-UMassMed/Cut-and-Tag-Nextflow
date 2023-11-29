#!/bin/bash

read_1=$1
read_2=$2
data_root=$3
dir_suffix=$4
cores=$5

# Determine the original directory structure for these files
real_path=`readlink -f $read_1`
path_without_filename=$(dirname "$real_path")
path_to_output="output_${dir_suffix}"

# Recreate the directory structure for the output
trim_dir="${path_to_output}/trim/${path_without_filename#*$data_root}"
report_dir="${path_to_output}/report/${path_without_filename#*$data_root}"
mkdir -p ${trim_dir}
mkdir -p ${report_dir}

if [[ -z "$read_2" ]]; then
    echo "Single end reads"
    trim_galore \
        --fastqc \
        --cores ${cores} \
        --gzip \
        ${read_1} 
else
    echo "Paired end reads"
    trim_galore \
       --paired \
       --fastqc \
       --cores ${cores} \
       --gzip \
       ${read_1} \
       ${read_2} 
fi

cp *_val_{1,2}.fq.gz ${trim_dir}
cp -f *_fastqc.html ${report_dir}
cp -f *_trimming_report.txt ${report_dir}

