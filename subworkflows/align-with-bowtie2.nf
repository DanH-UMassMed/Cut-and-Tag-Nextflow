/*
 * Alignment with BOWTIE2
 */

include { BOWTIE2_ALIGN as BOWTIE2_TARGET_ALIGN                      } from '../modules/bowtie2'
//include { BAM_SORT_STATS_SAMTOOLS                                    } from '../modules/samtools'

workflow ALIGN_BOWTIE2 {
    take:
    reads         // channel: [ val(meta), [ reads ] ]
    index         // channel: [ val(meta), [ index ] ]
    fasta         // channel: [ val(meta), fasta ]

    main:

    /*
     * Map reads with BOWTIE2 to target genome
     */
    ch_index = index.map { [[id:it.baseName], it] }
    BOWTIE2_TARGET_ALIGN (
        reads,
        ch_index.collect{ it[1] },
        params.save_unaligned,
        false
    )


    /*
     * Sort, index BAM file and run samtools stats, flagstat and idxstats
     */
//    BAM_SORT_STATS_SAMTOOLS ( BOWTIE2_TARGET_ALIGN.out.aligned, fasta ) 


    emit:

    orig_bam             = BOWTIE2_TARGET_ALIGN.out.aligned             // channel: [ val(meta), bam ] 

    bowtie2_log          = BOWTIE2_TARGET_ALIGN.out.log                 // channel: [ val(meta), log_final ]

//    bam                  = BAM_SORT_STATS_SAMTOOLS.out.bam              // channel: [ val(meta), [ bam ] ]
//    bai                  = BAM_SORT_STATS_SAMTOOLS.out.bai              // channel: [ val(meta), [ bai ] ]
//    stats                = BAM_SORT_STATS_SAMTOOLS.out.stats            // channel: [ val(meta), [ stats ] ]
//    flagstat             = BAM_SORT_STATS_SAMTOOLS.out.flagstat         // channel: [ val(meta), [ flagstat ] ]
//    idxstats             = BAM_SORT_STATS_SAMTOOLS.out.idxstats         // channel: [ val(meta), [ idxstats ] ]

}