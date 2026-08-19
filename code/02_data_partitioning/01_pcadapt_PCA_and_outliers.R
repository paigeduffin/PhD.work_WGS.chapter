library(pcadapt)
library(qvalue)

################################################################################
# PCAdapt PCA and outlier detection
################################################################################

# Load PLINK bed file
pcadapt_file <- read.pcadapt(
  "v3.vcf_qual.filt_pre.HoFis.rm_bed.bed",
  type = "bed"
)

# Population labels used for PCA visualization
pop_table <- read.table(
  "pop.IDs.txt",
  header = FALSE
)$V1


################################################################################
# Exploratory PCA
################################################################################

pcadapt_results <- pcadapt(
  input = pcadapt_file,
  K = 20
)

pdf("PCAdapt_PCA_exploratory.pdf")

plot(
  pcadapt_results,
  option = "screeplot"
)

plot(
  pcadapt_results,
  option = "scores",
  pop = pop_table
)

dev.off()


################################################################################
# PCA using first two principal components
################################################################################

pcadapt_results_PC1.PC2 <- pcadapt(
  input = pcadapt_file,
  K = 2
)

pdf("PCAdapt_PCA_K2_diagnostics.pdf")

plot(
  pcadapt_results_PC1.PC2,
  option = "manhattan"
)

plot(
  pcadapt_results_PC1.PC2,
  option = "qqplot"
)

hist(
  pcadapt_results_PC1.PC2$pvalues,
  xlab = "p-values",
  main = NULL,
  breaks = 50
)

plot(
  pcadapt_results_PC1.PC2,
  option = "stat.distribution"
)

dev.off()


################################################################################
# Identify PCAdapt outliers
################################################################################

qval <- qvalue(
  pcadapt_results_PC1.PC2$pvalues
)$qvalues

alpha <- 0.1

outliers <- which(qval < alpha)

write.csv(
  outliers,
  "PCAdapt_outlier_list.csv",
  row.names = FALSE
)
