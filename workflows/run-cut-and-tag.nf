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

include { PREPARE_GENOME    } from "../subworkflows/prepare-genome"
include { LOAD_SAMPLE_SHEET } from "../subworkflows/load-sample-sheet.nf"
include { FASTQC            } from "../modules/fastqc"
include { TRIM_GALORE       } from "../modules/trim-galore"
include { ALIGN_BOWTIE2     } from "../subworkflows/align-with-bowtie2"
include { EXTRACT_METADATA_AWK as EXTRACT_BT2_TARGET_META  } from "../subworkflows/extract_metadata_awk"


workflow RUN_CUT_AND_TAG {
    print("Starting run cut and tag")
    /*
     * SUBWORKFLOW: Uncompress and prepare reference genome files
     */
    PREPARE_GENOME()

    /*
     * SUBWORKFLOW: Read in samplesheet, validate and stage input files
     */
    ch_reads = LOAD_SAMPLE_SHEET(ch_input)

    /*
     * WORKFLOWS: Read QC, trim adapters and perform post-trim read QC
     */
    FASTQC(ch_reads, "pretrim_fatstqc")
    TRIM_GALORE(ch_reads) 
    ch_trimmed_reads = TRIM_GALORE.out.reads

    /*
    * SUBWORKFLOW: Alignment to target genome using botwtie2
    */
    ALIGN_BOWTIE2 (ch_trimmed_reads, PREPARE_GENOME.out.bowtie2_index, PREPARE_GENOME.out.fasta )
    ch_orig_bam                   = ALIGN_BOWTIE2.out.orig_bam
    ch_bowtie2_log                = ALIGN_BOWTIE2.out.bowtie2_log

    ch_samtools_bam               = ALIGN_BOWTIE2.out.bam
    ch_samtools_bai               = ALIGN_BOWTIE2.out.bai
    ch_samtools_stats             = ALIGN_BOWTIE2.out.stats
    ch_samtools_flagstat          = ALIGN_BOWTIE2.out.flagstat
    ch_samtools_idxstats          = ALIGN_BOWTIE2.out.idxstats

    /*
     * SUBWORKFLOW: extract aligner metadata
     */
     //ext.suffix = "_meta_bt2_target"
     //script_mode = true
    EXTRACT_BT2_TARGET_META (
        ch_bowtie2_log,
        ch_bt2_to_csv_awk,
        true
    )
    ch_metadata_bt2_target = EXTRACT_BT2_TARGET_META.out.metadata
    
}


