include { BEDTOOLS_SORT     } from "../modules/bedtools"
include { TABIX_BGZIPTABIX  } from "../modules/bedtools"
include { SAMTOOLS_FAIDX    } from "../modules/samtools"
include { SAMTOOLS_FAIDX as CHROMSIZES_TARGET } from "../modules/samtools"
include { SAMTOOLS_FAIDX as CHROMSIZES_SPIKEIN } from "../modules/samtools"

workflow PREPARE_GENOME {
  main:

    if(params.normalisation_mode == "Spikein") {
        ch_spikein_fasta       = Channel.from( file(params.spikein_fasta) ).map { row -> [[id:"spikein_fasta"], row] }
        ch_bt2_spikein_index = [ [id:"spikein_index"], file(params.spikein_bowtie2) ]
        ch_spikein_chrom_sizes = CHROMSIZES_SPIKEIN ( ch_spikein_fasta ).sizes.map{ it[1] }
    }else{
        ch_spikein_fasta       = Channel.empty()
        ch_bt2_spikein_index   = Channel.empty()
        ch_spikein_chrom_sizes = Channel.empty()
    }

    ch_fasta          = Channel.from( file(params.fasta) ).map { row -> [[id:"target_fasta"], row] }

    ch_gtf            = Channel.from( file(params.gtf) )

    // Can be derived if needed GTF2BED ( ch_gtf )
    ch_gene_bed       = Channel.from( file(params.gene_bed) )

    ch_tabix          = ch_gene_bed.map { row -> [ [ id:row.getName() ] , row ] }

    BEDTOOLS_SORT ( ch_tabix, [] )

    TABIX_BGZIPTABIX ( BEDTOOLS_SORT.out.sorted )

    ch_gene_bed_index = TABIX_BGZIPTABIX.out.gz_tbi

    ch_fasta_index    = SAMTOOLS_FAIDX ( ch_fasta ).fai  

    ch_chrom_sizes    = CHROMSIZES_TARGET ( ch_fasta ).sizes.map{ it[1] }
    
    ch_bt2_index      = [ [id:"target_index"], file(params.bowtie2) ]

    //Left Empty for now BLACKLIST_BEDTOOLS_COMPLEMENT
    ch_genome_include_regions = Channel.empty()

    
  emit:
    fasta                  = ch_fasta                    // path: genome.fasta
    spikein_fasta          = ch_spikein_fasta            // path: genome.fasta
    fasta_index            = ch_fasta_index              // path: genome.fai
    chrom_sizes            = ch_chrom_sizes              // path: genome.sizes
    spikein_chrom_sizes    = ch_spikein_chrom_sizes      // path: genome.sizes
    gtf                    = ch_gtf                      // path: genome.gtf
    bed                    = ch_gene_bed                 // path: genome.bed
    bed_index              = ch_gene_bed_index           // path: genome.bed_index
    allowed_regions        = ch_genome_include_regions   // path: genome.regions
    allowed_regions        = ch_genome_include_regions   // path: genome.regions
    bowtie2_index          = ch_bt2_index                // path: bt2/index/
    bowtie2_spikein_index  = ch_bt2_spikein_index        // path: bt2/index/

}