# Sofware Provided
| Docker Tag | Salmon  | Kallisto    |
|----------|---------|------------|
| 1.0.1    | v0.12.1 | version 0.48.0 |

## Salmon 
---
<img src="https://github.com/COMBINE-lab/salmon/raw/master/doc/salmon_logo.png" alt="Alt Text" width="800" height="164">

[https://github.com/COMBINE-lab/salmon](https://github.com/COMBINE-lab/salmon)

Salmon is a wicked-fast program to produce a highly-accurate, transcript-level quantification estimates from RNA-seq data. Salmon achieves its accuracy and speed via a number of different innovations, including the use of selective-alignment (accurate but fast-to-compute proxies for traditional read alignments), and massively-parallel stochastic collapsed variational inference. 

<br>
<br>

## Kallisto
---

<img src="https://pachterlab.github.io/kallisto/bear.jpg" alt="Alt Text" width="600" height="490">

[https://github.com/pachterlab/kallisto](https://github.com/pachterlab/kallisto)

kallisto is a program for quantifying abundances of transcripts from RNA-Seq data, or more generally of target sequences using high-throughput sequencing reads. It is based on the novel idea of pseudoalignment for rapidly determining the compatibility of reads with targets, without the need for alignment. 

<br>
<br>

# Usage

The provided Docker image is compatible with [Singularity](https://sylabs.io/docs/) and is actively used in [NextFlow](https://www.nextflow.io/) Pipelines configured for an HPC.