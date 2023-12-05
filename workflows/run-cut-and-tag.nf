#!/usr/bin/env nextflow 


/*
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    LOAD CHANNELS
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
*/

// Get the samplesheet for this run
if (params.sample_sheet) { 
    ch_input = file(params.sample_sheet) 
} else { 
    exit 1, "ERROR: sample_sheet not specified!" 
}

ch_blacklist = Channel.empty()
if (params.blacklist) {
    ch_blacklist = Channel.from( file(params.blacklist) )
}

// Stage dummy file to be used as an optional input where required
ch_dummy_file = file("$projectDir/assets/dummy_file.txt", checkIfExists: true)

// Stage awk files for parsing log files
                                              
ch_bt2_to_csv_awk     = file("$projectDir/bin/bt2_report_to_csv.awk"    , checkIfExists: true)
ch_dt_frag_to_csv_awk = file("$projectDir/bin/dt_frag_report_to_csv.awk", checkIfExists: true)
/*
========================================================================================
    IMPORT MODULES/SUBWORKFLOWS
========================================================================================
*/

include { PREPARE_GENOME           } from "../subworkflows/prepare-genome"
include { LOAD_SAMPLE_SHEET        } from "../subworkflows/load-sample-sheet.nf"
include { FASTQC as FASTQC_PRETRIM } from "../modules/fastqc"
include { TRIM_GALORE              } from "../modules/trim-galore"
include { ALIGN_BOWTIE2            } from "../subworkflows/align-with-bowtie2"
include { EXTRACT_METADATA_AWK as EXTRACT_BT2_TARGET_META  } from "../subworkflows/extract-metadata-awk"
include { EXTRACT_METADATA_AWK as EXTRACT_BT2_SPIKEIN_META } from "../subworkflows/extract-metadata-awk"
include { MARK_DUPLICATES_PICARD                           } from "../subworkflows/duplicates-processing-with-picard"
include { MARK_DUPLICATES_PICARD as DEDUPLICATE_PICARD     } from "../subworkflows/duplicates-processing-with-picard"
include { PREPARE_PEAKCALLING                              } from "../subworkflows/prepare-peakcalling"


workflow RUN_CUT_AND_TAG {
    /*
     * SUBWORKFLOW: Uncompress and prepare reference genome files
     */
    PREPARE_GENOME()

    def run_this_code = false
    /*
     * SUBWORKFLOW: Read in samplesheet, validate and stage input files
     */
    ch_reads = LOAD_SAMPLE_SHEET(ch_input)

    /*
     * WORKFLOWS: Read QC, trim adapters and perform post-trim read QC
     */
    FASTQC_PRETRIM(ch_reads)
    TRIM_GALORE(ch_reads) 
    ch_trimmed_reads = TRIM_GALORE.out.reads

    /*
    * SUBWORKFLOW: Alignment to target genome using botwtie2
    */
    ALIGN_BOWTIE2 (ch_trimmed_reads, 
                   PREPARE_GENOME.out.bowtie2_index, 
                   PREPARE_GENOME.out.bowtie2_spikein_index, 
                   PREPARE_GENOME.out.fasta, 
                   PREPARE_GENOME.out.spikein_fasta )

    ch_orig_bam                   = ALIGN_BOWTIE2.out.orig_bam
    ch_orig_spikein_bam           = ALIGN_BOWTIE2.out.orig_spikein_bam
    ch_bowtie2_log                = ALIGN_BOWTIE2.out.bowtie2_log
    ch_bowtie2_spikein_log        = ALIGN_BOWTIE2.out.bowtie2_spikein_log

    ch_samtools_bam               = ALIGN_BOWTIE2.out.bam
    ch_samtools_bai               = ALIGN_BOWTIE2.out.bai
    ch_samtools_stats             = ALIGN_BOWTIE2.out.stats
    ch_samtools_flagstat          = ALIGN_BOWTIE2.out.flagstat
    ch_samtools_idxstats          = ALIGN_BOWTIE2.out.idxstats

    ch_samtools_spikein_bam       = ALIGN_BOWTIE2.out.spikein_bam
    ch_samtools_spikein_bai       = ALIGN_BOWTIE2.out.spikein_bai
    ch_samtools_spikein_stats     = ALIGN_BOWTIE2.out.spikein_stats
    ch_samtools_spikein_flagstat  = ALIGN_BOWTIE2.out.spikein_flagstat
    ch_samtools_spikein_idxstats  = ALIGN_BOWTIE2.out.spikein_idxstats


    ch_metadata_bt2_target  = Channel.empty()
    ch_metadata_bt2_spikein = Channel.empty()
    
        /*
        * SUBWORKFLOW: extract aligner metadata
        * This could likely be removed EXTRACT_BT2_TARGET_META EXTRACT_BT2_SPIKEIN_META
        */

        // //script_mode = true
        // EXTRACT_BT2_TARGET_META (
        //     ch_bowtie2_log,
        //     ch_bt2_to_csv_awk,
        //     true
        // )
        // ch_metadata_bt2_target = EXTRACT_BT2_TARGET_META.out.metadata
        
        // EXTRACT_BT2_SPIKEIN_META (
        //         ch_bowtie2_spikein_log,
        //         ch_bt2_to_csv_awk,
        //         true
        //     )
        // ch_metadata_bt2_spikein = EXTRACT_BT2_SPIKEIN_META.out.metadata


    /*
     *  SUBWORKFLOW: Filter reads based some standard measures
     *  - Unmapped reads 0x004
     *  - Mate unmapped 0x0008
     *  - Multi-mapped reads
     *  - Filter out reads aligned to blacklist regions
     *  - Filter out reads below a threshold q score
     *  - Filter out mitochondrial reads (if required)
     */

    /*
     * SUBWORKFLOW: Mark duplicates on all samples
     */
    ch_markduplicates_metrics = Channel.empty()
    MARK_DUPLICATES_PICARD (
        ch_samtools_bam,
        ch_samtools_bai,
        true,
        PREPARE_GENOME.out.fasta.collect(), 
        PREPARE_GENOME.out.fasta_index.collect()
    )
    ch_samtools_bam           = MARK_DUPLICATES_PICARD.out.bam
    ch_samtools_bai           = MARK_DUPLICATES_PICARD.out.bai
    ch_samtools_stats         = MARK_DUPLICATES_PICARD.out.stats
    ch_samtools_flagstat      = MARK_DUPLICATES_PICARD.out.flagstat
    ch_samtools_idxstats      = MARK_DUPLICATES_PICARD.out.idxstats
    ch_markduplicates_metrics = MARK_DUPLICATES_PICARD.out.metrics

    //EXAMPLE CHANNEL STRUCT: [[id:h3k27me3_R1, group:h3k27me3, replicate:1, single_end:false, is_control:false], [BAM]]
    //ch_samtools_bam | view

    /*
     * SUBWORKFLOW: Remove duplicates - default is on IgG controls only
     */
    DEDUPLICATE_PICARD (
        ch_samtools_bam,
        ch_samtools_bai,
        params.dedup_target_reads,
        PREPARE_GENOME.out.fasta.collect(),
        PREPARE_GENOME.out.fasta_index.collect()
    )
    ch_samtools_bam      = DEDUPLICATE_PICARD.out.bam
    ch_samtools_bai      = DEDUPLICATE_PICARD.out.bai
    ch_samtools_stats    = DEDUPLICATE_PICARD.out.stats
    ch_samtools_flagstat = DEDUPLICATE_PICARD.out.flagstat
    ch_samtools_idxstats = DEDUPLICATE_PICARD.out.idxstats

    /*
    * SUBWORKFLOW: Convert BAM files to bedgraph/bigwig and apply configured normalisation strategy
    */
    if(run_this_code) {

    PREPARE_PEAKCALLING(
        ch_samtools_bam,
        ch_samtools_bai,
        PREPARE_GENOME.out.chrom_sizes.collect(),
        ch_dummy_file,
        params.normalisation_mode,
        ch_metadata_bt2_spikein
    )
    ch_bedgraph          = PREPARE_PEAKCALLING.out.bedgraph
    ch_bigwig            = PREPARE_PEAKCALLING.out.bigwig

    }

}