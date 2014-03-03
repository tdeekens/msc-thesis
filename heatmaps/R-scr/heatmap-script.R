#########################################################
### Loading required packages
#########################################################
library(RColorBrewer)
library(gplots)
library(lattice)

#########################################################
### Read data from .csv file
#########################################################
data <- read.csv("../zero-no-headers.csv", comment.char="",header=TRUE, row.names=1, sep=";")

#########################################################
### Save column and row names in a separate variable
#########################################################
rcNames <- list(row.names(data), colnames(data))

#########################################################
### Trransform data into a matrix
#########################################################
cdata <- matrix(as.numeric(unlist(data)), ncol = 16, byrow = TRUE, dimnames = rcNames)

#########################################################
### Color palette to use
#########################################################
mypalette<-brewer.pal(7,"Reds")

#########################################################
### Draw a heatmap
#########################################################
heatmap.2(cdata, Rowv= NULL, symm=TRUE, density.info = "none", xlab = "People", srtCol=45, ylab = "Y People", main = "Heat Map #1", col=mypalette,)

#########################################################
### Draw a levelplot
#########################################################
levelplot(cdata, col.regions=heat.colors, xlab = "People", ylab = "Y People", main = "Heat Map #1")