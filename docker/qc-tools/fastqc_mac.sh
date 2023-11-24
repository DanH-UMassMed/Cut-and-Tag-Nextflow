# Run fastqc_mac.sh on fastq files with paired end reads
#
# Note: read1 & read2 should be a relative path to the fastq files from the current working directory (i.e., $PWD)
# ./bin/fastqc_mac.sh Experiment2/Harvest_L4_070623/unc17_e113_r5/unc17_e113_r5_1.fq.gz Experiment2/Harvest_L4_070623/unc17_e113_r5/unc17_e113_r5_2.fq.gz 
#
# Note: fastqc expects an output directory 
#       to create this directory we add a prefix, strip the trailing charaters from the provided fastq file, and add a suffix
#       e.g., Experiment2/Harvest_L4_070623/unc17_e113_r5/unc17_e113_r5_1.fq.gz
#       out_dir="fastqc_$(basename "$read1")" ==> fastqc_unc17_e113_r5_1.fq.gz
#       out_dir=$(remove_last_chars "$out_dir" 8) ==> fastqc_unc17_e113_r5
#       out_dir=${out_dir}_log ==> fastqc_unc17_e113_r5_log
#       This keeps the generated output organized and may need modification based on the input file naming convenstions

# http://proteo.me.uk/2013/09/a-new-way-to-look-at-duplication-in-fastqc-v0-11/
# https://www.bioinformatics.babraham.ac.uk/projects/fastqc/Help/3%20Analysis%20Modules/8%20Duplicate%20Sequences.html
# https://bioinformatics.stackexchange.com/questions/6786/sequence-duplication-levels-module-still-fails-after-pre-processing-illumina-d#:~:text=FastQC%20assumes%20that%20all%20samples,concern%20and%20is%20completely%20expected.

read1=$1
read2=$2
mount_dir=$PWD
container_dir=/usr/data


remove_last_chars() {
    local original_string="$1"
    local chars_to_remove="$2"
    local length="${#original_string}"
    local modified_string="${original_string:0:$((length - chars_to_remove))}"
    echo "$modified_string"
}


out_dir="fastqc_$(basename "$read1")"
out_dir=$(remove_last_chars "$out_dir" 8)
out_dir=${out_dir}_log
mkdir -p ${mount_dir}/${out_dir}

docker run --platform linux/amd64 --rm -v ${mount_dir}:${container_dir} -t danhumassmed/qc-tools:1.0.1 fastqc \
	-o ${container_dir}/${out_dir} -f fastq -q ${container_dir}/${read1} ${container_dir}/${read2}



