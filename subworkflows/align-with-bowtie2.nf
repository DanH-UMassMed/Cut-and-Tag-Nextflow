/*
 * Alignment with BOWTIE2
 */

include { BOWTIE2_ALIGN as ALIGN_TARGET                   } from '../modules/bowtie2'
include { BOWTIE2_ALIGN as ALIGN_SPIKEIN                  } from '../modules/bowtie2'
include { BAM_SORT_STATS_SAMTOOLS  as SORT_STATS_TARGET   } from './bam-sort-stats-with-samtools.nf'
include { BAM_SORT_STATS_SAMTOOLS  as SORT_STATS_SPIKEIN  } from './bam-sort-stats-with-samtools.nf'

workflow ALIGN_BOWTIE2 {
    take:
    reads         // channel: [ val(meta), [ reads ] ]
    index         // channel: [ val(meta), [ index ] ]
    spikein_index // channel: [ val(meta), [ index ] ]
    fasta         // channel: [ val(meta), fasta ]
    spikein_fasta // channel: [ val(meta), fasta ]

    main:

    /*
     * Map reads with BOWTIE2 to target genome
     */
    ch_index = index.map { input -> [[id:input.baseName], input] }
   
    ALIGN_TARGET (
        reads,
        ch_index.collect{ it[1] },
        params.save_unaligned,
        false
    )

    /*
     * Map reads with BOWTIE2 to spike-in genome
     */
    ch_spikein_index = spikein_index.map { [[id:it.baseName], it] }
    ALIGN_SPIKEIN (
        reads,
        ch_spikein_index.collect{ it[1] },
        params.save_unaligned,
        false
    )

    /*
     * Sort, index BAM file and run samtools stats, flagstat and idxstats
     */
    SORT_STATS_TARGET ( ALIGN_TARGET.out.aligned, fasta ) 
    SORT_STATS_SPIKEIN ( ALIGN_SPIKEIN.out.aligned, spikein_fasta ) 


    emit:
    orig_bam             = ALIGN_TARGET.out.aligned           // channel: [ val(meta), bam ] 
    bowtie2_log          = ALIGN_TARGET.out.log               // channel: [ val(meta), log_final ]

    orig_spikein_bam     = ALIGN_SPIKEIN.out.aligned          // channel: [ val(meta), bam ] 
    bowtie2_spikein_log  = ALIGN_SPIKEIN.out.log              // channel: [ val(meta), log_final ]

    bam                  = SORT_STATS_TARGET.out.bam          // channel: [ val(meta), [ bam ] ]
    bai                  = SORT_STATS_TARGET.out.bai          // channel: [ val(meta), [ bai ] ]
    stats                = SORT_STATS_TARGET.out.stats        // channel: [ val(meta), [ stats ] ]
    flagstat             = SORT_STATS_TARGET.out.flagstat     // channel: [ val(meta), [ flagstat ] ]
    idxstats             = SORT_STATS_TARGET.out.idxstats     // channel: [ val(meta), [ idxstats ] ]

    spikein_bam          = SORT_STATS_SPIKEIN.out.bam         // channel: [ val(meta), [ bam ] ]
    spikein_bai          = SORT_STATS_SPIKEIN.out.bai         // channel: [ val(meta), [ bai ] ]
    spikein_stats        = SORT_STATS_SPIKEIN.out.stats       // channel: [ val(meta), [ stats ] ]
    spikein_flagstat     = SORT_STATS_SPIKEIN.out.flagstat    // channel: [ val(meta), [ flagstat ] ]
    spikein_idxstats     = SORT_STATS_SPIKEIN.out.idxstats    // channel: [ val(meta), [ idxstats ] ]
}