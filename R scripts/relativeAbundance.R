### to output data to a table
#write.table(rab.MaxBin.rep.class.10pc, file="rAb_MaxBin_class_10pc.tsv", row.names=TRUE, sep = ";")


#Sidebarcolors
library(tidyverse)
library(dplyr)
md <- read.table("md.tsv", sep = "\t", header = TRUE)
w.type_colors <- unlist(lapply(md$Type,function(x){
  if(grepl("inland",x)) '#D1E6C3' #green
  else if(grepl('coastal',x)) '#F69E8D' #red
}))

### Metadata for Vamb 10 pc, as it is missing 1 sample
mdV <- read.table("mdVamb2.tsv", sep = "\t", header = TRUE)
w.typeV_colors <- unlist(lapply(mdV$Type,function(x){
  if(grepl("inland",x)) '#D1E6C3' #green
  else if(grepl('coastal',x)) '#F69E8D' #red
}))


climate_colors <- unlist(lapply(md$Climate,function(x){
  if(grepl("Cwb",x)) '#D1E6C3' #green
  else if(grepl('BWk',x)) '#F69E8D' #red
  else if(grepl('Csc',x)) '#c44517' #orange
  else if(grepl('BWh',x)) '#112e6f' #dark blue
  else if(grepl('BSh',x)) '#f0af93' #beige
  else if(grepl('BSk',x)) '#c0c9d0' #blue gray
  else if(grepl('Cfb',x)) '#81796e' #gray
  else if(grepl('Csa',x)) '#ef25f1' #pink
  else if(grepl('Dsa',x)) '#4b221b' #brown
}))

md2 <- read.table("mdVamb10.tsv", sep = "\t", header = TRUE)
BacArch_colors <- unlist(lapply(md2$classification,function(x){
  if(grepl("Archaea",x)) '#D1E6C3' #green
  else if(grepl('Bacteria',x)) '#F69E8D' #red
}))


clab=cbind(w.type_colors, climate_colors)

library(heatmap3)
library(colorspace)
pdf("---.pdf")
heatmap3(
  col=colorRampPalette(c("white", "#F29100", "#003361"))(1024),
  #xlab = "Samples", ylab = "MAGs", 
  main="", 
  ColSideColors = clab,  ColSideLabs = c("Climate Zone", "Water Type"),
  RowSideColors = BacArch_colors, RowSideLabs = "Domain",
  rab.vamb.rep.10pc, cexRow = 0.8, cexCol = 0.8, scale = "none", margins = c(12,12),
  
)
dev.off()



#MaxBin
### adding data
##### Mag names
tad80.MaxBin.rep <- read.table("tad80_MaxBin_rep.tsv", sep = "\t", header = TRUE, row.names = 1)
geq.hsp <- read.table("genome.eq_hsp.tsv", sep = "\t", header = TRUE, row.names = 1)
rab.MaxBin.rep <- tad80.MaxBin.rep / rep(as.numeric(geq.hsp), each = nrow(tad80.MaxBin.rep))

max.rab.MaxBin.rep <- apply(rab.MaxBin.rep, 1, max)
rab.MaxBin.rep.10pc <- rab.MaxBin.rep[max.rab.MaxBin.rep >= 0.1, ]
rab.MaxBin.rep.10pc <- rab.MaxBin.rep.10pc[,  colSums(rab.MaxBin.rep.10pc) > 0]

#Classification
tad80.MaxBin.rep.class <- read.table("tad80_MaxBin_rep_class.tsv", sep = "\t", header = TRUE, row.names = 1)
rab.MaxBin.rep.class <- tad80.MaxBin.rep.class / rep(as.numeric(geq.hsp), each = nrow(tad80.MaxBin.rep.class))

max.rab.MaxBin.rep.class <- apply(rab.MaxBin.rep.class, 1, max)
rab.MaxBin.rep.class.10pc <- rab.MaxBin.rep.class[max.rab.MaxBin.rep.class >= 0.1, ]
rab.MaxBin.rep.class.10pc <- rab.MaxBin.rep.class.10pc[,  colSums(rab.MaxBin.rep.class.10pc) > 0]

###Heatmap
library(heatmap3)
library(colorspace)
pdf("MaxBin_rep_rAb.pdf")
heatmap3(
  col=colorRampPalette(c("white", "#F29100", "#003361"))(1024),
  #xlab = "Samples", ylab = "MAGs",
  main="MaxBin",
  rab.MaxBin.rep, cexRow = 0.2, cexCol = 0.8, scale = "none", margins = c(12,12),)
heatmap3(
  col=colorRampPalette(c("white", "#F29100", "#003361"))(1024),
  #xlab = "Samples", ylab = "MAGs", 
  main="MaxBin",
  rab.MaxBin.rep.10pc, cexRow = 0.8, cexCol = 0.8, scale = "none", margins = c(12,12),)

heatmap3(
  col=colorRampPalette(c("white", "#F29100", "#003361"))(1024),
  #xlab = "Samples", ylab = "MAGs",
  main="MaxBin",
  rab.MaxBin.rep.class, cexRow = 0.2, cexCol = 0.8, scale = "none", margins = c(12,12),)
heatmap3(
  col=colorRampPalette(c("white", "#F29100", "#003361"))(1024),
  #xlab = "Samples", ylab = "MAGs", 
  main="MaxBin",
  rab.MaxBin.rep.class.10pc, cexRow = 0.8, cexCol = 0.8, scale = "none", margins = c(12,12),)
dev.off()


###Heatmap with Sidebar
library(heatmap3)
library(colorspace)
pdf("MaxBin_rep_rAb_sidebar.pdf")
heatmap3(
  col=colorRampPalette(c("white", "#F29100", "#003361"))(1024),
  #xlab = "Samples", ylab = "MAGs",
  main="MaxBin",
  rab.MaxBin.rep, cexRow = 0.2, cexCol = 0.8, scale = "none", margins = c(12,12),
  ColSideColors = w.type_colors, ColSideLabs = "Water Type"
)

heatmap3(
  col=colorRampPalette(c("white", "#F29100", "#003361"))(1024),
  #xlab = "Samples", ylab = "MAGs", 
  main="MaxBin",
  ColSideColors = w.type_colors, ColSideLabs = "Water Type",
  rab.MaxBin.rep.10pc, cexRow = 0.8, cexCol = 0.8, scale = "none", margins = c(12,12),
)

heatmap3(
  col=colorRampPalette(c("white", "#F29100", "#003361"))(1024),
  #xlab = "Samples", ylab = "MAGs",
  main="MaxBin",
  ColSideColors = w.type_colors, ColSideLabs = "Water Type",
  rab.MaxBin.rep.class, cexRow = 0.2, cexCol = 0.8, scale = "none", margins = c(12,12),)
heatmap3(
  col=colorRampPalette(c("white", "#F29100", "#003361"))(1024),
  #xlab = "Samples", ylab = "MAGs", 
  main="MaxBin",
  ColSideColors = w.type_colors, ColSideLabs = "Water Type",
  rab.MaxBin.rep.class.10pc, cexRow = 0.8, cexCol = 0.8, scale = "none", margins = c(12,12),)
dev.off()

#######################################################################


#Vamb
### adding data
##### Mag names
tad80.vamb.rep <- read.table("tad80_vamb_rep.tsv", sep = "\t", header = TRUE, row.names = 1)
geq.hsp <- read.table("genome.eq_hsp.tsv", sep = "\t", header = TRUE, row.names = 1)
rab.vamb.rep <- tad80.vamb.rep / rep(as.numeric(geq.hsp), each = nrow(tad80.vamb.rep))

max.rab.vamb.rep <- apply(rab.vamb.rep, 1, max)
rab.vamb.rep.10pc <- rab.vamb.rep[max.rab.vamb.rep >= 0.1, ]
rab.vamb.rep.10pc <- rab.vamb.rep.10pc[,  colSums(rab.vamb.rep.10pc) > 0]

tad80.vamb.rep.class <- read.table("tad80_vamb_rep_class.tsv", sep = "\t", header = TRUE, row.names = 1)
rab.vamb.rep.class <- tad80.vamb.rep.class / rep(as.numeric(geq.hsp), each = nrow(tad80.vamb.rep.class))

max.rab.vamb.rep.class <- apply(rab.vamb.rep.class, 1, max)
rab.vamb.rep.class.10pc <- rab.vamb.rep.class[max.rab.vamb.rep.class >= 0.1, ]
rab.vamb.rep.class.10pc <- rab.vamb.rep.class.10pc[,  colSums(rab.vamb.rep.class.10pc) > 0]

###Heatmap
library(heatmap3)
pdf("vamb_rAb.pdf")
heatmap3(
  col=colorRampPalette(c("white", "#F29100", "#003361"))(1024),
  #xlab = "Samples", ylab = "MAGs",
  main="Vamb",
  rab.vamb.rep, cexRow = 0.2, scale = "none", margins = c(10,10))
heatmap3(
  col=colorRampPalette(c("white", "#F29100", "#003361"))(1024),
  #xlab = "Samples", ylab = "MAGs", 
  main="Vamb",
  rab.vamb.rep.10pc, scale = "none", margins = c(10,10))

heatmap3(
  col=colorRampPalette(c("white", "#F29100", "#003361"))(1024),
  #xlab = "Samples", ylab = "MAGs",
  main="Vamb",
  rab.vamb.rep.class, cexRow = 0.2, scale = "none", margins = c(10,10))
heatmap3(
  col=colorRampPalette(c("white", "#F29100", "#003361"))(1024),
  #xlab = "Samples", ylab = "MAGs", 
  main="Vamb",
  rab.vamb.rep.class.10pc, scale = "none", margins = c(10,10))
dev.off()


###Heatmap with sidebar
library(heatmap3)
pdf("vamb_rAb_sidebar.pdf")
heatmap3(
  col=colorRampPalette(c("white", "#F29100", "#003361"))(1024),
  #xlab = "Samples", ylab = "MAGs",
  main="Relative Abundance for Vamb",
  rab.vamb.rep, cexRow = 0.2, scale = "none", margins = c(10,10),
  ColSideColors = w.type_colors, ColSideLabs = "Water Type")
heatmap3(
  col=colorRampPalette(c("white", "#F29100", "#003361"))(1024),
  #xlab = "Samples", ylab = "MAGs", 
  main="Relative Abundance for Vamb",
  rab.vamb.rep.10pc, scale = "none", margins = c(10,10),
  ColSideColors = w.typeV_colors, ColSideLabs = "Water Type")

heatmap3(
  col=colorRampPalette(c("white", "#F29100", "#003361"))(1024),
  #xlab = "Samples", ylab = "MAGs",
  main="Relative Abundance for Vamb",
  rab.vamb.rep.class, cexRow = 0.2, scale = "none", margins = c(10,10),
  ColSideColors = w.type_colors, ColSideLabs = "Water Type")
heatmap3(
  col=colorRampPalette(c("white", "#F29100", "#003361"))(1024),
  #xlab = "Samples", ylab = "MAGs", 
  main="Relative Abundance for Vamb",
  rab.vamb.rep.class.10pc, scale = "none", margins = c(10,10),
  ColSideColors = w.typeV_colors, ColSideLabs = "Water Type")
dev.off()
#######################################################################


#Combined
### adding data
##### Mag names
tad80.combined.rep <- read.table("tad80_combined_rep.tsv", sep = "\t", header = TRUE, row.names = 1)
geq.hsp <- read.table("genome.eq_hsp.tsv", sep = "\t", header = TRUE, row.names = 1)
rab.combined.rep <- tad80.combined.rep / rep(as.numeric(geq.hsp), each = nrow(tad80.combined.rep))

max.rab.combined.rep <- apply(rab.combined.rep, 1, max)
rab.combined.rep.10pc <- rab.combined.rep[max.rab.combined.rep >= 0.1, ]
rab.combined.rep.10pc <- rab.combined.rep.10pc[,  colSums(rab.combined.rep.10pc) > 0]

tad80.combined.rep.class <- read.table("tad80_combined_rep_class.tsv", sep = "\t", header = TRUE, row.names = 1)
rab.combined.rep.class <- tad80.combined.rep.class / rep(as.numeric(geq.hsp), each = nrow(tad80.combined.rep.class))

max.rab.combined.rep.class <- apply(rab.combined.rep.class, 1, max)
rab.combined.rep.class.10pc <- rab.combined.rep.class[max.rab.combined.rep.class >= 0.1, ]
rab.combined.rep.class.10pc <- rab.combined.rep.class.10pc[,  colSums(rab.combined.rep.class.10pc) > 0]

###Heatmap
library(heatmap3)
pdf("combined_rAb.pdf")
heatmap3(
  col=colorRampPalette(c("white", "#F29100", "#003361"))(1024),
  #xlab = "Samples", ylab = "MAGs",
  main="Combination",
  rab.combined.rep, cexRow = 0.2, scale = "none", margins = c(10,10))
heatmap3(
  col=colorRampPalette(c("white", "#F29100", "#003361"))(1024),
  #xlab = "Samples", ylab = "MAGs", 
  main="Combination",
  rab.combined.rep.10pc, cexRow = 0.8, scale = "none", margins = c(10,10))

heatmap3(
  col=colorRampPalette(c("white", "#F29100", "#003361"))(1024),
  #xlab = "Samples", ylab = "MAGs",
  main="Combination",
  rab.combined.rep.class, cexRow = 0.2, scale = "none", margins = c(10,10))
heatmap3(
  col=colorRampPalette(c("white", "#F29100", "#003361"))(1024),
  #xlab = "Samples", ylab = "MAGs", 
  main="Combination",
  rab.combined.rep.class.10pc, scale = "none", margins = c(10,10))
dev.off()

###Heatmap mit Sidebar
library(heatmap3)
pdf("combined_rAb_sidebar.pdf")
heatmap3(
  col=colorRampPalette(c("white", "#F29100", "#003361"))(1024),
  #xlab = "Samples", ylab = "MAGs",
  main="Relative Abundance for Combination",
  rab.combined.rep, cexRow = 0.2, scale = "none", margins = c(10,10),
  ColSideColors = w.type_colors, ColSideLabs = "Water Type")
heatmap3(
  col=colorRampPalette(c("white", "#F29100", "#003361"))(1024),
  #xlab = "Samples", ylab = "MAGs", 
  main="Relative Abundance for Combination",
  rab.combined.rep.10pc, cexRow = 0.8, scale = "none", margins = c(10,10),
  ColSideColors = w.type_colors, ColSideLabs = "Water Type")

heatmap3(
  col=colorRampPalette(c("white", "#F29100", "#003361"))(1024),
  #xlab = "Samples", ylab = "MAGs",
  main="Relative Abundance for Combination",
  rab.combined.rep.class, cexRow = 0.2, scale = "none", margins = c(10,10),
  ColSideColors = w.type_colors, ColSideLabs = "Water Type")
heatmap3(
  col=colorRampPalette(c("white", "#F29100", "#003361"))(1024),
  #xlab = "Samples", ylab = "MAGs", 
  main="Relative Abundance for Combination",
  rab.combined.rep.class.10pc, scale = "none", margins = c(10,10),
  ColSideColors = w.type_colors, ColSideLabs = "Water Type")
dev.off()


#######################################################################

#ERS

library(heatmap3)
tad80.ers <- read.table("tad80_ers_rep.tsv", sep = "\t", header = TRUE, row.names = 1)
geq.ers <- read.table("genome.eq_ers.tsv", sep = "\t", header = TRUE, row.names = 1)
tad80.ers.0 <- tad80.ers[, colSums(tad80.ers) > 0]
rab.ers <- tad80.ers.0 / rep(as.numeric(geq.ers), each = nrow(tad80.ers.0))

max.rab.ers <- apply(rab.ers, 1, max)
rab.ers.0 <- rab.ers[rowSums(rab.ers) > 0, ]
#rab.ers.0 <- rab.ers[, which(colSums(rab.ers) > 0)]
#rab.ers.0 <- rab.ers[which(rowSums(rab.ers) > 0), which(colSums(rab.ers) > 0)]
rab.ers.10pc <- rab.ers.0[max.rab.ers >= 0.1, ]
#rab.ers.10pc <- rab.ers.10pc[, which(colSums(rab.ers.10pc) > 0)]

pdf("ers_rep_relative-abundance.pdf")
heatmap3(
  col=colorRampPalette(c("white", "#F29100", "#003361"))(1024),
  #xlab = "Samples", ylab = "MAGs", 
  main="Relative Abundance for MaxBin",
  rab.ers.0, cexRow = 1, cexCol = 0.8, scale = "none")
#heatmap3(rab.ers.10pc, scale = "none") #Error in heatmap3: must have at least 2 rows and 2 columns

dev.off()
