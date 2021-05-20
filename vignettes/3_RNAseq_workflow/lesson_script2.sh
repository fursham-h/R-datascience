## INTRO

## GOALS:
# 1) To check the quality of our reads
# 2) To write a simple bash script
# 3) To trim our reads
# 4) To align reads to mouse transcriptome and quantify transcript expression

# Lesson schedule:
# https://fursham-h.github.io/R-datascience/articles/3_RNAseq_workflow/Overview.html

## CHECK-in to Etherpad
# https://etherpad.wikimedia.org/p/CDN-RNAseqIntro2-online

## RECAP OF COMMANDS learnt so far
###### DON'T have to follow along!!
pwd
cd ~/RNAseq_workshop/originals
ls -l
ls -l FASTQ
man ls
ls --help
mkdir testfolder
touch test.txt
nano test.txt
cp test.txt test
mv test.txt test_new.txt
mv test_new.txt testfolder
rm -r testfolder

cd FASTQ
gunzip SRR7311317_1.fastq.gz
head SRR7311317_1.fastq
wc -l SRR7311317_1.fastq
grep NNN SRR7311317_1.fastq
grep NNN SRR7311317_1.fastq > NNN.txt
grep NNN SRR7311317_1.fastq | wc -l
grep NNN SRR7311317_1.fastq | wc -l >> NNN.txt
gzip SRR7311317_1.fastq

# Recap on RNA-seq pipeline
# https://raw.githubusercontent.com/fursham-h/R-datascience/master/vignettes/3_RNAseq_workflow/images/RNAseq_workflow.png

## PART1: Quality control of RNAseq reads

# to check fastqc arguments:
fastqc -h
## commonly-used arguments:
# `-o` to specify output directory
# `-t` to specify the number of CPUs to run program

# we will create a bash script to perform QC
cd ~/RNAseq_workshop/scripts/
nano run_fastqc.sh

###### SCRIPT SHOULD LOOK LIKE THIS ######
#!/bin/bash

echo "Running FastQC analysis......"

cd ~/RNAseq_workshop/
mkdir ./outputs/FASTQC
fastqc ./originals/FASTQ/*.fastq.gz -o ./outputs/FASTQC/

##########################################

ls -l ~/RNAseq_workshop/outputs/FASTQC

## Open SRR7311317_1_fastqc.html
#mac
open ~/RNAseq_workshop/outputs/FASTQC/SRR7311317_1_fastqc.html

# windows
start ~/RNAseq_workshop/outputs/FASTQC/SRR7311317_1_fastqc.html

# linux
xdg-open ~/RNAseq_workshop/outputs/FASTQC/SRR7311317_1_fastqc.html
xdg-open ~/RNAseq_workshop/outputs/FASTQC/SRR7311317_2_fastqc.html

## Example of a bad sequencing experiment
# https://www.bioinformatics.babraham.ac.uk/projects/fastqc/bad_sequence_fastqc.html

## We will need to trim the 5'end of the read to obtain a high-quality set of reads

## PART2: Read trimming

# to see trimmomatic arguments
trimmomatic -h



# Download all scripts and files required
curl -O https://raw.githubusercontent.com/fursham-h/R-datascience/master/vignettes/3_RNAseq_workflow/scripts/run_trimmomatic.sh
curl -O https://raw.githubusercontent.com/fursham-h/R-datascience/master/vignettes/3_RNAseq_workflow/scripts/Nextera_TruSeq-PE.fa



























