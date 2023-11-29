#!/bin/bash

has_report_data=$1

trim_source_dir="./trim_*"
trim_target_dir="./trimmed"

report_source_dir="./output_*/report"
report_target_dir="./trim_report"



if [ -n "$has_report_data" ]; then
    mkdir -p "$report_target_dir"
    for dir in ${report_source_dir};
        # Copy the target directories recursively (-r) 
        # and do not clobber (-n) if directory name already exists 
        do cp -rn ${dir}/* ${report_target_dir}; 
    done
    trim_source_dir="./output_*/trim"
fi

mkdir -p "$trim_target_dir"
for dir in ${trim_source_dir};
    # Copy the target directories recursively (-r) 
    # and do not clobber (-n) if directory name already exists 
    do cp -rn ${dir}/* ${trim_target_dir}; 
done
