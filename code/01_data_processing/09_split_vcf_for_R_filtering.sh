#!/bin/bash

# Split the filtered VCF into four subsets for local R-based DP and MQ filtering.
# The full VCF could not be processed locally in R due to memory limitations.

################################################################################
# Inspect file and determine line count
################################################################################

head -200 v3.vcf_rm.pre.CA_no.indels_80.perc.cmplt_minQ.200.vcf

wc -l v3.vcf_rm.pre.CA_no.indels_80.perc.cmplt_minQ.200.vcf

# Total lines: 20,689,851
# Header lines: 150
# Variant lines: 20,689,701


################################################################################
# Separate VCF header from variant records
################################################################################

sed -n '1,150p' \
    v3.vcf_rm.pre.CA_no.indels_80.perc.cmplt_minQ.200.vcf \
    > v3.vcf_Sap2.filt_just.header.vcf

sed -n '151,20689851p' \
    v3.vcf_rm.pre.CA_no.indels_80.perc.cmplt_minQ.200.vcf \
    > v3.vcf_Sap2.filt_minus.header.vcf

wc -l v3.vcf_Sap2.filt_minus.header.vcf


################################################################################
# Split variant records into four subsets
################################################################################

# subset.A: 1-5,172,427
# subset.B: 5,172,428-10,344,853
# subset.C: 10,344,854-15,517,280
# subset.D: 15,517,281-20,689,701

sed -n '1,5172427p' \
    v3.vcf_Sap2.filt_minus.header.vcf \
    > v3.vcf_subset.A_Sap2.filt_minus.header.vcf

sed -n '5172428,10344853p' \
    v3.vcf_Sap2.filt_minus.header.vcf \
    > v3.vcf_subset.B_Sap2.filt_minus.header.vcf

sed -n '10344854,15517280p' \
    v3.vcf_Sap2.filt_minus.header.vcf \
    > v3.vcf_subset.C_Sap2.filt_minus.header.vcf

sed -n '15517281,20689701p' \
    v3.vcf_Sap2.filt_minus.header.vcf \
    > v3.vcf_subset.D_Sap2.filt_minus.header.vcf


################################################################################
# Restore the VCF header to each subset
################################################################################

cat v3.vcf_Sap2.filt_just.header.vcf \
    v3.vcf_subset.A_Sap2.filt_minus.header.vcf \
    > v3.vcf_subset.A_Sap2.filt.vcf

cat v3.vcf_Sap2.filt_just.header.vcf \
    v3.vcf_subset.B_Sap2.filt_minus.header.vcf \
    > v3.vcf_subset.B_Sap2.filt.vcf

cat v3.vcf_Sap2.filt_just.header.vcf \
    v3.vcf_subset.C_Sap2.filt_minus.header.vcf \
    > v3.vcf_subset.C_Sap2.filt.vcf

cat v3.vcf_Sap2.filt_just.header.vcf \
    v3.vcf_subset.D_Sap2.filt_minus.header.vcf \
    > v3.vcf_subset.D_Sap2.filt.vcf


################################################################################
# Compress and index each subset
################################################################################

bgzip -c v3.vcf_subset.A_Sap2.filt.vcf \
    > v3.vcf_subset.A_Sap2.filt.vcf.gz

bgzip -c v3.vcf_subset.B_Sap2.filt.vcf \
    > v3.vcf_subset.B_Sap2.filt.vcf.gz

bgzip -c v3.vcf_subset.C_Sap2.filt.vcf \
    > v3.vcf_subset.C_Sap2.filt.vcf.gz

bgzip -c v3.vcf_subset.D_Sap2.filt.vcf \
    > v3.vcf_subset.D_Sap2.filt.vcf.gz

tabix -p vcf v3.vcf_subset.A_Sap2.filt.vcf.gz
tabix -p vcf v3.vcf_subset.B_Sap2.filt.vcf.gz
tabix -p vcf v3.vcf_subset.C_Sap2.filt.vcf.gz
tabix -p vcf v3.vcf_subset.D_Sap2.filt.vcf.gz
