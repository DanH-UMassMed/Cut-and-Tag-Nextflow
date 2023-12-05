process BEDTOOLS_SORT {
    tag "$meta.id"
    label 'process_medium'

    container 'danhumassmed/samtools-bedtools:1.0.1'

    publishDir = [
                path: { "${task.ext.publish_dir_path}" },
                mode: "${params.publish_dir_mode}",
                overwrite: true,
                pattern: '*',
                enabled: params.save_reference 
            ]

    input:
    tuple val(meta), path(intervals)
    val   extension
    path  sizes

    output:
    tuple val(meta), path("*.${extension}"), emit: sorted

    when:
    task.ext.when == null || task.ext.when

    script:
    def args   = task.ext.args ?: ''
    def prefix = task.ext.prefix ?: "${meta.id}"
    def sizes  = sizes ? "-g $sizes" : ""
    """
    echo "publish_dir_enabled=${task.ext.publish_dir_enabled}" >debug.txt
    echo "publish_dir_path=${task.ext.publish_dir_path}" >>debug.txt
    bedtools \\
        sort \\
        -i $intervals \\
        $sizes \\
        $args \\
        > ${prefix}.${extension}
    """
}

process TABIX_BGZIPTABIX {
    tag "$meta.id"
    label 'process_low'

    container 'danhumassmed/samtools-bedtools:1.0.1'

    publishDir =[ path: { "${task.ext.publish_dir_path}" }, 
                  mode: "${params.publish_dir_mode}", 
                  overwrite: true,
                  pattern: '*', 
                  enabled: "${params.save_reference}" 
                ]
    

    input:
    tuple val(meta), path(input)

    output:
    tuple val(meta), path("*.gz"), path("*.tbi"), optional: true, emit: gz_tbi
    tuple val(meta), path("*.gz"), path("*.csi"), optional: true, emit: gz_csi

    when:
    task.ext.when == null || task.ext.when

    script:
    """
    echo "publish_dir_enabled=${params.save_reference}" >debug.txt
    echo "publish_dir_path=${task.ext.publish_dir_path}" >>debug.txt
    bgzip  --threads ${task.cpus} -c $input > ${meta.id}.${input.getExtension()}.gz
    tabix ${meta.id}.${input.getExtension()}.gz
    """ 
}

process BEDTOOLS_GENOMECOV {
    tag "$meta.id"
    label 'process_low'

    container 'danhumassmed/samtools-bedtools:1.0.1'

    input:
    tuple val(meta), path(intervals), val(scale)
    path  sizes
    val   extension

    output:
    tuple val(meta), path("*.${extension}"), emit: genomecov

    when:
    task.ext.when == null || task.ext.when

    script:
    def args = task.ext.args ?: ''
    def args_list = args.tokenize()
    args += (scale > 0 && scale != 1) ? " -scale $scale" : ""
    if (!args_list.contains('-bg') && (scale > 0 && scale != 1)) {
        args += " -bg"
    }

    def prefix = task.ext.prefix ?: "${meta.id}"
    if (intervals.name =~ /\.bam/) {
        """
        bedtools \\
            genomecov \\
            -ibam $intervals \\
            $args \\
            > ${prefix}.${extension}
        """
    } else {
        """
        bedtools \\
            genomecov \\
            -i $intervals \\
            -g $sizes \\
            $args \\
            > ${prefix}.${extension}
        """
    }
}