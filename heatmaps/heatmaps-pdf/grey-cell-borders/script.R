library(RColorBrewer)
library(gplots)
library(lattice)

values <- c(1:5)
fnames <- c("d5-(d)-avgc", "d5-(b)-avgc", "d5-(e)-avgc", "d5-(r)-avgc", "d5-(u)-avgc")
hnames <- c("XFT-2: Decision coordination", "XFT-2: Backlog work on planned sprint goals", "XFT-2: Exchange of missing knowledge", "XFT-2: Resolving technical dependencies", "XFT-2: Unexpected change or interruption")

for(i in values){

filename <- fnames[i]
filenamecsv <- paste(filename, ".csv", sep="")
filenamepdf <- paste("ms2-", filename, sep="")
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
matrix_col_length <- list(0:(ncol(cdata)))
matrix_row_length <- list(0:(nrow(cdata)))

### For clustering
### use as Rowv=dendcompletem
distancem <- dist(cdata)
hclust_completem <- hclust(distancem, method="complete")
dendcompletem <- as.dendrogram(hclust_completem)


filename2 <- paste(filename, "2.pdf", sep="")
filename3 <- paste(filename, "3.pdf", sep="")
filename4 <- paste(filename, "4.pdf", sep="")

#########################################################
### Comment one of the following commands out and draw a heatmap
#########################################################
pdf(filename4, height=10, width=10)
heatmap.2(cdata, trace="none", density.info = "none", scale="none",
			Rowv = rowMeans(cdata) , Colv=TRUE, 
			main = hnames[i], srtCol=30, srtRow=45, col=g12, breaks = breaks,  # Write Column names with 45 degrees angle
			sepwidth=c(0.01, 0.01), sepcolor="grey", colsep=matrix_col_length, rowsep=matrix_col_length, # Specify where to draw borders
			margins = c(9, 11), cexRow=1.5, cexCol=1.5
			)
dev.off()
}