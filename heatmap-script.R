#########################################################
### Loading required packages
#########################################################
library(RColorBrewer)
library(gplots)
library(lattice)

#########################################################
### Read data from .csv file
#########################################################
data <- read.csv("../annaav/Documents/empty-hm.csv", comment.char="",header=TRUE, row.names=1, sep=";")

#########################################################
### Save column and row names in a separate variable
#########################################################
rcNames <- list(row.names(data), colnames(data))

#########################################################
### Trransform data into a matrix
#########################################################
cdata <- matrix(as.numeric(unlist(data)), ncol = 16, byrow = FALSE, dimnames = rcNames)

#########################################################
### Color palette to use
#########################################################
mypalette<-brewer.pal(7,"Reds")

### Alternative (green to red)
otherpalette <- colorRampPalette(c("green", "yellow", "red"))(n = 299)

#########################################################
### Save the dimension of the matrix in a separate variable
#########################################################
matrix_length <- list(0:(ncol(cdata)))

#########################################################
### Draw a heatmap
#########################################################

heatmap.2(cdata, dendrogram="none", Rowv= NULL,      		  # No dendrogram
			symm=TRUE, 	trace="none", density.info = "none",  # Treat matrix symmetrically
			main = "Heat Map #1", srtCol=45, col=trypalette,  # Write Column names with 45 degrees angle
			sepwidth=c(0.01, 0.01), sepcolor="black", colsep=matrix_length, rowsep=matrix_length # Specify where to draw borders
			)

#########################################################
### Draw a levelplot
#########################################################
levelplot(cdata, col.regions=heat.colors, xlab = "People", ylab = "Y People", main = "Heat Map #1")