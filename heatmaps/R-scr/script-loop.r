#########################################################
### Loading required packages
#########################################################
library(RColorBrewer)
library(gplots)
library(lattice)

values <- c("d3-[d]-avgc", "d3-[b]-avgc", "d3-[e]-avgc", "d3-[r]-avgc", "d3-[u,r]-avgc", "d3-[u]-avgc", "d3-avgc", "d3-avgd")

for(i in values){

filename <- i
filenamecsv <- paste(filename, ".csv", sep="")
filenamepdf <- paste(filename, ".pdf", sep="")
#########################################################
### Read data from .csv file
### Change the path to your data file
#########################################################
path <- paste("../annaav/Documents/", filenamecsv, sep="")
data <- read.csv(path, comment.char="",header=TRUE, row.names=1, sep=";")

#########################################################
### Save column and row names in a separate variable
#########################################################
rcNames <- list(row.names(data), colnames(data))

#########################################################
### Trransform data into a matrix
#########################################################
cdata <- matrix(as.numeric(unlist(data)), ncol = ncol(data), nrow=nrow(data), byrow = FALSE, dimnames = rcNames)

#########################################################
### Color palette to use
#########################################################
breaks <-  seq(min(cdata), max(cdata), by=0.01)
cp  <- colorRampPalette(c("white", "red"))(length(breaks) - 1)

g1 = colorpanel( sum( breaks[-1]<3 ), "white", "green", "orange" )
g2 = colorpanel( sum( breaks[-1]>=3 ), "orange", "red" )
g12 = c(g1,g2)

#########################################################
### Save the dimension of the matrix in a separate variable
#########################################################
matrix_length <- list(0:(ncol(cdata)))

### For clustering
### use as Rowv=dendcompletem
distancem <- dist(cdata)
hclust_completem <- hclust(distancem, method="complete")
dendcompletem <- as.dendrogram(hclust_completem)

#########################################################
### Comment one of the following commands out and draw a heatmap
#########################################################

pdf(filenamepdf, height=10, width=10)
heatmap.2(cdata, trace="none", density.info = "none", dendrogram="none",
			main = filename, srtCol=30, srtRow=45, col=g12, breaks = breaks,  # Write Column names with 45 degrees angle
			sepwidth=c(0.01, 0.01), sepcolor="black", colsep=matrix_length, rowsep=matrix_length, margins = c(8, 10) # Specify where to draw borders
			)
dev.off()