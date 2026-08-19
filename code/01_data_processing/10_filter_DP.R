library(VariantAnnotation)

################################################################################
# Subset A
################################################################################

v3.subA_collapsed.vcf <- readVcf("v3.vcf_subset.A_Sap2.filt.vcf.gz")

# Retain variants with DP <= 2500.
v3.subA_DP.filt <- v3.subA_collapsed.vcf[
  info(v3.subA_collapsed.vcf)$DP <= 2500
]

# Retain variants with DP >= 200.
v3.subA_DP.filt <- v3.subA_DP.filt[
  info(v3.subA_DP.filt)$DP >= 200
]

# Check retained DP distribution.
hist(info(v3.subA_DP.filt)$DP)

writeVcf(
  obj = v3.subA_DP.filt,
  filename = "v3.vcf_subA_post.Sap2.DP.filt.vcf"
)


################################################################################
# Subset B
################################################################################

v3.subB_collapsed.vcf <- readVcf("v3.vcf_subset.B_Sap2.filt.vcf.gz")

v3.subB_DP.filt <- v3.subB_collapsed.vcf[
  info(v3.subB_collapsed.vcf)$DP <= 2500
]

v3.subB_DP.filt <- v3.subB_DP.filt[
  info(v3.subB_DP.filt)$DP >= 200
]

hist(info(v3.subB_DP.filt)$DP)

writeVcf(
  obj = v3.subB_DP.filt,
  filename = "v3.vcf_subB_post.Sap2.DP.filt.vcf"
)


################################################################################
# Subset C
################################################################################

v3.subC_collapsed.vcf <- readVcf("v3.vcf_subset.C_Sap2.filt.vcf.gz")

v3.subC_DP.filt <- v3.subC_collapsed.vcf[
  info(v3.subC_collapsed.vcf)$DP <= 2500
]

v3.subC_DP.filt <- v3.subC_DP.filt[
  info(v3.subC_DP.filt)$DP >= 200
]

hist(info(v3.subC_DP.filt)$DP)

writeVcf(
  obj = v3.subC_DP.filt,
  filename = "v3.vcf_subC_post.Sap2.DP.filt.vcf"
)


################################################################################
# Subset D
################################################################################

v3.subD_collapsed.vcf <- readVcf("v3.vcf_subset.D_Sap2.filt.vcf.gz")

v3.subD_DP.filt <- v3.subD_collapsed.vcf[
  info(v3.subD_collapsed.vcf)$DP <= 2500
]

v3.subD_DP.filt <- v3.subD_DP.filt[
  info(v3.subD_DP.filt)$DP >= 200
]

hist(info(v3.subD_DP.filt)$DP)

writeVcf(
  obj = v3.subD_DP.filt,
  filename = "v3.vcf_subD_post.Sap2.DP.filt.vcf"
)
