#PREPPPP: activate conda py3.7 env

## Check-in to Etherpad
# https://etherpad.wikimedia.org/p/CDN-RNAseqIntro2-online

## Objectives for this session:
# 1) To check the quality of our reads
# 2) To write a simple bash script to automate commands
# 3) To trim our reads
# 4) To align reads to mouse transcriptome and quantify transcript expression

# Lesson schedule:
# https://fursham-h.github.io/R-datascience/articles/3_RNAseq_workflow/Overview.html

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

# Image of how paired-end reads are obtained
# https://i0.wp.com/thesequencingcenter.com/wp-content/uploads/2019/03/paired-end-read-1.jpg?resize=892%2C367&ssl=1

# Recap on RNA-seq pipeline
# https://raw.githubusercontent.com/fursham-h/R-datascience/master/vignettes/3_RNAseq_workflow/images/RNAseq_workflow.png


## PART1: Quality control of RNAseq reads

# check fastqc arguments by typing this in terminal/git bash:
fastqc -h
## commonly-used arguments:
# `-o` to specify output directory
# `-t` to specify the number of CPUs to run program

# Today, we will run FastQC with the help of a script
## change to scripts directory and create a new script file named run_fastqc.sh
cd ~/RNAseq_workshop/scripts/
nano run_fastqc.sh

###### SCRIPT SHOULD LOOK LIKE BELOW ######
#!/bin/bash

echo "Running FastQC analysis......"

cd ~/RNAseq_workshop/
mkdir ./outputs/FastQC
fastqc ./originals/FASTQ/*.fastq.gz -o ./outputs/FastQC/

echo "Completed......"
##########################################

# To run the script, run this command:
bash run_fastqc.sh

ls -l ~/RNAseq_workshop/outputs/FastQC

## Open the html reports
#mac
open ~/RNAseq_workshop/outputs/FastQC/SRR7311317_1_fastqc.html
open ~/RNAseq_workshop/outputs/FastQC/SRR7311317_2_fastqc.html

# windows
start ~/RNAseq_workshop/outputs/FastQC/SRR7311317_1_fastqc.html
start ~/RNAseq_workshop/outputs/FastQC/SRR7311317_2_fastqc.html

# linux
xdg-open ~/RNAseq_workshop/outputs/FastQC/SRR7311317_1_fastqc.html
xdg-open ~/RNAseq_workshop/outputs/FastQC/SRR7311317_2_fastqc.html


## Example of a bad sequencing experiment
# https://www.bioinformatics.babraham.ac.uk/projects/fastqc/bad_sequence_fastqc.html

## We will need to trim the 5'end of the read to obtain a high-quality set of reads

## TALK ABOUT USING TEXT EDITORS TO EDIT SCRIPTS!!!!!!!!!!
# https://www.sublimetext.com/


#### BREAKKKKKKK ##############################

#### Segway ######
# I have written a script to download ALL fastq files from this ENA repository (https://www.ebi.ac.uk/ena/browser/view/PRJNA476008)
# Have a look at the script to get an idea on how to perform download files automatically
# You can configure the script slightly to suit your needs (e.g., changing the link to TSV file)
# PLEASE MAKE SURE YOU HAVE ENOUGH SPACE ON YOUR COMPTUER TO DOWNLOAD THE DATA!
# run the following command to download this script
cd ~/RNAseq_workshop/scripts
curl -O https://raw.githubusercontent.com/fursham-h/R-datascience/master/vignettes/3_RNAseq_workflow/scripts/run_bulkfastqdownload.sh
################


## PART2: Read trimming

# to see trimmomatic arguments
trimmomatic -h

# link to trimmomatic home-page
# http://www.usadellab.org/cms/?page=trimmomatic

# Download all scripts and files required
curl -O https://raw.githubusercontent.com/fursham-h/R-datascience/master/vignettes/3_RNAseq_workflow/scripts/run_trimmomatic.sh
curl -O https://raw.githubusercontent.com/fursham-h/R-datascience/master/vignettes/3_RNAseq_workflow/scripts/Nextera_TruSeq-PE.fa

cat run_trimmomatic.sh

# Run script
bash run_trimmomatic.sh

# check output directories
ls -l ~/RNAseq_workshop/outputs/trimmed_FASTQ/

#### Exercise #####
# 1. Duplicate the script run_fastqc.sh and rename it
# 2. Amend the script to now perform FastQC on the trimmed FASTQ files found at ~/RNAseq_workshop/outputs/trimmed_FASTQ
# 3. Run the script
##################

# check contents of the new FastQC directory
ls -l ~/RNAseq_workshop/outputs/FastQC_trimmed/

# check quality of trimmed reads
#mac
open ~/RNAseq_workshop/outputs/FastQC_trimmed/SRR7311317_1.trimmed.fastqc_fastqc.html
open ~/RNAseq_workshop/outputs/FastQC_trimmed/SRR7311317_2.trimmed.fastqc_fastqc.html

# windows
start ~/RNAseq_workshop/outputs/FastQC_trimmed/SRR7311317_1.trimmed.fastqc_fastqc.html
start ~/RNAseq_workshop/outputs/FastQC_trimmed/SRR7311317_2.trimmed.fastqc_fastqc.html

# linux
xdg-open ~/RNAseq_workshop/outputs/FastQC_trimmed/SRR7311317_1.trimmed.fastqc_fastqc.html
xdg-open ~/RNAseq_workshop/outputs/FastQC_trimmed/SRR7311317_2.trimmed.fastqc_fastqc.html



## PART3: Read Mapping using Kallisto

## Check out arguments to kallisto
kallisto
kallisto quant --help

# Download all scripts and files required
curl -O https://raw.githubusercontent.com/fursham-h/R-datascience/master/vignettes/3_RNAseq_workflow/scripts/run_kallisto.sh

# check the contents of the script
cat run_kallisto.sh

# Run kallisto mapping and quantitation
bash run_kasllisto.sh

# check out output directory
ls -l ~/RNAseq_workshop/outputs/kallisto

less ~/RNAseq_workshop/outputs/kallisto/abundance.tsv

## End of lesson & Feedback

# What is the one thing you learn from this workshop series?


# What can this workshop improve on in the future?






















