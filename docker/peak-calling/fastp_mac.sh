# Manaual: https://github.com/OpenGene/fastp
read1=$1
read2=$2
mount_dir=$PWD
container_dir=/usr/data

docker run --platform linux/amd64 --rm -v ${mount_dir}:${container_dir} -t danhumassmed/picard-trimmomatic:1.0.1 fastp \
	--in1=${container_dir}/$read1  --in2=${container_dir}/$read2 \
	--out1=${container_dir}/dedup_$(basename "$read1") --out2=${container_dir}/dedup_$(basename "$read2") \
	--dedup \
	--dup_calc_accuracy=5 \
	--length_required=75 \
	--trim_front1=10 \
	--html=fastp.html
#	--disable_adapter_trimming \
#	--disable_trim_poly_g \
#	--disable_quality_filtering \


