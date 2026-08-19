#!/bin/bash

#SBATCH --job-name=build_neutral_panel
#SBATCH --partition=batch
#SBATCH --ntasks=2
#SBATCH --mem=120gb
#SBATCH --time=24:00:00

################################################################################
# Build neutral SNP panel
#
# Starting VCF has PCAdapt outliers already removed.
# OutFLANK outlier lists are formatted as tab-delimited CHROM/POS files.
################################################################################

ml VCFtools/0.1.16-GCC-8.3.0-Perl-5.30.0


################################################################################
# Remove OutFLANK outliers: PCA post hoc populations
################################################################################

vcftools \
    --gzvcf v3.vcf_RM.PCAdapt.0.1.outliers.vcf.gz \
    --exclude-positions v3_outflank_PCA.psthc.pops_outliers_formatted.txt \
    --recode \
    --recode-INFO-all \
    --out v3.vcf_RM.PCAdapt.0.1_Outflank_PCA.psthc.pop_outliers

bgzip -c \
    v3.vcf_RM.PCAdapt.0.1_Outflank_PCA.psthc.pop_outliers.recode.vcf \
    > v3.vcf_RM.PCAdapt.0.1_Outflank_PCA.psthc.pop_outliers.vcf.gz

tabix -p vcf \
    v3.vcf_RM.PCAdapt.0.1_Outflank_PCA.psthc.pop_outliers.vcf.gz


################################################################################
# Remove OutFLANK outliers: sampling-location populations
################################################################################

vcftools \
    --gzvcf v3.vcf_RM.PCAdapt.0.1_Outflank_PCA.psthc.pop_outliers.vcf.gz \
    --exclude-positions v3_outflank_sample.loc.pops_outliers_formatted.txt \
    --recode \
    --recode-INFO-all \
    --out v3.vcf_RM.PCAdapt.0.1_Outflank_PCA.psthc.pop_sample.loc.pop_outliers

bgzip -c \
    v3.vcf_RM.PCAdapt.0.1_Outflank_PCA.psthc.pop_sample.loc.pop_outliers.recode.vcf \
    > v3.vcf_RM.PCAdapt.0.1_Outflank_PCA.psthc.pop_sample.loc.pop_outliers.vcf.gz

tabix -p vcf \
    v3.vcf_RM.PCAdapt.0.1_Outflank_PCA.psthc.pop_sample.loc.pop_outliers.vcf.gz


################################################################################
# Thin SNPs to a minimum spacing of 1,500 bp
################################################################################

vcftools \
    --gzvcf v3.vcf_RM.PCAdapt.0.1_Outflank_PCA.psthc.pop_sample.loc.pop_outliers.vcf.gz \
    --thin 1500 \
    --recode \
    --recode-INFO-all \
    --out neutral.panel_thinned

bgzip -c \
    neutral.panel_thinned.recode.vcf \
    > neutral.panel_thinned.vcf.gz

tabix -p vcf neutral.panel_thinned.vcf.gz


################################################################################
# Identify SNPs to prune based on linkage disequilibrium
################################################################################

ml PLINK/2.00-alpha2.3-x86_64-20200124

plink2 \
    --vcf neutral.panel_thinned.vcf.gz \
    --indep-pairwise 50 5 0.2 \
    --allow-extra-chr \
    --out neutral.panel_thinned_LD.pruned


################################################################################
# Original workflow:
#
# neutral.panel_thinned_LD.pruned.prune.out was manually reformatted
# as a tab-delimited CHROM/POS file:
#
# neutral.panel_to.prune_formatted.txt
################################################################################

ml VCFtools/0.1.16-GCC-8.3.0-Perl-5.30.0

vcftools \
    --gzvcf neutral.panel_thinned.vcf.gz \
    --exclude-positions neutral.panel_to.prune_formatted.txt \
    --recode \
    --recode-INFO-all \
    --out neutral.panel_thinned_LD.pruned

bgzip -c \
    neutral.panel_thinned_LD.pruned.recode.vcf \
    > neutral.panel_thinned_LD.pruned.vcf.gz

tabix -p vcf neutral.panel_thinned_LD.pruned.vcf.gz
