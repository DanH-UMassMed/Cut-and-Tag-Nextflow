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
print("params.fasta     ${params.fasta} \n")
print("params.bowtie2   ${params.bowtie2} \n")
print("params.gtf       ${params.gtf} \n")
print("params.gene_bed  ${params.gene_bed} \n")
print("params.blacklist ${params.blacklist} \n")
print("===========================================\n")
print("params.save_markdup ${params.save_markdup} \n")
print("params.save_dedup ${params.save_dedup} \n")
print("params.dedup_target_reads ${params.dedup_target_reads} \n")
print("===========================================\n")
print("params.save_reference ${params.save_reference} \n")
print("params.publish_dir_mode ${params.publish_dir_mode} \n")

/*
========================================================================================
    SPIKEIN GENOME PARAMETER VALUES
========================================================================================
*/

if(params.normalisation_mode == "Spikein") {
    params.spikein_fasta   = WorkflowUtils.getGenomeAttributeSpikeIn(params, 'fasta')
    params.spikein_bowtie2 = WorkflowUtils.getGenomeAttributeSpikeIn(params, 'bowtie2')
    print("params.spikein_fasta  ${params.spikein_fasta} \n")
    print("params.spikein_bowtie2 ${params.spikein_bowtie2}\n")
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