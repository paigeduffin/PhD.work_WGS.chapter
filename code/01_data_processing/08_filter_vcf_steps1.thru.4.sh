#!/bin/bash

#SBATCH --job-name=v3.vcf_v2.gen_filt.steps.1.thru.4
#SBATCH --partition=batch
#SBATCH --ntasks=1
#SBATCH --mem=60gb
#SBATCH --time=24:00:00


################################################################################
# Step 1: characterize VCF file pre-filtering
################################################################################

ml BCFtools/1.13-GCC-8.3.0

bcftools stats v3.vcf_v2.genome.vcf.gz \
    > bcf.stats_v3.vcf_filt.step1.txt


################################################################################
# Step 2: remove indels and pre-wasting California individuals
################################################################################

ml VCFtools/0.1.16-GCC-8.3.0-Perl-5.30.0

# Remove indels and 29 pre-SSW California individuals.
vcftools \
    --gzvcf v3.vcf_v2.genome.vcf.gz \
    --remove pre.wasting_remove.csv \
    --remove-indels \
    --recode \
    --recode-INFO-all \
    --out v3.vcf_rm.pre.CA_no.indels

# Retain indels separately and remove the same 29 pre-SSW California individuals.
vcftools \
    --gzvcf v3.vcf_v2.genome.vcf.gz \
    --remove pre.wasting_remove.csv \
    --keep-only-indels \
    --recode \
    --recode-INFO-all \
    --out v3.vcf_rm.pre.CA_only.indels

# Characterize output files.
ml BCFtools/1.13-GCC-8.3.0

bcftools stats v3.vcf_rm.pre.CA_no.indels.recode.vcf \
    > bcf.stats_v3.vcf_filt.step2.txt

bcftools stats v3.vcf_rm.pre.CA_only.indels.recode.vcf \
    > bcf.stats_v3.vcf_filt.step2.indels.txt

# Compress and index the indel-only file.
bgzip -c v3.vcf_rm.pre.CA_only.indels.recode.vcf \
    > v3.vcf_rm.pre.CA_only.indels.vcf.gz

tabix -p vcf v3.vcf_rm.pre.CA_only.indels.vcf.gz


################################################################################
# Step 3: retain SNPs with at least 80% complete genotype data
################################################################################

ml VCFtools/0.1.16-GCC-8.3.0-Perl-5.30.0

vcftools \
    --vcf v3.vcf_rm.pre.CA_no.indels.recode.vcf \
    --max-missing 0.8 \
    --recode \
    --recode-INFO-all \
    --out v3.vcf_rm.pre.CA_no.indels_80.perc.cmplt

# Characterize output.
ml BCFtools/1.13-GCC-8.3.0

bcftools stats v3.vcf_rm.pre.CA_no.indels_80.perc.cmplt.recode.vcf \
    > bcf.stats_v3.vcf_filt.step3.txt

# Compress and index a copy.
bgzip -c v3.vcf_rm.pre.CA_no.indels_80.perc.cmplt.recode.vcf \
    > v3.vcf_rm.pre.CA_no.indels_80.perc.cmplt.vcf.gz

tabix -p vcf v3.vcf_rm.pre.CA_no.indels_80.perc.cmplt.vcf.gz


################################################################################
# Step 4: retain SNPs with QUAL > 200
################################################################################

ml VCFtools/0.1.16-GCC-8.3.0-Perl-5.30.0

vcftools \
    --vcf v3.vcf_rm.pre.CA_no.indels_80.perc.cmplt.recode.vcf \
    --minQ 200 \
    --recode \
    --recode-INFO-all \
    --out v3.vcf_rm.pre.CA_no.indels_80.perc.cmplt_minQ.200

# Characterize output.
ml BCFtools/1.13-GCC-8.3.0

bcftools stats v3.vcf_rm.pre.CA_no.indels_80.perc.cmplt_minQ.200.recode.vcf \
    > bcf.stats_v3.vcf_filt.step4.txt

# Compress and index for the next filtering stage in R.
bgzip -c v3.vcf_rm.pre.CA_no.indels_80.perc.cmplt_minQ.200.recode.vcf \
    > v3.vcf_rm.pre.CA_no.indels_80.perc.cmplt_minQ.200.vcf.gz

tabix -p vcf v3.vcf_rm.pre.CA_no.indels_80.perc.cmplt_minQ.200.vcf.gz
