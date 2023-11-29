


/**********************************
Phred+33 Scores

Quality | Prob.       | Accuracy
 Score  | Score is    |    of 
        | Incorrect   | Base Call
====================================
   10   | 1 in 10     | 90%
   20   | 1 in 100    | 99%
   30   | 1 in 1,000  | 99.90%
   40   | 1 in 10,000 | 99.99%
*************************************/

process TRIM_GALORE {
    label 'process_medium'
    tag "TRIM_GALORE on $sample_id"
    container "danhumassmed/picard-trimmomatic:1.0.1"

    input:
    tuple val(sample_id), path(reads)
    val data_root
    val dir_suffix

    script:
    """
    trim_galore.sh ${reads[0]} ${reads[1]} ${data_root} ${dir_suffix} ${task.cpus}
    """

    output:
    path "output_${dir_suffix}" 

}

process TRIM_GALORE_SINGLE {
    label 'process_medium'
    tag "TRIM_GALORE_SINGLE on ${reads.getName().split("\\.")[0]}"
    container "danhumassmed/picard-trimmomatic:1.0.1"

    input:
    path reads
    val data_root
    val dir_suffix

    script:
    """
    trim_galore.sh ${reads} "" ${data_root} ${dir_suffix} ${task.cpus}
    """

    output:
    path "output_${dir_suffix}" 
}

process TRIM_GALORE_AGGREGATE {
    label 'process_low'
    container "danhumassmed/picard-trimmomatic:1.0.1"
    publishDir params.results_dir, mode:'copy'

    input:
    path('*')

    script:
    """
    trim_aggregate.sh "has_report_data"
    """

    output:
    path "trimmed" 
    path "trim_report"

}
