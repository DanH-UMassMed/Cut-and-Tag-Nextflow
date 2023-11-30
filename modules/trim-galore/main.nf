


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
    tag "TRIM_GALORE on $meta.id"
    container "danhumassmed/picard-trimmomatic:1.0.1"

    publishDir = [
                [
                    path: { "${params.results_dir}/01_prealign/trimgalore/fastqc" },
                    mode: "copy",
                    pattern: "*.html"
                ],
                [
                    path: { "${params.results_dir}/01_prealign/trimgalore" },
                    mode: "copy",
                    pattern: "*.fastq.gz",
                    enabled: params.save_trimmed
                ],
                [
                    path: { "${params.results_dir}/01_prealign/trimgalore" },
                    mode: "copy",
                    pattern: "*.txt"
                ]
            ]


    input:
    tuple val(meta), path(reads)

    output:
    tuple val(meta), path("*trimmed.fastq.gz") , emit: reads
    tuple val(meta), path("*report.txt")       , emit: log
    tuple val(meta), path("*html")             , emit: html

    when:
    task.ext.when == null || task.ext.when

    script:
    def cores = 1
    if (task.cpus) {
        if (task.cpus > 4) cores = 4
    }

    // Clipping presets have to be evaluated in the context of SE/PE
    def c_r1    = params.clip_r1 > 0             ? "--clip_r1 ${params.clip_r1}"                         : ''
    def c_r2    = params.clip_r2 > 0             ? "--clip_r2 ${params.clip_r2}"                         : ''
    def tpc_r1  = params.three_prime_clip_r1 > 0 ? "--three_prime_clip_r1 ${params.three_prime_clip_r1}" : ''
    def tpc_r2  = params.three_prime_clip_r2 > 0 ? "--three_prime_clip_r2 ${params.three_prime_clip_r2}" : ''
    def nextseq = params.trim_nextseq > 0        ? "--nextseq ${params.trim_nextseq}"                    : ''


    // Added soft-links to original fastqs for consistent naming in MultiQC
    def suffix   = ".trimmed"
    def prefix_1 = "${meta.id}_1${suffix}"
    def prefix_2 = "${meta.id}_2${suffix}"
    def prefix   = "${meta.id}${suffix}"

    def args = '--fastqc'

    if (meta.single_end) {
        """
        [ ! -f  ${prefix}.fastq.gz ] && ln -s $reads ${prefix}.fastq.gz
        trim_galore \\
            $args \\
            --cores $cores \\
            --gzip \\
            $c_r1 \\
            $tpc_r1 \\
            $nextseq \\
            ${prefix}.fastq.gz
        
        """
    } else {
        """
        [ ! -f  ${meta.id}_1.fastq.gz ] && ln -s ${reads[0]} ${meta.id}_1.fastq.gz
        [ ! -f  ${meta.id}_2.fastq.gz ] && ln -s ${reads[1]} ${meta.id}_2.fastq.gz
        trim_galore \\
            $args \\
            --cores $cores \\
            --paired \\
            --gzip \\
            $c_r1 \\
            $c_r2 \\
            $tpc_r1 \\
            $tpc_r2 \\
            $nextseq \\
            ${meta.id}_1.fastq.gz \\
            ${meta.id}_2.fastq.gz


        mv ${meta.id}_1_val_1.fq.gz ${prefix_1}.fastq.gz
        mv ${meta.id}_2_val_2.fq.gz ${prefix_2}.fastq.gz

        [ ! -f  ${meta.id}_1_val_1_fastqc.html ] || mv ${meta.id}_1_val_1_fastqc.html ${meta.id}_1${suffix}_fastqc.html
        [ ! -f  ${meta.id}_2_val_2_fastqc.html ] || mv ${meta.id}_2_val_2_fastqc.html ${meta.id}_2${suffix}_fastqc.html

        [ ! -f  ${meta.id}_1_val_1_fastqc.zip ] || mv ${meta.id}_1_val_1_fastqc.zip ${meta.id}_1${suffix}_fastqc.zip
        [ ! -f  ${meta.id}_2_val_2_fastqc.zip ] || mv ${meta.id}_2_val_2_fastqc.zip ${meta.id}_2${suffix}_fastqc.zip
    
       """
    }

}