#!/bin/bash

#SBATCH --job-name=v3.vcf_filt.2nd.rnd
#SBATCH --partition=batch
#SBATCH --ntasks=1
#SBATCH --mem=60gb
#SBATCH --time=24:00:00

################################################################################
# Apply second-pass missing-data and MAF filters to subsets A-D
################################################################################

for subset in A B C D; do

    ############################################################################
    # Step 7: retain SNPs with at least 90% complete genotype data
    ############################################################################

    ml VCFtools/0.1.16-GCC-8.3.0-Perl-5.30.0

    vcftools \
        --gzvcf v3.vcf_sub${subset}_post.Sap2.DP.MQ.filt.vcf.gz \
        --max-missing 0.9 \
        --recode \
        --recode-INFO-all \
        --out v3.vcf_sub${subset}_post.Sap2.R.filt_0.9.complete

    # Characterize output.
    ml BCFtools/1.13-GCC-8.3.0

    bcftools stats \
        v3.vcf_sub${subset}_post.Sap2.R.filt_0.9.complete.recode.vcf \
        > Sap2.pt2_bcf.stats_v3.vcf_sub${subset}_filt.step7.txt


    ############################################################################
    # Step 8: retain SNPs with MAF >= 0.05
    ############################################################################

    ml VCFtools/0.1.16-GCC-8.3.0-Perl-5.30.0

    vcftools \
        --vcf v3.vcf_sub${subset}_post.Sap2.R.filt_0.9.complete.recode.vcf \
        --maf 0.05 \
        --recode \
        --recode-INFO-all \
        --out v3.vcf_sub${subset}_post.Sap2.R.filt_0.9.complete_MAF.0.05

    # Characterize output.
    ml BCFtools/1.13-GCC-8.3.0

    bcftools stats \
        v3.vcf_sub${subset}_post.Sap2.R.filt_0.9.complete_MAF.0.05.recode.vcf \
        > Sap2.pt2_bcf.stats_v3.vcf_sub${subset}_filt.step8.txt

done
