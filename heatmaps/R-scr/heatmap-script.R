#########################################################
### Loading required packages
#########################################################
library(RColorBrewer)
library(gplots)
library(lattice)

#########################################################
### Read data from .csv file
### Change the path to your data file
#########################################################
data <- read.csv("../d4-all-avgd.csv", comment.char="",header=TRUE, row.names=1, sep=";")

#########################################################
### Save column and row names in a separate variable
#########################################################
rcNames <- list(row.names(data), colnames(data))

#########################################################
### Trransform data into a matrix
#########################################################
cdata <- matrix(as.numeric(unlist(data)), ncol = 7, nrow=7, byrow = FALSE, dimnames = rcNames)

#########################################################
### Color palette to use
#########################################################
mypalette<-brewer.pal(40,"Reds")

### Alternative (green to red)
otherpalette <- colorRampPalette(c("green", "yellow", "red"))(n = 34)

#########################################################
### Save the dimension of the matrix in a separate variable
#########################################################
matrix_length <- list(0:(ncol(cdata)))

#########################################################
### Comment one of the following commands out and draw a heatmap
#########################################################

heatmap.2(cdata, trace="none", density.info = "none",
			dendrogram="both",
			main = "Heat Map #1", srtCol=45, col=mypalette,  # Write Column names with 45 degrees angle
			sepwidth=c(0.01, 0.01), sepcolor="black", colsep=matrix_length, rowsep=matrix_length # Specify where to draw borders
			)
### Take 2 on clustering
#heatmap.2(cdata, trace="none", density.info = "none",
			Rowv = dendcompletem, Colv=TRUE, 
			main = "Heat Map #1", srtCol=45, col=mypalette,  # Write Column names with 45 degrees angle
			sepwidth=c(0.01, 0.01), sepcolor="black", colsep=matrix_length, rowsep=matrix_length # Specify where to draw borders
			)
#########################################################
### Draw a levelplot
#########################################################
#levelplot(cdata, col.regions=heat.colors, xlab = "People", ylab = "Y People", main = "Heat Map #1")


###
distancem <- dist(cdata)
hclust_completem <- hclust(distancem, method="complete")
dendcompletem <- as.dendrogram(hclust_completem)
Rowv=dendcompletem