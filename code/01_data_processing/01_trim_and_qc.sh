#!/bin/bash

# Trim paired-end sequencing reads and generate FastQC reports.
# Input reads are expected to be named *_A.fastq.gz and *_B.fastq.gz.

# Trim paired-end reads
ml Trim_Galore/0.6.5-GCCcore-8.3.0-Java-11-Python-3.7.4

for sample in *_A.fastq.gz; do
    r1=$sample
    r2=${sample/_A.fastq.gz/}_B.fastq.gz
    trim_galore --paired $r1 $r2
done

# Generate FastQC reports
ml parallel/20190922-GCCcore-8.3.0
ml FastQC/0.11.9-Java-11

find *.fq.gz | parallel "fastqc {}"
