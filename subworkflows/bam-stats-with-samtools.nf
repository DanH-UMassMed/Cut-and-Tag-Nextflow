//
// Run SAMtools stats, flagstat and idxstats
//

include { SAMTOOLS_STATS    } from '../modules/samtools'
include { SAMTOOLS_IDXSTATS } from '../modules/samtools'
include { SAMTOOLS_FLAGSTAT } from '../modules/samtools'

workflow BAM_STATS_SAMTOOLS {
    take:
    ch_bam_bai // channel: [ val(meta), path(bam), path(bai) ]
    ch_fasta   // channel: [ val(meta), path(fasta) ]

    main:

    SAMTOOLS_STATS ( ch_bam_bai, ch_fasta )

    SAMTOOLS_FLAGSTAT ( ch_bam_bai )

    SAMTOOLS_IDXSTATS ( ch_bam_bai )

    emit:
    stats    = SAMTOOLS_STATS.out.stats       // channel: [ val(meta), path(stats) ]
    flagstat = SAMTOOLS_FLAGSTAT.out.flagstat // channel: [ val(meta), path(flagstat) ]
    idxstats = SAMTOOLS_IDXSTATS.out.idxstats // channel: [ val(meta), path(idxstats) ]
}