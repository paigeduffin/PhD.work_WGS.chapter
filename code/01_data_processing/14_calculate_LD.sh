#!/bin/bash

#SBATCH --job-name=LD_analysis
#SBATCH --partition=batch
#SBATCH --ntasks=2
#SBATCH --mem=1200gb
#SBATCH --time=6-20:00:00

# Calculate genotype linkage disequilibrium for SNP pairs
# separated by up to 50 kb.

ml VCFtools/0.1.16-GCC-8.3.0-Perl-5.30.0

vcftools \
    --gzvcf v3.vcf.merged_post.Sap2.R.Sap2.filt.vcf.gz \
    --geno-r2 \
    --ld-window-bp 50000 \
    --out LD_calc_50k.wind
