library(VariantAnnotation)

################################################################################
# Subset A
################################################################################

v3.subA_DP.filt <- readVcf("v3.vcf_subA_post.Sap2.DP.filt.vcf")

# Retain variants with MQ >= 40.
v3.subA_DP.MQ.filt <- v3.subA_DP.filt[
  info(v3.subA_DP.filt)$MQ >= 40
]

# Check retained MQ distribution.
hist(info(v3.subA_DP.MQ.filt)$MQ)

writeVcf(
  obj = v3.subA_DP.MQ.filt,
  filename = "v3.vcf_subA_post.Sap2.DP.MQ.filt.vcf"
)


################################################################################
# Subset B
################################################################################

v3.subB_DP.filt <- readVcf("v3.vcf_subB_post.Sap2.DP.filt.vcf")

v3.subB_DP.MQ.filt <- v3.subB_DP.filt[
  info(v3.subB_DP.filt)$MQ >= 40
]

hist(info(v3.subB_DP.MQ.filt)$MQ)

writeVcf(
  obj = v3.subB_DP.MQ.filt,
  filename = "v3.vcf_subB_post.Sap2.DP.MQ.filt.vcf"
)


################################################################################
# Subset C
################################################################################

v3.subC_DP.filt <- readVcf("v3.vcf_subC_post.Sap2.DP.filt.vcf")

v3.subC_DP.MQ.filt <- v3.subC_DP.filt[
  info(v3.subC_DP.filt)$MQ >= 40
]

hist(info(v3.subC_DP.MQ.filt)$MQ)

writeVcf(
  obj = v3.subC_DP.MQ.filt,
  filename = "v3.vcf_subC_post.Sap2.DP.MQ.filt.vcf"
)


################################################################################
# Subset D
################################################################################

v3.subD_DP.filt <- readVcf("v3.vcf_subD_post.Sap2.DP.filt.vcf")

v3.subD_DP.MQ.filt <- v3.subD_DP.filt[
  info(v3.subD_DP.filt)$MQ >= 40
]

hist(info(v3.subD_DP.MQ.filt)$MQ)

writeVcf(
  obj = v3.subD_DP.MQ.filt,
  filename = "v3.vcf_subD_post.Sap2.DP.MQ.filt.vcf"
)
