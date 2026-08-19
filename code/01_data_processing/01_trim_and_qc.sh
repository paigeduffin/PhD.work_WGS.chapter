#!/bin/bash

# Rename paired-end raw reads in preparation for trimming.

for sample in *_R1_001.fastq.gz; do
    r1=$sample
    r2=${sample/_R1_001.fastq.gz/}_A.fastq.gz
    mv $r1 $r2
done

for sample in *_R2_001.fastq.gz; do
    r1=$sample
    r2=${sample/_R2_001.fastq.gz/}_B.fastq.gz
    mv $r1 $r2
done

# Remove characters following the first underscore from sample names.

for x in *_A.fastq.gz; do
    name=$(echo $x | cut -d'_' -f 1)
    mv $x ${name}_A.fastq.gz
done

for x in *_B.fastq.gz; do
    name=$(echo $x | cut -d'_' -f 1)
    mv $x ${name}_B.fastq.gz
done

# Generate one Trim Galore SLURM script per sample.

for x in *_A.fastq.gz; do
    name=$(echo $x | cut -d'_' -f 1)

    echo "#!/bin/bash" > ${name}_TrimGalore_P.ochra.v2_mapping.sh
    echo "#SBATCH --job-name=TrimGalore_P.ochra.v2_mapping_serial" >> ${name}_TrimGalore_P.ochra.v2_mapping.sh
    echo "#SBATCH --partition=batch" >> ${name}_TrimGalore_P.ochra.v2_mapping.sh
    echo "#SBATCH --ntasks=8" >> ${name}_TrimGalore_P.ochra.v2_mapping.sh
    echo "#SBATCH --mem=10gb" >> ${name}_TrimGalore_P.ochra.v2_mapping.sh
    echo "#SBATCH --time=80:00:00" >> ${name}_TrimGalore_P.ochra.v2_mapping.sh
    echo "ml Trim_Galore/0.6.5-GCCcore-8.3.0-Java-11-Python-3.7.4" >> ${name}_TrimGalore_P.ochra.v2_mapping.sh
    echo "trim_galore --paired ${name}_A.fastq.gz ${name}_B.fastq.gz" >> ${name}_TrimGalore_P.ochra.v2_mapping.sh
done

# Submit generated trimming scripts.

for x in *_TrimGalore_P.ochra.v2_mapping.sh; do
    sbatch ${x}
done

# Generate FastQC reports for trimmed reads.

ml parallel/20190922-GCCcore-8.3.0
ml FastQC/0.11.9-Java-11

find *.fq.gz | parallel "fastqc {}"
