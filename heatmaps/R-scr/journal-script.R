library(RColorBrewer)
library(gplots)
library(lattice)

values <- c("d5-(b)-avgc", "d5-(d)-avgc", "d5-(e)-avgc", "d5-(r)-avgc", "d5-(u)-avgc")
names <- c("Backlog work on planned sprint goals", "Decision coordination", "Exchange of missing knowledge", "Resolving technical dependencies", "Unexpected change or interruption")

for(i in 1:5){

filename <- values[i]
filenamecsv <- paste(filename, ".csv", sep="")
filenamepdf <- paste(filename, ".pdf", sep="")

path <- paste("../annaav/Documents/", filenamecsv, sep="")
data <- read.csv(path, comment.char="",header=TRUE, row.names=1, sep=";")
rcNames <- list(row.names(data), colnames(data))

cdata <- matrix(as.numeric(unlist(data)), ncol = ncol(data), nrow=nrow(data), byrow = FALSE, dimnames = rcNames)

breaks <-  seq(min(cdata), max(cdata), by=0.01)

g1 = colorpanel( sum( breaks[-1]<3 ), "white", "green", "orange" )
g2 = colorpanel( sum( breaks[-1]>=3 ), "orange", "red" )
g12 = c(g1,g2)

matrix_col_length <- list(0:(ncol(cdata)))
matrix_row_length <- list(0:(nrow(cdata)))

pdf(filenamepdf, height=10, width=10)
heatmap.2(cdata, breaks = breaks, col=g12, srtCol=90, sepwidth=c(0.01, 0.01), trace="none", colsep=matrix_col_length, rowsep=matrix_col_length, sepcolor="grey", density.info="none", scale="none", dendrogram="none", Rowv=FALSE, Colv=FALSE, cexRow=0.9, cexCol=0.9, margins=c(9,11), key=FALSE, lwid=c(0.3,1), lhei= c(0.3,1) )
dev.off()

}