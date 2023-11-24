# Sofware Provided

| Docker Tag | HOMER    | samtools | DESeq2  |edgeR    |rclone  |
|------------|----------|----------|---------|---------|--------|
| 1.0.1      | v4.11.1  | v1.17    | v1.38.0 | v3.40.0 |v1.63.1 |

## HOMER Software for motif discovery and next generation sequencing analysis
---

[http://homer.ucsd.edu/homer/index.html](http://homer.ucsd.edu/homer/index.html)


HOMER (Hypergeometric Optimization of Motif EnRichment) is a suite of tools for Motif Discovery and next-gen sequencing analysis.  It is a collection of command line programs for UNIX-style operating systems written in Perl and C++. HOMER was primarily written as a de novo motif discovery algorithm and is well suited for finding 8-20 bp motifs in large scale genomics data.  HOMER contains many useful tools for analyzing ChIP-Seq, GRO-Seq, RNA-Seq, DNase-Seq, Hi-C and numerous other types of functional genomics sequencing data sets.
<br>



## Salmtools
---

[http://www.htslib.org/](http://www.htslib.org/)

Samtools is a suite of programs for interacting with high-throughput sequencing data. It consists of three separate repositories:

* __Samtools__ Reading/writing/editing/indexing/viewing SAM/BAM/CRAM format
* __BCFtools__ Reading/writing BCF2/VCF/gVCF files and calling/filtering/summarising SNP and short indel sequence variants
* __HTSlib__ A C library for reading/writing high-throughput sequencing data

Samtools and BCFtools both use HTSlib internally, but these source packages contain their own copies of htslib so they can be built independently.

<br>

<br>


## DESeq2
---

[https://bioinformaticshome.com/tools/rna-seq/descriptions/DESeq2.html](https://bioinformaticshome.com/tools/rna-seq/descriptions/DESeq2.html)


DESeq2 is a tool for differential gene expression analysis of RNA-seq data. DESeq2 is a new version of DESeq and can detect more differentially expressed genes (DEGs) than DESeq2. However, it also seems to allow more false positives. The DESeq2 algorithm uses the negative binomial distribution, the Wald, and the Likelihood Ratio Tests.

<br>

## edgeR: Empirical Analysis of Digital Gene Expression Data in R
---

[https://rdrr.io/bioc/edgeR/](https://rdrr.io/bioc/edgeR/)


Differential expression analysis of RNA-seq expression profiles with biological replication. Implements a range of statistical methodology based on the negative binomial distributions, including empirical Bayes estimation, exact tests, generalized linear models and quasi-likelihood tests. As well as RNA-seq, it be applied to differential signal analysis of other types of genomic data that produce read counts, including ChIP-seq, ATAC-seq, Bisulfite-seq, SAGE and CAGE.


<br>
## rclone: Rclone syncs your files to cloud storage
---

[https://rclone.org/#about](https://rclone.org/#about)


Rclone is a command-line program to manage files on cloud storage. It is a feature-rich alternative to cloud vendors' web storage interfaces. Over 70 cloud storage products support rclone including S3 object stores, business & consumer file storage services, as well as standard transfer protocols.

<br>


# Usage

The provided Docker image is compatible with [Singularity](https://sylabs.io/docs/) and is actively used in [NextFlow](https://www.nextflow.io/) Pipelines configured for an HPC.


```
docker run -v /home/dan/.config/rclone/rclone.conf:/root/.config/rclone/rclone.conf danhumassmed/de-seq-tools:1.0.1 rclone ls remote:/
```

<br>
