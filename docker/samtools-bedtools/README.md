# Sofware Provided

| Docker Tag | Samtools     | Bedtools | mashmap |
|------------|--------------|--------- | ------- |
| 1.0.1      | version 1.10 | v2.29.2  | v2.0    |

## Salmtools
---

[http://www.htslib.org/](http://www.htslib.org/)

Samtools is a suite of programs for interacting with high-throughput sequencing data. It consists of three separate repositories:

* __Samtools__ Reading/writing/editing/indexing/viewing SAM/BAM/CRAM format
* __BCFtools__ Reading/writing BCF2/VCF/gVCF files and calling/filtering/summarising SNP and short indel sequence variants
* __HTSlib__ A C library for reading/writing high-throughput sequencing data

Samtools and BCFtools both use HTSlib internally, but these source packages contain their own copies of htslib so they can be built independently.

<br>

<img src="https://ars.els-cdn.com/content/image/3-s2.0-B9780124047488000095-f09-09-9780124047488.jpg" alt="Alt Text">

<br>
<br>

## Bedtools
---

<img src="https://bedtools.readthedocs.io/en/latest/_static/bedtools.swiss.png" alt="Alt Text" >

[https://bedtools.readthedocs.io/en/latest/index.html](https://bedtools.readthedocs.io/en/latest/index.html)

Collectively, the bedtools utilities are a swiss-army knife of tools for a wide-range of genomics analysis tasks. The most widely-used tools enable genome arithmetic: that is, set theory on the genome. For example, bedtools allows one to intersect, merge, count, complement, and shuffle genomic intervals from multiple files in widely-used genomic file formats such as BAM, BED, GFF/GTF, VCF. While each individual tool is designed to do a relatively simple task (e.g., intersect two interval files), quite sophisticated analyses can be conducted by combining multiple bedtools operations on the UNIX command line.

<br>
<br>

## MashMap
---


[https://github.com/marbl/MashMap](https://github.com/marbl/MashMap)

MashMap implements a fast and approximate algorithm for computing local alignment boundaries between long DNA sequences. It can be useful for mapping genome assembly or long reads (PacBio/ONT) to reference genome(s). Given a minimum alignment length and an identity threshold for the desired local alignments, Mashmap computes alignment boundaries and identity estimates using k-mers. It does not compute the alignments explicitly, but rather estimates an unbiased k-mer based Jaccard similarity using a combination of minmers (a novel winnowing scheme) and MinHash. This is then converted to an estimate of sequence identity using the Mash distance. An appropriate k-mer sampling rate is automatically determined using the given minimum local alignment length and identity thresholds.

<br>

<img src="https://camo.githubusercontent.com/4a4e8810efb65af7eb813da9914e20a88416e3dd0ce277cb282652999aa95baa/68747470733a2f2f692e706f7374696d672e63632f48736b4a4e7a4e672f726561646d652d6d6173686d61702e6a7067" alt="Alt Text" width="600" height="600" >

<br>

# Usage

The provided Docker image is compatible with [Singularity](https://sylabs.io/docs/) and is actively used in [NextFlow](https://www.nextflow.io/) Pipelines configured for an HPC.