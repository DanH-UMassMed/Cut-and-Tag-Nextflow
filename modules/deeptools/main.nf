process DEEPTOOLS_BAMCOVERAGE {
    tag "$meta.id"
    label 'process_low'

    container 'danhumassmed/peak-calling:1.0.1'

    input:
    tuple val(meta), path(input), path(input_index), val(scale)

    output:
    tuple val(meta), path("*.bigWig")   , emit: bigwig, optional: true
    tuple val(meta), path("*.bedgraph") , emit: bedgraph, optional: true

    when:
    task.ext.when == null || task.ext.when

    script:
    def args = task.ext.args ?: ''
    def prefix = task.ext.prefix ?: "${meta.id}.bigWig"

    """
    bamCoverage \
    --bam $input \
    $args \
    --scaleFactor ${scale} \
    --numberOfProcessors ${task.cpus} \
    --outFileName ${prefix}
    """
}

