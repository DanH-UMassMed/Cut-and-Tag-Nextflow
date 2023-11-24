# Sofware Provided

| Docker Tag | macs2    | seacr | ucsc-bedgraphtobigwig | deeptools |
|------------|----------|-------|-----------------------|-----------|
| 1.0.1      | v2.2.9.1 | v1.3  |v445                   | v3.53     |

---

<br>

 
## MACS2: Model-based Analysis of ChIP-Seq (MACS)

[https://github.com/macs3-project/MACS#macs-model-based-analysis-for-chip-seq](https://github.com/macs3-project/MACS#macs-model-based-analysis-for-chip-seq)


With the improvement of sequencing techniques, chromatin immunoprecipitation followed by high throughput sequencing (ChIP-Seq) is getting popular to study genome-wide protein-DNA interactions. To address the lack of powerful ChIP-Seq analysis method, we presented the Model-based Analysis of ChIP-Seq (MACS), for identifying transcript factor binding sites. MACS captures the influence of genome complexity to evaluate the significance of enriched ChIP regions and MACS improves the spatial resolution of binding sites through combining the information of both sequencing tag position and orientation. 

<br>


## SEACR: Sparse Enrichment Analysis for CUT&RUN

[https://github.com/FredHutch/SEACR](https://github.com/FredHutch/SEACR)


SEACR is intended to call peaks and enriched regions from sparse CUT&RUN or chromatin profiling data in which background is dominated by "zeroes" (i.e. regions with no read coverage). It requires [R](https://www.r-project.org) and [Bedtools](https://bedtools.readthedocs.io/en/latest/) to be available in your path, and it requires bedgraphs from paired-end sequencing as input, which can be generated from read pair BED files (i.e. BED coordinates reflecting the 5' and 3' termini of each read pair) using bedtools genomecov with the "-bg" flag, or alternatively from name-sorted paired-end BAM files as described in "Preparing input bedgraph files" below.

A description of the method can be found in the following manuscript, which we respectfully request that you cite if you find SEACR useful in your research:

Meers MP, Tenenbaum D, Henikoff S. (2019). Peak calling by Sparse Enrichment Analysis for CUT&RUN chromatin profiling. Epigenetics and Chromatin 12(1):42.

Direct link: [https://doi.org/10.1186/s13072-019-0287-4](https://doi.org/10.1186/s13072-019-0287-4)


## deepTools


[https://deeptools.readthedocs.io/en/develop/](https://deeptools.readthedocs.io/en/develop/)


deepTools is a suite of python tools particularly developed for the efficient analysis of high-throughput sequencing data, such as ChIP-seq, RNA-seq or MNase-seq.

There are 3 ways for using deepTools:

* __Galaxy usage__ – our public deepTools Galaxy server let’s you use the deepTools within the familiar Galaxy framework without the need to master the command line
* __command line__ usage – simply download and install the tools (see Installation and The tools)
* __API__ – make use of your favorite deepTools modules in your own python programs (see deepTools API)

<br>

The flow chart below depicts the different tool modules that are currently available.


<img src="https://deeptools.readthedocs.io/en/develop/_images/start_workflow1.png" width="700" alt="Alt Text">


<br>

## ucsc-bedgraphtobigwig


[https://hgdownload.soe.ucsc.edu/downloads.html](https://hgdownload.soe.ucsc.edu/downloads.html)


Convert bedGraph to bigWig file. Description of Big Binary Indexed (BBI) files and visualization of next-generation sequencing experiment results explained by W.J. Kent, PMCID: PMC2922891

Conda Install: [https://anaconda.org/bioconda/ucsc-bedgraphtobigwig](https://anaconda.org/bioconda/ucsc-bedgraphtobigwig)

<br>


---

<br>

# Usage

The provided Docker image is compatible with [Singularity](https://sylabs.io/docs/) and is actively used in [NextFlow](https://www.nextflow.io/) Pipelines configured for an HPC.

<br>
