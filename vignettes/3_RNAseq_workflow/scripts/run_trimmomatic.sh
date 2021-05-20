#!/bin/bash


echo "Running Trimmomatic trimming of reads......"

cd ~/RNAseq_workshop
mkdir -p ~/RNAseq_workshop/outputs/trimmed_FASTQ

trimmomatic PE \
    ./originals/FASTQ/SRR7311317_1.fastq.gz ./originals/FASTQ/SRR7311317_2.fastq.gz \
    ./outputs/trimmed_FASTQ/SRR7311317_1.trimmed.fastq.gz ./outputs/trimmed_FASTQ/SRR7311317_1.unpaired.fastq.gz \
    ./outputs/trimmed_FASTQ/SRR7311317_2.trimmed.fastq.gz ./outputs/trimmed_FASTQ/SRR7311317_2.unpaired.fastq.gz \
    ILLUMINACLIP:./scripts/Nextera_TruSeq-PE.fa:2:40:15 SLIDINGWINDOW:4:20 HEADCROP:7 MINLEN:35

echo "Completed....."
