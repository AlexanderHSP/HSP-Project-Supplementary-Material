### create Venn diagram with defined areas
# load Venn diagram package
library("VennDiagram")

# move to new plotting page
grid.newpage()

# create pairwise Venn diagram
draw.pairwise.venn(area1=177, area2=170,cross.area=110,
                   category = c("Vamb ", "MaxBin"),
                   filename = 'venn.png',
                   output=TRUE,
                   lwd = 2,
                   lty = 'blank',
                   fill = c("#F29100", "#003361"),
                   scaled = TRUE,
                   # Numbers
                   cex = 1.5,
                   fontface = "italic",
                   # Set names
                   cat.cex = 2,
                   cat.fontface = "bold",
                   cat.default.pos = "outer",
                   cat.dist = c(-0.005, -0.005),
                   main = "Domain",
                   main.cex = 2,
                   )



### create Venn diagrams based on data

#Loading Data
library(readxl)
DV <- read_excel("Vamb.xlsx", sheet = "Domain", col_names = FALSE)
DM <- read_excel("MaxBin.xlsx", sheet = "Domain", col_names = FALSE)
DC <- read_excel("Combined.xlsx", sheet = "Domain", col_names = FALSE)

PV <- read_excel("Vamb.xlsx", sheet = "Phylum", col_names = FALSE)
PM <- read_excel("MaxBin.xlsx", sheet = "Phylum", col_names = FALSE)
PC <- read_excel("Combined.xlsx", sheet = "Phylum", col_names = FALSE)

CV <- read_excel("Vamb.xlsx", sheet = "Class", col_names = FALSE)
CM <- read_excel("MaxBin.xlsx", sheet = "Class", col_names = FALSE)
CC <- read_excel("Combined.xlsx", sheet = "Class", col_names = FALSE)

OV <- read_excel("Vamb.xlsx", sheet = "Order", col_names = FALSE)
OM <- read_excel("MaxBin.xlsx", sheet = "Order", col_names = FALSE)
OC <- read_excel("Combined.xlsx", sheet = "Order", col_names = FALSE)

FV <- read_excel("Vamb.xlsx", sheet = "Family", col_names = FALSE)
FM <- read_excel("MaxBin.xlsx", sheet = "Family", col_names = FALSE)
FC <- read_excel("Combined.xlsx", sheet = "Family", col_names = FALSE)

GV <- read_excel("Vamb.xlsx", sheet = "Genus", col_names = FALSE)
GM <- read_excel("MaxBin.xlsx", sheet = "Genus", col_names = FALSE)
GC <- read_excel("Combined.xlsx", sheet = "Genus", col_names = FALSE)

SV <- read_excel("Vamb.xlsx", sheet = "Species", col_names = FALSE)
SM <- read_excel("MaxBin.xlsx", sheet = "Species", col_names = FALSE)
SC <- read_excel("Combined.xlsx", sheet = "Species", col_names = FALSE)


# Charts
library(VennDiagram)
venn.diagram(
  x = list(DV, DM),
  category.names = c("Vamb ", "MaxBin"),
  filename = 'venn_Domain.png',
  output=TRUE,
  # Circles
  lwd = 2,
  lty = 'blank',
  fill = c("#F29100", "#003361"),
  scaled = TRUE,
  # Numbers
  cex = 1.5,
  fontface = "italic",
  # Set names
  cat.cex = 2,
  cat.fontface = "bold",
  cat.default.pos = "outer",
  cat.dist = c(-0.005, -0.005),
  main = "Domain",
  main.cex = 2
  )
venn.diagram(
  x = list(PV, PM),
  category.names = c("Vamb ", "MaxBin"),
  filename = 'venn_Phylum.png',
  output=TRUE,
  # Circles
  lwd = 2,
  lty = 'blank',
  fill = c("#F29100", "#003361"),
  scaled = TRUE,
  # Numbers
  cex = 1.5,
  fontface = "italic",
  # Set names
  cat.cex = 2,
  cat.fontface = "bold",
  cat.default.pos = "outer",
  cat.dist = c(-0.005, -0.005),
  main = "Phylum",
  main.cex = 2
)
venn.diagram(
  x = list(CV, CM),
  category.names = c("Vamb ", "MaxBin"),
  filename = 'venn_Class.png',
  output=TRUE,
  # Circles
  lwd = 2,
  lty = 'blank',
  fill = c("#F29100", "#003361"),
  scaled = TRUE,
  # Numbers
  cex = 1.5,
  fontface = "italic",
  # Set names
  cat.cex = 2,
  cat.fontface = "bold",
  cat.default.pos = "outer",
  cat.dist = c(-0.005, -0.005),
  main = "Class",
  main.cex = 2
)
venn.diagram(
  x = list(OV, OM),
  category.names = c("Vamb ", "MaxBin"),
  filename = 'venn_Order.png',
  output=TRUE,
  # Circles
  lwd = 2,
  lty = 'blank',
  fill = c("#F29100", "#003361"),
  scaled = TRUE,
  # Numbers
  cex = 1.5,
  fontface = "italic",
  # Set names
  cat.cex = 2,
  cat.fontface = "bold",
  cat.default.pos = "outer",
  cat.dist = c(-0.005, -0.005),
  main = "Order",
  main.cex = 2
)
venn.diagram(
  x = list(FV, FM),
  category.names = c("Vamb ", "MaxBin"),
  filename = 'venn_Family.png',
  output=TRUE,
  # Circles
  lwd = 2,
  lty = 'blank',
  fill = c("#F29100", "#003361"),
  scaled = TRUE,
  # Numbers
  cex = 1.5,
  fontface = "italic",
  # Set names
  cat.cex = 2,
  cat.fontface = "bold",
  cat.default.pos = "outer",
  cat.dist = c(-0.005, -0.005),
  main = "Family",
  main.cex = 2
)
venn.diagram(
  x = list(GV, GM),
  category.names = c("Vamb ", "MaxBin"),
  filename = 'venn_Genus.png',
  output=TRUE,
  # Circles
  lwd = 2,
  lty = 'blank',
  fill = c("#F29100", "#003361"),
  scaled = TRUE,
  # Numbers
  cex = 1.5,
  fontface = "italic",
  # Set names
  cat.cex = 2,
  cat.fontface = "bold",
  cat.default.pos = "outer",
  cat.dist = c(-0.005, -0.005),
  main = "Genus",
  main.cex = 2
)
venn.diagram(
  x = list(SV, SM),
  category.names = c("Vamb ", "MaxBin"),
  filename = 'venn_Species.png',
  output=TRUE,
  # Circles
  lwd = 2,
  lty = 'blank',
  fill = c("#F29100", "#003361"),
  scaled = TRUE,
  # Numbers
  cex = 1.5,
  fontface = "italic",
  # Set names
  cat.cex = 2,
  cat.fontface = "bold",
  cat.default.pos = "outer",
  cat.dist = c(-0.005, -0.005),
  main = "Species",
  main.cex = 2
)
