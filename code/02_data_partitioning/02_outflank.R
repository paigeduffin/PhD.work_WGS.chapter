library(dartR)
library(dplyr)

################################################################################
# OutFLANK analyses using two alternative population groupings
################################################################################

# Load genlight object
load("v3.post.SNP.filt_genlte.RData")


################################################################################
# 1. PCA post hoc populations (K = 4)
################################################################################

pop_table <- read.table(
  "PCA.posthoc_pops.K4.txt",
  header = FALSE,
  sep = "\t",
  stringsAsFactors = TRUE
)

v3.genlte_PCA <- v3.genlte
v3.genlte_PCA@pop <- pop_table$V2

outflank_PCA <- gl.outflank(
  v3.genlte_PCA,
  plot = TRUE
)

save(
  outflank_PCA,
  file = "v3.genlte_outflank_PCA.posthoc.pops.RData"
)

outliers_PCA <- outflank_PCA$outflank$results %>%
  filter(OutlierFlag == TRUE)

write.csv(
  outliers_PCA,
  "v3_Sap2.outflank_PCA.posthoc.pops_outlier.TRUE.csv",
  row.names = FALSE
)


################################################################################
# 2. Original sampling-location populations
################################################################################

pop_table <- read.table(
  "broad_location_pops_rm.pre.CA.txt",
  header = FALSE,
  sep = "\t",
  stringsAsFactors = TRUE
)

v3.genlte_location <- v3.genlte
v3.genlte_location@pop <- pop_table$V2

outflank_location <- gl.outflank(
  v3.genlte_location,
  plot = TRUE
)

save(
  outflank_location,
  file = "v3.genlte_outflank_sample.loc.pops.RData"
)

outliers_location <- outflank_location$outflank$results %>%
  filter(OutlierFlag == TRUE)

write.csv(
  outliers_location,
  "v3_Sap2.outflank_sample.loc.pops_outlier.TRUE.csv",
  row.names = FALSE
)
