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
data <- read.csv("../d5-all-sum.csv", comment.char="",header=TRUE, row.names=1, sep=";")

#########################################################
### Save column and row names in a separate variable
#########################################################
rcNames <- list(row.names(data), colnames(data))

#########################################################
### Trransform data into a matrix
#########################################################
cdata <- matrix(as.numeric(unlist(data)), ncol = 26, nrow=6, byrow = FALSE, dimnames = rcNames)

#########################################################
### Color palette to use
#########################################################
mypalette<-brewer.pal(250,"Reds")

### Alternative (green to red)
otherpalette <- colorRampPalette(c("green", "yellow", "red"))(n = 80)

breaks <-  seq(min(cdata), max(cdata)
cp  <- colorRampPalette(c("white", "green", "yellow", "red"))(length(breaks) - 1)

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

### Take 2 
#heatmap.2(cdata, trace="none", density.info = "none", scale="none",
			Rowv = dendcompletem , Colv=TRUE, 
			main = "Heat Map #1", srtCol=30, srtRow=45, col=cp, breaks = breaks,  # Write Column names with 45 degrees angle
			sepwidth=c(0.01, 0.01), sepcolor="black", colsep=matrix_length, rowsep=matrix_length, # Specify where to draw borders
			margins = c(8, 10)
			)

#########################################################
### Draw a levelplot
#########################################################
#levelplot(cdata, col.regions=heat.colors, xlab = "People", ylab = "Y People", main = "Heat Map #1")


### For clustering
distancem <- dist(cdata)
hclust_completem <- hclust(distancem, method="complete")
dendcompletem <- as.dendrogram(hclust_completem)

# use as Rowv=dendcompletem


#rd<-dist(cdata)
#rc<-hclust(rd)
#dendr <- as.dendrogram(rc)

#cd<-dist(t(cdata))
#cc<-hclust(cd)
#dendc <- as.dendrogram(cc)
#heatmap.2(cdata, trace="none", density.info = "none",
			Rowv = dendr , Colv=dendc, 
			main = "Heat Map #1", srtCol=30, srtRow=45, col=mypalette,  # Write Column names with 45 degrees angle
			sepwidth=c(0.01, 0.01), sepcolor="black", colsep=matrix_length, rowsep=matrix_length, # Specify where to draw borders
			margins = c(8, 10)
			)


# http://mintgene.wordpress.com/2012/01/27/heatmaps-controlling-the-color-representation-with-set-data-range/
#quantile.range <- quantile(cdata, probs = seq(0, 1, 0.01))
#palette.breaks <- seq(quantile.range["5%"], quantile.range["95%"], 0.1)