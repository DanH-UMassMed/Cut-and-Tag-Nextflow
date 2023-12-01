
process SAMTOOLS_FAIDX {
    tag "$fasta"
    label 'process_low'
    container 'danhumassmed/samtools-bedtools:1.0.1'

    input:
    tuple val(meta), path(fasta)

    output:
    tuple val(meta), path ("*.{fa,fasta}") , emit: fa,    optional: true
    tuple val(meta), path ("*.fai")        , emit: fai,   optional: true
    tuple val(meta), path ("*.gzi")        , emit: gzi,   optional: true
    tuple val(meta), path ("*.sizes")      , emit: sizes, optional: true

    when:
    task.ext.when == null || task.ext.when

    script:
    """
    samtools faidx $fasta
    cut -f 1,2 ${fasta}.fai > ${fasta}.sizes
    """
}

process SAMTOOLS_SORT {
    tag "$meta.id"
    label 'process_medium'

    container 'danhumassmed/samtools-bedtools:1.0.1'
    publishDir = [
        path: { "${params.results_dir}/02_alignment/bowtie2/target" },
        mode: "${params.publish_dir_mode}",
        pattern: "*.bam",
        enabled: ( params.save_align_intermed )
    ]

    input:
    tuple val(meta), path(bam)

    output:
    tuple val(meta), path("*.bam"), emit: bam
    tuple val(meta), path("*.csi"), emit: csi, optional: true

    when:
    task.ext.when == null || task.ext.when

    script:
    def prefix = "${meta.id}.target.sorted"
    if ("$bam" == "${prefix}.bam") error "Input and output names are the same disambiguate!"
    """
    samtools sort \\
        -@ $task.cpus \\
        -o ${prefix}.bam \\
        -T $prefix \\
        $bam    
    """
}


process SAMTOOLS_INDEX {
    tag "$meta.id"
    label 'process_low'

    container 'danhumassmed/samtools-bedtools:1.0.1'
    publishDir = [
                path: { "${params.results_dir}/02_alignment/bowtie2/target" },
                mode: "${params.publish_dir_mode}",
                pattern: "*.bai",
                enabled: ( params.save_align_intermed )
            ]


    input:
    tuple val(meta), path(input)

    output:
    tuple val(meta), path("*.bai") , optional:true, emit: bai
    tuple val(meta), path("*.csi") , optional:true, emit: csi
    tuple val(meta), path("*.crai"), optional:true, emit: crai

    when:
    task.ext.when == null || task.ext.when

    script:
    """
    samtools \\
        index \\
        -@ ${task.cpus-1} \\
        $input
    """
}

process SAMTOOLS_STATS {
    tag "$meta.id"
    label 'process_low'

    container 'danhumassmed/samtools-bedtools:1.0.1' 

    input:
    tuple val(meta), path(input), path(input_index)
    tuple val(meta2), path(fasta)

    output:
    tuple val(meta), path("*.stats"), emit: stats

    when:
    task.ext.when == null || task.ext.when

    script:
    def prefix = "${meta.id}"
    def reference = fasta ? "--reference ${fasta}" : ""
    """
    samtools \\
        stats \\
        --threads ${task.cpus} \\
        ${reference} \\
        ${input} \\
        > ${prefix}.stats
    """
}

process SAMTOOLS_FLAGSTAT {
    tag "$meta.id"
    label 'process_low'

    container 'danhumassmed/samtools-bedtools:1.0.1' 

    input:
    tuple val(meta), path(bam), path(bai)

    output:
    tuple val(meta), path("*.flagstat"), emit: flagstat

    when:
    task.ext.when == null || task.ext.when

    script:
    def prefix = "${meta.id}"
    """
    samtools \\
        flagstat \\
        --threads ${task.cpus} \\
        $bam \\
        > ${prefix}.flagstat
    """
}

process SAMTOOLS_IDXSTATS {
    tag "$meta.id"
    label 'process_low'

    container 'danhumassmed/samtools-bedtools:1.0.1'  

    input:
    tuple val(meta), path(bam), path(bai)

    output:
    tuple val(meta), path("*.idxstats"), emit: idxstats

    when:
    task.ext.when == null || task.ext.when

    script:
    def prefix = "${meta.id}"

    """
    samtools \\
        idxstats \\
        --threads ${task.cpus} \\
        $bam \\
        > ${prefix}.idxstats
    """
}

process SAMTOOLS_VIEW {
    tag "$meta.id"
    label 'process_low'

    container 'danhumassmed/samtools-bedtools:1.0.1'  
    publishDir = [
                path: { "${params.results_dir}/02_alignment/bowtie2/target" },
                mode: "${params.publish_dir_mode}",
                pattern: "*.bam",
                enabled: ( params.save_align_intermed )
            ] 

    input:
    tuple val(meta), path(input), path(index)
    tuple val(meta2), path(fasta)
    path qname

    output:
    tuple val(meta), path("*.bam"),  emit: bam,     optional: true
    tuple val(meta), path("*.cram"), emit: cram,    optional: true
    tuple val(meta), path("*.sam"),  emit: sam,     optional: true
    tuple val(meta), path("*.bai"),  emit: bai,     optional: true
    tuple val(meta), path("*.csi"),  emit: csi,     optional: true
    tuple val(meta), path("*.crai"), emit: crai,    optional: true

    when:
    task.ext.when == null || task.ext.when

    // REVIEW task.ext !!!!!!!!
    script:
    def args = task.ext.args ?: ''
    def args2 = task.ext.args2 ?: ''
    def prefix = task.ext.prefix ?: "${meta.id}"
    def reference = fasta ? "--reference ${fasta}" : ""
    def readnames = qname ? "--qname-file ${qname}": ""
    def file_type = args.contains("--output-fmt sam") ? "sam" :
                    args.contains("--output-fmt bam") ? "bam" :
                    args.contains("--output-fmt cram") ? "cram" :
                    input.getExtension()
    if ("$input" == "${prefix}.${file_type}") error "Input and output names are the same, use \"task.ext.prefix\" to disambiguate!"
    """
    samtools \\
        view \\
        --threads ${task.cpus-1} \\
        ${reference} \\
        ${readnames} \\
        $args \\
        -o ${prefix}.${file_type} \\
        $input \\
        $args2

    """
}

