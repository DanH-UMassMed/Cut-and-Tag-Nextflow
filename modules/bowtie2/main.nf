
process BOWTIE2_ALIGN {
    tag "$meta.id"
    label "process_medium"

    container 'danhumassmed/bowtie-tophat:1.0.1'

    publishDir = [
        [
            path: { "${task.ext.publish_dir_path_log}" },
            mode: "${params.publish_dir_mode}",
            pattern: '*.log'
        ],
        [
            path: { "${task.ext.publish_dir_path_bam}" },
            mode: "${params.publish_dir_mode}" ,
            pattern: '*.bam',
            enabled: params.save_align_target || params.save_align_spikein
        ],
        [
            path: { "${task.ext.publish_dir_path_fastq}" },
            mode: "${params.publish_dir_mode}",
            pattern: '*.fastq.gz',
            enabled: params.save_unaligned
        ]
    ]

    
    input:
    tuple val(meta) , path(reads)
    tuple val(meta2), path(index)
    val   save_unaligned
    val   sort_bam

    output:
    tuple val(meta), path("*.{bam,sam}"), emit: aligned
    tuple val(meta), path("*.log")      , emit: log
    tuple val(meta), path("*fastq.gz")  , emit: fastq, optional:true

    when:
    task.ext.when == null || task.ext.when

    script:
    def args = task.ext.args ?: ""
    def args2 = task.ext.args2 ?: ""
    def prefix = task.ext.prefix ?: "${meta.id}"

    def unaligned = ""
    def reads_args = ""
    if (meta.single_end) {
        unaligned = save_unaligned ? "--un-gz ${prefix}.unmapped.fastq.gz" : ""
        reads_args = "-U ${reads}"
    } else {
        unaligned = save_unaligned ? "--un-conc-gz ${prefix}.unmapped.fastq.gz" : ""
        reads_args = "-1 ${reads[0]} -2 ${reads[1]}"
    }

    def samtools_command = sort_bam ? 'sort' : 'view'
    def extension_pattern = /(--output-fmt|-O)+\s+(\S+)/
    def extension = (args2 ==~ extension_pattern) ? (args2 =~ extension_pattern)[0][2].toLowerCase() : "bam"

    """
    INDEX=`find -L ./ -name "*.rev.1.bt2" | sed "s/\\.rev.1.bt2\$//"`
    [ -z "\$INDEX" ] && INDEX=`find -L ./ -name "*.rev.1.bt2l" | sed "s/\\.rev.1.bt2l\$//"`
    [ -z "\$INDEX" ] && echo "Bowtie2 index files not found" 1>&2 && exit 1

        bowtie2 \\
        -x \$INDEX \\
        $reads_args \\
        --threads $task.cpus \\
        $unaligned \\
        $args \\
        2> ${prefix}.bowtie2.log \\
        | samtools $samtools_command $args2 --threads $task.cpus -o ${prefix}.${extension} -

    if [ -f ${prefix}.unmapped.fastq.1.gz ]; then
        mv ${prefix}.unmapped.fastq.1.gz ${prefix}.unmapped_1.fastq.gz
    fi

    if [ -f ${prefix}.unmapped.fastq.2.gz ]; then
        mv ${prefix}.unmapped.fastq.2.gz ${prefix}.unmapped_2.fastq.gz
    fi
    
    """
}
