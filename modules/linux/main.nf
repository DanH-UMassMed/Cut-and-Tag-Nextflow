process AWK {
    tag "$meta.id"
    label 'process_low'

    container 'danhumassmed/samtools-bedtools:1.0.1'
    publishDir = [
                enabled: false
            ]

    input:
    tuple val(meta), path(input)

    output:
    tuple val(meta), path("*.awk.*"), emit: file

    when:
    task.ext.when == null || task.ext.when

    script:
    def prefix   = task.ext.suffix ? "${meta.id}${task.ext.suffix}" : "${meta.id}"
    def ext      = task.ext.ext ?: 'txt'
    def command  = task.ext.command ?: ''
    def command2 = task.ext.command2 ?: ''

    """
    awk $command $input $command2 > ${prefix}.awk.${ext}
    """
}

process AWK_SCRIPT {
    tag "$meta.id"
    label 'process_low'

    container 'danhumassmed/samtools-bedtools:1.0.1'
    publishDir = [
                enabled: false
            ]

    input:
    tuple val(meta), path(input)
    path script

    output:
    tuple val(meta), path("*.awk.txt"), emit: file

    when:
    task.ext.when == null || task.ext.when

    script:
    def prefix = task.ext.suffix ? "${meta.id}${task.ext.suffix}" : "${meta.id}"
    """
    awk -f $script $input > ${prefix}.awk.txt
    """
}