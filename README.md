# HSP-Project-Scripts

This is a collection of scripts used in my master thesis. To create these scripts I've adapted and modified code by Luis M Rodriguez-R (https://github.com/lmrodriguezr).

### 01.assembly.pbs
[SPAdes](https://github.com/ablab/spades#sec1.2) assembles the metagenomic samples.

### 02.index.pbs
Concatenate.py (included in Vamb) was used to join the input contigs to a single FASTA file. Moreover, [minimap2](https://github.com/lh3/minimap2) index will be prepared.

### 03.map.pbs
This script will map each of the read files back to the FASTA file with minimap2.  

### 04.vamb.pbs
Simple code to run [Vamb](https://github.com/RasmussenLab/vamb), a metagenomic binner, with the default parameters. 

### 05.miga.pbs/05.miga.bash
Quality filtering, classifying and dereplicating steps with [MiGA](https://github.com/bio-miga/miga). 

### 06.01.index.pbs/06.02.map.pbs
These dereplicated MAGs were then mapped back to the trimmed data for each sample with [Bowtie2](https://github.com/BenLangmead/bowtie2) and converted from SAM files to BAM files with [samtools](https://github.com/samtools/samtools).

### 07.tad.pbs
Calculating TAD80 (truncated average depth of central 80%) for each MAG with [bedtools](https://github.com/arq5x/bedtools2).

### 08.genome-eq.pbs
Calculating the genome equivalents with [MicrobeCensus](https://github.com/snayfach/MicrobeCensus).

### 09.miga.pbs/09.miga.bash
Quality filtering, classifying and dereplicating steps with [MiGA](https://github.com/bio-miga/miga). This script is the same as 05.miga.pbs/05.miga.bash. However, it was used again to combine to different collections of MAGs.

### 10.classify_wf.vamb.pbs
The classify workflow with [GTDB-Tk](https://ecogenomics.github.io/GTDBTk/commands/classify_wf.html) using the GTDB taxonomy.

### 11.nonpareil.pbs
[Nonpareil](https://github.com/lmrodriguezr/nonpareil) calculation to estimate average coverage and create Nonpareil curves for metagenomic datasets.

## R scripts
Scripts for some data visualization/analysation in RStudio

- **barplot.R** - for the creation of barplots 
- **correlation**.R - to investigate a possible correlation between the relative abundance data of MAGs with metadata
- **nonpareil.R** - to calculate nonpareil curves 
- **relativeAbundance.R** - calculation and visualization of the relative abundance data with heatmap3 package
- **venn.R** - for the creation of venn diagrams with the package VennDiagram
