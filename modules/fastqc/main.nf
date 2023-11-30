
process FASTQC {
    tag "FASTQC on $meta.id"
    label 'process_medium'
    container 'danhumassmed/qc-tools:1.0.1'
    publishDir = [
                [
                    path: { "${params.results_dir}/01_prealign/$state" },
                    mode: "copy",
                    pattern: "*.html"
                ]
    ]
   

    input:
    tuple val(meta), path(reads)
    val state

    output:
    tuple val(meta), path("*.html"), emit: html
    tuple val(meta), path("*.zip") , emit: zip

    script:
    """
    fastqc -o . -t $task.cpus -f fastq -q ${reads}
    """
}

