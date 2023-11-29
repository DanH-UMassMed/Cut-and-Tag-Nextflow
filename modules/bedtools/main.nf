
process DECOY_TRANSCRIPTOME {
    label 'process_low'
    container 'danhumassmed/samtools-bedtools:1.0.1'
    publishDir params.results_dir, mode:'copy'

    input:
    path genome_file
    path annotation_file
    path transcripts_file

    output:
    path "salmon_transcripts/gentrome.fa", emit: gentrome_fa

    script:
    """
    generateDecoyTranscriptome.sh -j $task.cpus -a ${annotation_file} -g ${genome_file} -t ${transcripts_file} -o salmon_transcripts
    """
}

process BEDTOOLS_SORT {
    tag "$meta.id"
    label 'process_medium'

    container 'danhumassmed/samtools-bedtools:1.0.1'

    input:
    tuple val(meta), path(intervals)
    path  sizes

    output:
    tuple val(meta), path("*.bed"), emit: sorted

    when:
    task.ext.when == null || task.ext.when

    script:
    def sizes  = sizes ? "-g $sizes" : ""
    """
    bedtools \\
        sort \\
        -i $intervals \\
        $sizes \\
        > ${meta.id}.sorted.bed
    """
}

process TABIX_BGZIPTABIX {
    tag "$meta.id"
    label 'process_low'

    container 'danhumassmed/samtools-bedtools:1.0.1'
    
    input:
    tuple val(meta), path(input)

    output:
    tuple val(meta), path("*.gz"), path("*.tbi"), optional: true, emit: gz_tbi
    tuple val(meta), path("*.gz"), path("*.csi"), optional: true, emit: gz_csi

    when:
    task.ext.when == null || task.ext.when

    script:
    """
    bgzip  --threads ${task.cpus} -c $input > ${meta.id}.${input.getExtension()}.gz
    tabix ${meta.id}.${input.getExtension()}.gz
    """

   
}