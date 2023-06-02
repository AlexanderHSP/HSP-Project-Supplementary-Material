### loading libraries
library(Nonpareil)
pdf("Nonpareil.pdf")

#loading data
samples <- read.table('samples.txt', sep='\t', header=TRUE, as.is=TRUE);
attach(samples);
nps <- Nonpareil.set(File, col=Col, labels=Name, plot.opts=list(plot.observed=FALSE));
detach(samples);
a <-summary(nps);
data_a <- as.data.frame(a)


# correlation between diversity and total coverage of mapping
coverage <- read.table('total coverage.txt', sep='\t', header=TRUE, row.names = 1);
test <- cor.test(coverage$total.coverage, data_a$diversity, method = "spearman")  
test


# plots 
leg.txt = c("R = -0.0427, p-value = 0.8324")
plot(data_a$diversity,coverage$total.coverage,
     xlab = "Nonpareil diversity index", ylab = "Total MAG abundance",
     type="p", pch=19, )
     
text(13.79, 0.4, substitute(paste(bold("R = -0.0427"))), cex = 1.1, )
text(14.05, 0.35, substitute(paste(bold("p-value = 0.8324"))), cex = 1.1 )
text(13.2, 0.5934766, labels = "US_BW", cex = 0.9)
text(18.6, 0.2075777, labels = "ES_CO1", cex = 0.9)
text(17.9, 0.5494295, labels = "ES_CO2", cex = 0.9)
text(17.5, 0.4580314, labels = "US_Lake", cex = 0.9)

dev.off()