#!/bin/bash

################################################################################
# Recombine filtered VCF subsets A-D
################################################################################

# Create header-only file.
# First SNP/data line is line 149, so header ends at line 148.

sed -n '1,148p' \
    v3.vcf_subA_post.Sap2.R.filt_0.9.complete_MAF.0.05.vcf \
    > v3.vcf_post.Sap2.R.Sap2.filt_just.header.vcf


################################################################################
# Remove headers from subsets A-D
################################################################################

# Subset A
sed -n '149,2869236p' \
    v3.vcf_subA_post.Sap2.R.filt_0.9.complete_MAF.0.05.vcf \
    > v3.vcf_subA_post.Sap2.R.Sap2.filt_minus.header.vcf

# Subset B
sed -n '149,2965573p' \
    v3.vcf_subB_post.Sap2.R.filt_0.9.complete_MAF.0.05.vcf \
    > v3.vcf_subB_post.Sap2.R.Sap2.filt_minus.header.vcf

# Subset C
sed -n '149,2979088p' \
    v3.vcf_subC_post.Sap2.R.filt_0.9.complete_MAF.0.05.vcf \
    > v3.vcf_subC_post.Sap2.R.Sap2.filt_minus.header.vcf

# Subset D
sed -n '149,2888088p' \
    v3.vcf_subD_post.Sap2.R.filt_0.9.complete_MAF.0.05.vcf \
    > v3.vcf_subD_post.Sap2.R.Sap2.filt_minus.header.vcf


################################################################################
# Recombine header and filtered variant records
################################################################################

cat \
    v3.vcf_post.Sap2.R.Sap2.filt_just.header.vcf \
    v3.vcf_subA_post.Sap2.R.Sap2.filt_minus.header.vcf \
    v3.vcf_subB_post.Sap2.R.Sap2.filt_minus.header.vcf \
    v3.vcf_subC_post.Sap2.R.Sap2.filt_minus.header.vcf \
    v3.vcf_subD_post.Sap2.R.Sap2.filt_minus.header.vcf \
    > v3.vcf.merged_post.Sap2.R.Sap2.filt.vcf


################################################################################
# Compress and index merged VCF
################################################################################

bgzip -c v3.vcf.merged_post.Sap2.R.Sap2.filt.vcf \
    > v3.vcf.merged_post.Sap2.R.Sap2.filt.vcf.gz

tabix -p vcf v3.vcf.merged_post.Sap2.R.Sap2.filt.vcf.gz
