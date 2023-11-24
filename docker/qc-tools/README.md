# Sofware Provided
| Docker Tag | FastQC  | MultiQC    | RSeQC |
|----------|---------|--------------|-------|
| 1.0.1    | v0.12.1 | version 1.14 | 4.0.0 |

## FastQC 
---
[https://www.bioinformatics.babraham.ac.uk/projects/fastqc/](https://www.bioinformatics.babraham.ac.uk/projects/fastqc/)

FastQC aims to provide a simple way to do some quality control checks on raw sequence data coming from high throughput sequencing pipelines. It provides a modular set of analyses which you can use to give a quick impression of whether your data has any problems of which you should be aware before doing any further analysis.

The main functions of FastQC are:

* Import of data from BAM, SAM or FastQ files (any variant)
* Providing a quick overview to tell you in which areas there may be problems
* Summary graphs and tables to quickly assess your data
* Export of results to an HTML based permanent report
* Offline operation to allow automated generation of reports without running the interactive application

![fastqc](https://www.bioinformatics.babraham.ac.uk/projects/fastqc/fastqc.png)

## MultiQC
---
[https://multiqc.info/](https://multiqc.info/)

Aggregate results from bioinformatics analyses across many samples into a single report
MultiQC searches a given directory for analysis logs and compiles a HTML report. It's a general use tool, perfect for summarising the output from numerous bioinformatics tools.

![multiqc](https://ugc.futurelearn.com/uploads/assets/eb/7d/eb7d22ad-5809-4a07-99ab-bf8a64ba7607.png)

## RSeQC
---
[https://pythonhosted.org/RSeQC//](https://pythonhosted.org/RSeQC/)

![rseqc](https://pythonhosted.org/RSeQC/_static/logo.png)

RSeQC package provides a number of useful modules that can comprehensively evaluate high throughput sequence data especially RNA-seq data. Some basic modules quickly inspect sequence quality, nucleotide composition bias, PCR bias and GC bias, while RNA-seq specific modules evaluate sequencing saturation, mapped reads distribution, coverage uniformity, strand specificity, transcript level RNA integrity etc.


# Usage

The provided Docker image is compatible with [Singularity](https://sylabs.io/docs/) and is actively used in [NextFlow](https://www.nextflow.io/) Pipelines configured for an HPC.


### Example running fastqc (Mac OSX)

```
local_project_dir="/Users/dan/Code/NextFlow/Bioinformatics_Training/Introduction_to_RNA-seq"
docker_project_dir="/home/rnaseq"
input_dir="raw_data"
output_dir="results/fastqc/"

mkdir -p ${local_project_dir}/${output_dir}
docker run -v ${local_project_dir}:${docker_project_dir} danhumassmed/qc-tools:1.0.1 \
    /bin/bash -c \"fastqc -o ${docker_project_dir}/${output_dir} -f fastq ${docker_project_dir}/${input_dir}/*.fq\"

```