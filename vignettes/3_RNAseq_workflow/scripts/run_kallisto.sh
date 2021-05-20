#!/bin/bash

echo "Running Kallisto quantitation......."
cd ~/RNAseq_workshop
mkdir -p ./outputs/kallisto

kallisto quant \
    -i ./originals/transcriptome.idx \
    -o ./outputs/kallisto \
    --rf-stranded \
    ./outputs/trimmed_FASTQ/SRR7311317_1.trimmed.fastqc.gz \
    ./outputs/trimmed_FASTQ/SRR7311317_2.trimmed.fastqc.gz
    
echo "Completed......."