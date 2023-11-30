#!/usr/bin/env nextflow 



nextflow.enable.dsl = 2

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
print("params.fasta     ${params.fasta}")
print("params.bowtie2   ${params.bowtie2}")
print("params.gtf       ${params.gtf}")
print("params.gene_bed  ${params.gene_bed}")
print("params.blacklist ${params.blacklist}")

/*
========================================================================================
    SPIKEIN GENOME PARAMETER VALUES
========================================================================================
*/

if(params.normalisation_mode == "Spikein") {
    params.spikein_fasta   = WorkflowUtils.getGenomeAttributeSpikeIn(params, 'fasta')
    params.spikein_bowtie2 = WorkflowUtils.getGenomeAttributeSpikeIn(params, 'bowtie2')
}

/*
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    VALIDATE PARAMS
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
*/

WorkflowUtils.initialize(params, log)

/*
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    RUN MAIN WORKFLOW FOR PIPELINE
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
*/

include { RUN_CUT_AND_TAG } from './workflows/run-cut-and-tag'

workflow {
    RUN_CUT_AND_TAG ()
}

/*
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    THE END
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
*/