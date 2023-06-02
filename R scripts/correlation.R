### adding data
tad80.MaxBin.rep <- read.table("tad80_MaxBin_rep.tsv", sep = "\t", header = TRUE, row.names = 1)
geq.hsp <- read.table("genome.eq_hsp.tsv", sep = "\t", header = TRUE, row.names = 1)
rab.MaxBin.rep <- tad80.MaxBin.rep / rep(as.numeric(geq.hsp), each = nrow(tad80.MaxBin.rep))

# Loading Metadata
md <- read.table("Metadata.tsv", sep = "\t", header = T, row.names = 1)

# Make sure the metadata columns are in the same order as the relative abundance
md <- md[colnames(rab.MaxBin.rep), ]

# Prepare an empty data frame of genomospecies per variable
padj <- data.frame(TMP = rep(NA, nrow(rab.MaxBin.rep)))
rownames(padj) <- rownames(rab.MaxBin.rep)

# Calculate correlations per variable
for (var in colnames(md)) {
  pval <- c()
  
  # Calculate correlations per genomospecies
  for (gsp in rownames(rab.MaxBin.rep)) {
    # Use non-parametric rank correlation test (Spearman)
    testMaxBin <- cor.test(
      md[, var], as.numeric(rab.MaxBin.rep[gsp, ]), method = "spearman", exact = FALSE
    )
    pval <- c(pval, testMaxBin$p.value)
  }
  
  # Control for multiple testing
  padj[, var] <- p.adjust(pval, method = "BH")
}

padj[, "TMP"] <- NULL # Clean placeholder column

# Plot the abundances highlighting those with significant correlation
pdf("cor-plots_MaxBin.pdf")
for (var in colnames(md)) {
  plot(
    NULL, xlim = range(md[, var]) * c(1, 1.1), ylim = range(rab.MaxBin.rep) + 1e-6, log = "y",
    xlab = var, ylab = "Relative abundance"
  )
  for (gsp in rownames(rab.MaxBin.rep)) {
    x <- sort(md[, var])
    y <- as.numeric(rab.MaxBin.rep[gsp, order(md[, var])])
    col <- rgb(0, 0, 0, 0.1)
    if (padj[gsp, var] < 0.05) {
      col <- "black"
      text(tail(x, n = 1), tail(y, n = 1), gsp, pos = 4, cex = 1/3)
    }
    lines(x, y, col = col)
  }
}
dev.off()