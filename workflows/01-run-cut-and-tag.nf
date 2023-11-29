#!/usr/bin/env nextflow 
/*
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    GENOME PARAMETER VALUES
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
*/

params.fasta     = WorkflowUtils.getGenomeAttribute(params, 'fasta')
params.bowtie2   = WorkflowUtils.getGenomeAttribute(params, 'bowtie2')
params.gtf       = WorkflowUtils.getGenomeAttribute(params, 'gtf')
params.gene_bed  = WorkflowUtils.getGenomeAttribute(params, 'bed12')
params.blacklist = WorkflowUtils.getGenomeAttribute(params, 'blacklist')


// Check tha mandatory parameters before we get started
if (params.sample_sheet) { ch_input = file(params.sample_sheet) } else { exit 1, "ERROR: sample_sheet not specified!" }
if (!params.genome) { exit 1, "ERROR: genome not specified!" }

include { LOAD_SAMPLE_SHEET } from "../subworkflows/load-sample-sheet.nf"
include { PREPARE_GENOME    } from "../subworkflows/prepare-genome"
include { ALIGN_BOWTIE2     } from "../subworkflows/align-with-bowtie2"


workflow RUN_CUT_AND_TAG {
  print("Starting run cut and tag")
  ch_reads = LOAD_SAMPLE_SHEET(ch_input)
  //ch_reads.view()
  print("params.fasta ${params.fasta} \n")
  PREPARE_GENOME()
  
  ALIGN_BOWTIE2 (ch_reads, PREPARE_GENOME.out.bowtie2_index, PREPARE_GENOME.out.fasta )
    
  print("Finishing!!!!")

}


