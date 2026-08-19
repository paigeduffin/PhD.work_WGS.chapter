#!/bin/bash

#SBATCH --job-name=v3.vcf_v2.genome_variant.calling
#SBATCH --partition=highmem_30d_p
#SBATCH --ntasks=1
#SBATCH --mem=400G
#SBATCH --time=20-20:00:00

# Call variants jointly across BAM files using the
# Pisaster ochraceus v2 reference genome.

ml BCFtools/1.15.1-GCC-10.2.0

bcftools mpileup -Ou \
    -f pisaster.ochraceus_v2_06.07.2022_final.assembly.fna \
    --bam-list bam.files_list.txt | \
    bcftools call -mv -Oz -o v3.vcf_v2.genome.vcf.gz


# Index the compressed VCF.

tabix -p vcf v3.vcf_v2.genome.vcf.gz


# Generate a consensus sequence.

bcftools consensus \
    -f pisaster.ochraceus_v2_06.07.2022_final.assembly.fna \
    v3.vcf_v2.genome.vcf.gz \
    > consensus_v3.vcf_v2.genome.fa


# Generate basic VCF statistics.

gunzip v3.vcf_v2.genome.vcf.gz

ml VCFtools/0.1.16-GCC-8.3.0-Perl-5.30.0

vcf-stats v3.vcf_v2.genome.vcf > v3.vcf_v2.genome.vcf_stats.file.txt
