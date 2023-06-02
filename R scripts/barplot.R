########## Barplots: Family coloured by Phylum (not quite working)
##### Bacteria
# Loading Data
library(readxl)
bar <- read_excel("Pie.xlsx", sheet = "BarB")


phylumsB <- c("Bacteroidota", "Bipolaricaulota", "Chloroflexota", "Cyanobacteria", "Deinococcota", "Myxococcota", "Patescibacteria", "Proteobacteria", "Verrucomicrobiota")

bar$Phylum[!bar$Phylum %in% phylumsB] <- "Unassigned"
bar$Family[!bar$Phylum %in% phylumsB] <- "Unassigned"

bar$Family[bar$Phylum==" Bacteroidota" & 
            !bar$Family %in% c('Balneolaceae','JAAYUY01', "Flavobacteriaceae", "PHOS-HE28", "Schleiferiaceae", "Salinibacteraceae", "Balneolaceae", "JACPUW01", "z n.a. Bacteroidota")] <- "Unassigned"

bar$Family[bar$Phylum=="Bipolaricaulota" &
            !bar$Family %in% c('M55B111')] <- "Unassigned"

bar$Family[bar$Phylum=="Chloroflexota" & 

            !bar$Family %in% c("Chloroflexaceae")] <- "Unassigned"
bar$Family[bar$Phylum=="Cyanobacteria" & 
           !bar$Family %in% c('Rubidibacteraceae')] <- "Unassigned"

bar$Family[bar$Phylum=="Deinococcota" & 
           !bar$Family %in% c('Trueperaceae')] <- "Unassigned"

bar$Family[bar$Phylum=="Myxococcota" & 
          !bar$Family %in% c('Bradymonadaceae')] <- "Unassigned"

bar$Family[bar$Phylum=="Patescibacteria" & 
           !bar$Family %in% c('2-12-FULL-60-25', "SW-6-46-9", "WJLG01", "z n.a. Patescibacteria")] <- "Unassigned"

bar$Family[bar$Phylum=="Proteobacteria" & 
           !bar$Family %in% c('Nitrococcaceae', "Rhodobacteraceae", "Sphingomonadaceae", "Micavibrionaceae", "Burkholderiaceae")] <- "Unassigned"

bar$Family[bar$Phylum=="Verrucomicrobiota" & 
           !bar$Family %in% c('DSM-45221')] <- "Unassigned"


# selecting data and mutate data
library(forcats)
library(dplyr)
bar2 <- select(bar, Workflow, Phylum, Family) %>%
  mutate(Phylum=factor(Phylum, levels=c(phylumsB, "Unassigned")),
         Family=fct_reorder(Family, 10*as.integer(Phylum) + grepl("Unassigned", Family)))

barP2 <- select(bar, Workflow, Phylum)
  

# Colour Function
ColourPalleteMulti <- function(df, group, subgroup){
  
  # Find how many colour categories to create and the number of colours in each
  categories <- aggregate(as.formula(paste(subgroup, group, sep="~" )), df, function(x) length(unique(x)))
  category.start <- (scales::hue_pal(l = 90)(nrow(categories))) # Set the top of the colour pallete
  category.end  <- (scales::hue_pal(l = 30)(nrow(categories))) # set the bottom
  
  # Build Colour pallette
  colours <- unlist(lapply(1:nrow(categories),
                           function(i){
                             colorRampPalette(colors = c(category.start[i], category.end[i]))(categories[i,2])}))
  return(colours)
}


coloursB <- ColourPalleteMulti(bar, "Phylum", "Family")

# Plots
library(ggplot2)
ggplot(barP2, aes(x=Workflow, fill = Phylum)) + 
  geom_bar(position="fill") + 
  ggtitle("   c)") +
  scale_fill_manual(values = c("#C0574D", "#FFD64C", "#D7EF16", "#55FF8A", "#00FFE4", "#6F917C", "#3A78D5", "#C85ED8", "#FF55DD")) +
  theme_classic() +  
  scale_y_continuous(labels = scales::percent_format()) +
  guides(fill=guide_legend(title="Phylum", title.theme = element_text(size = 15))) + 
  theme(axis.title.y = element_blank(), axis.title.x = element_blank(),
        legend.text = element_text(size=15), axis.text.x = element_text(size=15))

library(ggplot2)
ggplot(bar2, aes(x=Workflow, fill = Family)) + 
  geom_bar(position="fill") + 
  ggtitle("   d)") +
  scale_fill_manual("", values=coloursB,) +
  theme_classic() +  
  scale_y_continuous(labels = scales::percent_format()) +
  guides(fill=guide_legend(title="Family", title.theme = element_text(size = 15))) + 
  theme(axis.title.y = element_blank(), axis.title.x = element_blank(), 
        legend.text = element_text(size=15), axis.text.x = element_text(size=9))



##### Archaea
# Loading Data
library(readxl)
barA <- read_excel("Pie.xlsx", sheet = "BarA")


phylumsA <- c("Halobacteriota", "Nanoarchaeota", "Nanohaloarchaeota")

barA$Phylum[!barA$Phylum %in% phylumsA] <- "Unassigned"
barA$Family[!barA$Phylum %in% phylumsA] <- "Unassigned"

barA$Family[barA$Phylum==" Halobacteriota" & 
             !barA$Family %in% c('Haloarculaceae','Haloferacaceae', "Natrialbaceae", "Salinarchaeaceae", "Halobacteriaceae","QS-1-68-20", "SW-7-71-33", "unassigned Halobacteriota")] <- "Unassigned"

barA$Family[barA$Phylum=="Nanoarchaeota" &
             !barA$Family %in% c('21-14-0-10-32-9')] <- "Unassigned"

barA$Family[barA$Phylum=="Nanohaloarchaeota" & 
             !barA$Family %in% c("Nanosalinaceae", "z n.a. Nanohaloarchaeota")] <- "Unassigned"


# selecting data and mutate/group data
library(forcats)
library(dplyr)
barA2 <- select(barA, Workflow, Phylum, Family) %>%
  mutate(Phylum=factor(Phylum, levels=c(phylumsA, "Unassigned")),
         Family=fct_reorder(Family, 10*as.integer(Phylum) + grepl("Unassigned", Family)))

barPA2 <- select(barA, Workflow, Phylum)


# Colour Function
ColourPalleteMulti <- function(df, group, subgroup){
  
  # Find how many colour categories to create and the number of colours in each
  categories <- aggregate(as.formula(paste(subgroup, group, sep="~" )), df, function(x) length(unique(x)))
  category.start <- (scales::hue_pal(l = 90)(nrow(categories))) # Set the top of the colour pallete
  category.end  <- (scales::hue_pal(l = 30)(nrow(categories))) # set the bottom
  
  # Build Colour pallette
  colours <- unlist(lapply(1:nrow(categories),
                           function(i){
                             colorRampPalette(colors = c(category.start[i], category.end[i]))(categories[i,2])}))
  return(colours)
}


coloursA <- ColourPalleteMulti(bar, "Phylum", "Family")

# Plots
library(ggplot2)
ggplot(barPA2, aes(x=Workflow, fill = Phylum)) + 
  geom_bar(position="fill") + 
  ggtitle("   a)") +
  scale_fill_manual(values = c("#C0574D", "#FFD64C", "#D7EF16", "#55FF8A", "#00FFE4", "#6F917C", "#3A78D5", "#C85ED8", "#FF55DD")) +
  theme_classic() +  
  scale_y_continuous(labels = scales::percent_format()) +
  guides(fill=guide_legend(title="Phylum", title.theme = element_text(size = 15))) + 
  theme(axis.title.y = element_blank(), axis.title.x = element_blank(),
        legend.text = element_text(size=15), axis.text.x = element_text(size=15))

library(ggplot2)
ggplot(barA2, aes(x=Workflow, fill = Family)) + 
  geom_bar(position="fill") + 
  ggtitle("   b)") +
  scale_fill_manual("", values=coloursA,) +
  theme_classic() +  
  scale_y_continuous(labels = scales::percent_format()) +
  guides(fill=guide_legend(title="Family", title.theme = element_text(size = 17))) + 
  theme(axis.title.y = element_blank(), axis.title.x = element_blank(),
        legend.text = element_text(size=15), axis.text.x = element_text(size=15))
