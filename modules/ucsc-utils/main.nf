process UCSC_BEDCLIP {
    tag "$meta.id"
    label 'process_medium'

    container 'danhumassmed/peak-calling:1.0.1'

    publishDir = [
        path: { "${task.ext.publish_dir_path_log}" },
        mode: "${params.publish_dir_mode}",
        pattern: "*.bedGraph",
    ]

    input:
    tuple val(meta), path(bedgraph)
    path  sizes

    output:
    tuple val(meta), path("*.bedGraph"), emit: bedgraph

    when:
    task.ext.when == null || task.ext.when

    script:
    def args = task.ext.args ?: ''
    def prefix = task.ext.prefix ?: "${meta.id}"
    """
    bedClip \\
        $bedgraph \\
        $sizes \\
        ${prefix}.bedGraph
    """
}


process UCSC_BEDGRAPHTOBIGWIG {
    tag "$meta.id"
    label 'process_low'

    container 'danhumassmed/peak-calling:1.0.1'

    publishDir = [
        path: { "${task.ext.publish_dir_path_log}" },
        mode: "${params.publish_dir_mode}",
        pattern: "*.bigWig",
    ]

    input:
    tuple val(meta), path(bedgraph)
    path  sizes

    output:
    tuple val(meta), path("*.bigWig"), emit: bigwig

    when:
    task.ext.when == null || task.ext.when

    script:
    def args = task.ext.args ?: ''
    def prefix = task.ext.prefix ?: "${meta.id}"
    
    """
    bedGraphToBigWig \\
        $bedgraph \\
        $sizes \\
        ${prefix}.bigWig
    """
}