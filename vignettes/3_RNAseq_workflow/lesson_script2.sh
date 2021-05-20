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

## Checking RNAseq read quality using FastQC

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

































