library(dplyr)

################################################################################
# Summarize linkage disequilibrium in 10-bp distance bins
# for the 22 main chromosomes
################################################################################

LD_by_chromosome <- vector("list", 22)

for (chromo in 1:22) {

  # Read LD comparisons
  LD_data <- read.table(
    paste0("LD_chromo", chromo, "_data.for.plot.txt"),
    sep = "\t",
    header = TRUE
  )

  # Calculate distance between SNP pairs
  LD_data$dist <- LD_data$POS2 - LD_data$POS1
  LD_data$dist2 <- LD_data$dist

  # Average LD values within 10-bp distance bins
  LD_summary <- LD_data %>%
    group_by(
      dist = cut(dist, seq(0, 50000, 10))
    ) %>%
    summarise_all(mean)

  LD_summary$chromo.no <- paste0("chromo", chromo)

  LD_by_chromosome[[chromo]] <- LD_summary
}

# Combine summaries across chromosomes
LD_chromo.1.to.22_sum.10bp.bins <- bind_rows(LD_by_chromosome)

# Save summarized data
write.table(
  LD_chromo.1.to.22_sum.10bp.bins,
  file = "LD_chromo.1.to.22_sum.10bp.bins.txt",
  sep = "\t",
  quote = FALSE,
  row.names = FALSE
)
