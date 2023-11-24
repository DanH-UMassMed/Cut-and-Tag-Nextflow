# Sofware Provided

| Docker Tag | Picard    | Trimmomatic | fastp   | trim-galore |
|------------|-----------|-------------|---------|-------------|
| 1.0.1      | v2.18.23  | v0.39       | v0.23.4 | v0.6.10     |


## Picard
---

[https://broadinstitute.github.io/picard/](https://broadinstitute.github.io/picard/)


A set of Java command line tools for manipulating high-throughput sequencing (HTS) data and formats.

<br>

Picard is implemented using the HTSJDK Java library HTSJDK to support accessing file formats that are commonly used for high-throughput sequencing data such as SAM and VCF.

<br>

### Additional Resources

* [Detailed tool documentation](https://broadinstitute.github.io/picard/command-line-overview.html#Overview)
* [Description of output of metrics programs](https://broadinstitute.github.io/picard/picard-metric-definitions.html)
* [SAM differences in Picard](https://broadinstitute.github.io/picard/sam-differences.html)
* [Explain SAM flags](https://broadinstitute.github.io/picard/explain-flags.html)
* [Explain Base Qualities](https://broadinstitute.github.io/picard/explain-qualities.html)
* [Javadoc](http://broadinstitute.github.io/picard/javadoc/picard/index.html)

<br>

## Trimmomatic
---

[http://www.usadellab.org/cms/?page=trimmomatic](http://www.usadellab.org/cms/?page=trimmomatic)


Trimmomatic performs a variety of useful trimming tasks for illumina paired-end and single ended data.The selection of trimming steps and their associated parameters are supplied on the command line.

The current trimming steps are:

* ILLUMINACLIP: Cut adapter and other illumina-specific sequences from the read.
* SLIDINGWINDOW: Perform a sliding window trimming, cutting once the average quality within the window falls below a threshold.
* LEADING: Cut bases off the start of a read, if below a threshold quality
* TRAILING: Cut bases off the end of a read, if below a threshold quality
* CROP: Cut the read to a specified length
* HEADCROP: Cut the specified number of bases from the start of the read
* MINLEN: Drop the read if it is below a specified length
* TOPHRED33: Convert quality scores to Phred-33
* TOPHRED64: Convert quality scores to Phred-64

It works with FASTQ (using phred + 33 or phred + 64 quality scores, depending on the Illumina pipeline used), either uncompressed or gzipp'ed FASTQ. Use of gzip format is determined based on the .gz extension.

For single-ended data, one input and one output file are specified, plus the processing steps. For paired-end data, two input files are specified, and 4 output files, 2 for the 'paired' output where both reads survived the processing, and 2 for corresponding 'unpaired' output where a read survived, but the partner read did not.

<br>

## fastp
---

[https://github.com/OpenGene/fastp](https://github.com/OpenGene/fastp)


A tool designed to provide fast all-in-one preprocessing for FastQ files. This tool is developed in C++ with multithreading supported to afford high performance.

<br>

## trim-galore
---

[https://github.com/FelixKrueger/TrimGalore/blob/master/Docs/Trim_Galore_User_Guide.md](https://github.com/FelixKrueger/TrimGalore/blob/master/Docs/Trim_Galore_User_Guide.md)


For all high throughput sequencing applications, we would recommend performing some quality control on the data, as it can often straight away point you towards the next steps that need to be taken (e.g. with FastQC). Thorough quality control and taking appropriate steps to remove problems is vital for the analysis of almost all sequencing applications. This is even more critical for the proper analysis of RRBS libraries since they are susceptible to a variety of errors or biases that one could probably get away with in other sequencing applications. In our brief guide to RRBS we discuss the following points:

* poor qualities – affect mapping, may lead to incorrect methylation calls and/or mis-mapping
* adapter contamination – may lead to low mapping efficiencies, or, if mapped, may result in incorrect methylation calls and/or mis-mapping
* positions filled in during end-repair will infer the methylation state of the cytosine used for the fill-in reaction but not of the true genomic cytosine
* paired-end RRBS libraries (especially with long read length) yield redundant methylation information if the read pairs overlap
* RRBS libraries with long read lengths suffer more from all of the above due to the short size- selected fragment size

Poor base call qualities or adapter contamination are however just as relevant for 'normal', i.e. non-RRBS, libraries.

<br>

# Usage

The provided Docker image is compatible with [Singularity](https://sylabs.io/docs/) and is actively used in [NextFlow](https://www.nextflow.io/) Pipelines configured for an HPC.

<br>
