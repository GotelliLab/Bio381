#	Expression analysis of Danio rerio semaphorin6a and plexinA2 morpholino-injected embryos

#Investigation of whole genome gene expression level changes in Danio rerio semaphorin6A and plexinA2 morphant animals, compared to the wild-type strain.

#To access this dataset requires installation of the package BiocManager first, then installation of "GEOquery".

library(BiocManager) #Manage and install packages from Bioconductor
BiocManager::install("GEOquery")
library(GEOquery) #Load in GEOquery package

#Accessing datasets only requires knowing the accession number, in this case "GSE86246". 
gse<-getGEO("GSE86246", GSEMatrix = TRUE )


show(gse) #Expression sets are simply collections of related experiments.

#Accessing sample information, characteristics, etc.
x<-pData(gse[[1]]) #Sample information
#Subsetting information
x<-pData(phenoData(gse[[1]]))[1:5, ]

#Accessing genetic annotation and ID
y<-fData(gse[[1]]) #Gene annotation
#Subsetting information
y<-pData(featureData(gse[[1]]))[1:200, c(1:2)]


#Accessing genetic expression level data
z<-exprs(gse[[1]]) #Expression data
#Subsetting information
z<-exprs(gse[[1]])[1:200,]
