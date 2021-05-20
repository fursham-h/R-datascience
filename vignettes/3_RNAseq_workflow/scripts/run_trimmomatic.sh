#!/bin/bash


echo "Running Trimmomatic trimming of reads......"

cd ~/RNAseq_workshop
mkdir -p ~/RNAseq_workshop/outputs/trimmed_FASTQ

trimmomatic PE \
    ./originals/FASTQ/SRR7311317_1.fastq.gz ./originals/FASTQ/SRR7311317_2.fastq.gz \
    ./outputs/trimmed_FASTQ/SRR7311317_1.fastqc.gz ./outputs/trimmed_FASTQ/SRR7311317_1.unpaired.fastqc.gz \
    ./outputs/trimmed_FASTQ/SRR7311317_2.fastqc.gz ./outputs/trimmed_FASTQ/SRR7311317_2.unpaired.fastqc.gz \
    ILLUMINACLIP:./scripts/Nextera_TruSeq-PE.fa:2:30:10:2:keepBothReads MINLEN:40

echo "Completed....."