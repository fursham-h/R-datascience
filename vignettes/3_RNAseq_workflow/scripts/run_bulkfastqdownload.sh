#!/bin/bash

# Download experiment metadata
## This metadata can be obtained from any ENA project entry for example https://www.ebi.ac.uk/ena/browser/view/PRJNA476008
## You can download the entire table into a .tsv file onto your computer using curl. You would need
## the hyperlink to the table by right-clicking 'TSV', click on 'Copy Link' and pasting the link to the curl command
## as below.
## I have simplified the table slightly by clicking on 'Column Selection' and selecting only 'fastq_ftp'
curl "https://www.ebi.ac.uk/ena/portal/api/filereport?accession=PRJNA476008&result=read_run&fields=fastq_ftp&format=tsv" -o ~/RNAseq_workshop/metadata/fastq_list.txt

# Creating directory to download FASTQ files to
mkdir -p ~/RNAseq_workshop/originals/FASTQ
cd ~/RNAseq_workshop/originals/FASTQ

# a loop to read the file 'fastq_list.txt' and download all files
## Since the file contain a header line, we will need to skip the first line.
## This is handled by tail, which selects all except for the first line
## Then, the while loop wll separate each line by 2 delimteres; a tab (\t) and a (;).
## This is because the column fastq_ftp contain links to both forward and reverse read pairs
## These values are saved to the variables SRA, READ1 and READ2 which can be called out
## as such [$READ1] using curl.
tail -n +2 ~/RNAseq_workshop/metadata/fastq_list.txt | while IFS=$'\t|;' read -r SRA READ1 READ2;do
  curl -O $READ1
  curl -O $READ2
done 
