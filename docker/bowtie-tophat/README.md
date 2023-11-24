# Sofware Provided
[label](https://passwords.google.com/?utm_source%253Dchrome%2526utm_medium%253Ddesktop%2526utm_campaign%253Dpassword_generation_confirmation%2526pli%253D1)
| Docker Tag | Bowtie  | Bowtie2  | Tophat  |
|------------|---------|----------|---------|
| 1.0.1      | v1.2.2  | v2.3.4.3 | v2.1.1  |

## Bowtie
---

[https://bowtie-bio.sourceforge.net/index.shtml](https://bowtie-bio.sourceforge.net/index.shtml)


__Bowtie__ is an ultrafast, memory-efficient short read aligner. It aligns short DNA sequences (reads) to the human genome at a rate of over 25 million 35-bp reads per hour. Bowtie indexes the genome with a Burrows-Wheeler index to keep its memory footprint small: typically about 2.2 GB for the human genome (2.9 GB for paired-end).

<br>


<br>

## Bowtie2
---

[https://bowtie-bio.sourceforge.net/bowtie2/index.shtml](https://bowtie-bio.sourceforge.net/bowtie2/index.shtml)


__Bowtie 2__ is an ultrafast and memory-efficient tool for aligning sequencing reads to long reference sequences. It is particularly good at aligning reads of about 50 up to 100s or 1,000s of characters, and particularly good at aligning to relatively long (e.g. mammalian) genomes. Bowtie 2 indexes the genome with an FM Index to keep its memory footprint small: for the human genome, its memory footprint is typically around 3.2 GB. Bowtie 2 supports gapped, local, and paired-end alignment modes.

<br>

## TopHat
---

[http://ccb.jhu.edu/software/tophat/index.shtml/](http://ccb.jhu.edu/software/tophat/index.shtml)


__TopHat__ is a fast splice junction mapper for RNA-Seq reads. It aligns RNA-Seq reads to mammalian-sized genomes using the ultra high-throughput short read aligner Bowtie, and then analyzes the mapping results to identify splice junctions between exons.



<br>
# Usage

The provided Docker image is compatible with [Singularity](https://sylabs.io/docs/) and is actively used in [NextFlow](https://www.nextflow.io/) Pipelines configured for an HPC.

<br>
