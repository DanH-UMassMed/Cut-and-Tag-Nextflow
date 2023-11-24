# Sofware Provided
| Docker Tag | STAR  | RSEM    |
|----------|---------|------------|
| 1.0.1    | 2.7.10b | v1.3.3 |

## STAR 
---

[https://github.com/alexdobin/STAR](https://github.com/alexdobin/STAR)

Accurate alignment of high-throughput RNA-seq data is a challenging and yet unsolved problem because of the non-contiguous transcript structure, relatively short read lengths and constantly increasing throughput of the sequencing technologies. Currently available RNA-seq aligners suffer from high mapping error rates, low mapping speed, read length limitation and mapping biases.

<br>
<br>

## RSEM
---


[https://github.com/deweylab/RSEM](https://github.com/deweylab/RSEM)

RSEM is a user-friendly software package for quantifying gene and isoform abundances from single-end or paired-end RNA-Seq data. RSEM outputs abundance estimates, 95% credibility intervals, and visualization files and can also simulate RNA-Seq data. In contrast to other existing tools, the software does not require a reference genome. Thus, in combination with a de novo transcriptome assembler, RSEM enables accurate transcript quantification for species without sequenced genomes. On simulated and real data sets, RSEM has superior or comparable performance to quantification methods that rely on a reference genome. Taking advantage of RSEM's ability to effectively use ambiguously-mapping reads, we show that accurate gene-level abundance estimates are best obtained with large numbers of short single-end reads. On the other hand, estimates of the relative frequencies of isoforms within single genes may be improved through the use of paired-end reads, depending on the number of possible splice forms for each gene.

<br>
<br>

# Usage

The provided Docker image is compatible with [Singularity](https://sylabs.io/docs/) and is actively used in [NextFlow](https://www.nextflow.io/) Pipelines configured for an HPC.