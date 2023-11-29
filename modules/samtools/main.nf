
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

